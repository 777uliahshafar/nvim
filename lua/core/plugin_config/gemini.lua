-- =========================================================
-- Gemini.nvim Configuration
-- =========================================================
-- =========================================================
-- HELPER: Ambil Visual Selection secara langsung
-- Tidak bergantung pada `lines` dari gemini.nvim
-- =========================================================
local function get_visual_selection(bufnr)
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"

  local start_row = start_pos[2]
  local start_col = start_pos[3]

  local end_row = end_pos[2]
  local end_col = end_pos[3]

  -- Tidak ada selection
  if start_row == 0 or end_row == 0 then
    return nil
  end

  -- Pastikan posisi awal <= posisi akhir
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  local visual_mode = vim.fn.visualmode()

  -- =======================================================
  -- LINEWISE VISUAL: V
  -- =======================================================
  if visual_mode == "V" then
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)

    return table.concat(lines, "\n")
  end

  -- =======================================================
  -- BLOCKWISE VISUAL: <C-v>
  -- =======================================================
  if visual_mode == "\22" then
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)

    local selected = {}

    for _, line in ipairs(lines) do
      local part = line:sub(start_col, end_col)
      table.insert(selected, part)
    end

    return table.concat(selected, "\n")
  end

  -- =======================================================
  -- CHARWISE VISUAL: v
  -- =======================================================
  local selected = vim.api.nvim_buf_get_text(bufnr, start_row - 1, start_col - 1, end_row - 1, end_col, {})

  if #selected == 0 then
    return nil
  end

  return table.concat(selected, "\n")
end

-- =========================================================
-- HELPER: Prompt untuk Visual Selection
-- =========================================================
local function build_selected_text_prompt(bufnr, objective, output_instruction)
  local text = get_visual_selection(bufnr)

  if not text or text == "" then
    return nil
  end

  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  local prompt = "Context:\n\n"
    .. "```"
    .. filetype
    .. "\n"
    .. text
    .. "\n```\n\n"
    .. "Objective: "
    .. objective
    .. "\n\n"
    .. "Output: "
    .. output_instruction

  return prompt
end
-- =========================================================
-- HELPER: Ambil informasi kalimat pada posisi cursor
-- =========================================================
local function get_sentence_info(bufnr)
  local cursor = vim.api.nvim_win_get_cursor(0)
  local row = cursor[1]
  local col = cursor[2] + 1 -- convert to 1-based index

  local line_text = vim.api.nvim_buf_get_lines(bufnr, row - 1, row, false)[1] or ""

  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  local sentence_start = 1
  local sentence_end = #line_text

  -- -------------------------------------------------------
  -- Cari batas awal kalimat
  -- -------------------------------------------------------
  for i = col - 1, 1, -1 do
    local char = line_text:sub(i, i)

    if char:match "[%.%!%?]" then
      sentence_start = i + 1
      break
    end
  end

  -- -------------------------------------------------------
  -- Cari batas akhir kalimat
  -- -------------------------------------------------------
  for i = col, #line_text do
    local char = line_text:sub(i, i)

    if char:match "[%.%!%?]" then
      sentence_end = i
      break
    end
  end

  local sentence = line_text:sub(sentence_start, sentence_end):match "^%s*(.-)%s*$"

  return {
    sentence = sentence,
    filetype = filetype,
    line_text = line_text,
    sentence_start = sentence_start,
    sentence_end = sentence_end,
    row = row,
    col = col,
  }
end

-- =========================================================
-- HELPER: Ambil dua kalimat yang berdekatan
-- Digunakan untuk Connect Sentences
-- =========================================================
local function get_two_sentences(bufnr)
  local info = get_sentence_info(bufnr)

  local line_text = info.line_text
  local start_pos = info.sentence_start
  local end_pos = info.sentence_end

  local first_sentence
  local second_sentence

  -- -------------------------------------------------------
  -- Coba ambil kalimat setelah kalimat cursor
  -- -------------------------------------------------------
  local remaining = line_text:sub(end_pos + 1)

  local next_start = remaining:find "%S"
  local next_sentence_start

  if next_start then
    next_sentence_start = end_pos + next_start

    for i = next_sentence_start, #line_text do
      local char = line_text:sub(i, i)

      if char:match "[%.%!%?]" then
        local next_sentence_end = i

        second_sentence = line_text:sub(next_sentence_start, next_sentence_end):match "^%s*(.-)%s*$"

        break
      end
    end
  end

  -- -------------------------------------------------------
  -- Jika ada kalimat berikutnya:
  -- current + next
  -- -------------------------------------------------------
  if second_sentence then
    first_sentence = line_text:sub(start_pos, end_pos):match "^%s*(.-)%s*$"
  else
    -- -----------------------------------------------------
    -- Jika tidak ada kalimat berikutnya:
    -- ambil kalimat sebelumnya + current
    -- -----------------------------------------------------
    local previous_text = line_text:sub(1, start_pos - 1)

    local previous_end = previous_text:find "[%.%!%?]%s*$"

    if previous_end then
      local previous_start = 1

      for i = previous_end - 1, 1, -1 do
        local char = previous_text:sub(i, i)

        if char:match "[%.%!%?]" then
          previous_start = i + 1
          break
        end
      end

      first_sentence = previous_text:sub(previous_start, previous_end):match "^%s*(.-)%s*$"

      second_sentence = line_text:sub(start_pos, end_pos):match "^%s*(.-)%s*$"
    else
      first_sentence = nil
      second_sentence = line_text:sub(start_pos, end_pos):match "^%s*(.-)%s*$"
    end
  end

  return first_sentence, second_sentence, info.filetype
end

-- =========================================================
-- HELPER: Membuat prompt untuk satu kalimat
-- =========================================================
local function build_sentence_prompt(bufnr, objective, output_instruction)
  local info = get_sentence_info(bufnr)

  local prompt = "Context:\n\n"
    .. "```"
    .. info.filetype
    .. "\n"
    .. info.sentence
    .. "\n```\n\n"
    .. "Objective: "
    .. objective
    .. "\n\n"
    .. "Output: "
    .. output_instruction

  return prompt
end

-- =========================================================
-- HELPER: Membuat prompt untuk dua kalimat
-- =========================================================
local function build_two_sentence_prompt(bufnr, objective, output_instruction)
  local first, second, filetype = get_two_sentences(bufnr)

  if not first or not second then
    local info = get_sentence_info(bufnr)

    return string.format(
      "Context:\n\n```%s\n%s\n```\n\n" .. "Objective: %s\n\n" .. "Output: %s",
      filetype,
      info.sentence,
      objective,
      output_instruction
    )
  end

  local context = first .. "\n\n" .. second

  local prompt = "Context:\n\n"
    .. "```"
    .. filetype
    .. "\n"
    .. context
    .. "\n```\n\n"
    .. "Objective: "
    .. objective
    .. "\n\n"
    .. "Output: "
    .. output_instruction

  return prompt
end

-- =========================================================
-- HELPER: Membuat prompt untuk kode yang dipilih
-- =========================================================
local function build_code_prompt(lines, bufnr, objective, output_instruction)
  local code = vim.fn.join(lines or {}, "\n")

  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  local prompt = "Context:\n\n" .. "```" .. filetype .. "\n" .. code .. "\n```\n\n" .. "Objective: " .. objective

  if output_instruction then
    prompt = prompt .. "\n\nOutput: " .. output_instruction
  end

  return prompt
end

-- =========================================================
-- GEMINI SETUP
-- =========================================================
require("gemini").setup {
  model_config = {
    model_id = "gemini-2.5-flash",
    temperature = 0.10,
    top_k = 128,
    response_mime_type = "text/plain",
  },

  hints = {
    enabled = false,
  },

  completion = {
    enabled = false,
  },

  -- =======================================================
  -- INSTRUCTION
  -- =======================================================
  instruction = {
    enabled = true,

    menu_key = "<Leader><Leader><Leader>g",

    prompts = {

      -- ===================================================
      -- WRITING
      -- ===================================================
      {
        name = "Connect Sentences",
        command_name = "GeminiConnectSentences",
        menu = "Connect Sentences 🔗",

        get_prompt = function(_, bufnr)
          return build_two_sentence_prompt(
            bufnr,

            "Connect the two sentences above so they form a cohesive, natural, and logically flowing paragraph. "
              .. "Improve the transition between ideas while preserving the original meaning, tone, and important information.",

            "ONLY the revised text. Do not provide explanations, comments, or quotation marks."
          )
        end,
      },
      {
        name = "Paraphrase",
        command_name = "GeminiParaphrase",
        menu = "Paraphrase ✍️",

        get_prompt = function(_, bufnr)
          return build_sentence_prompt(
            bufnr,

            "Paraphrase the sentence above using different wording and sentence structure. "
              .. "Preserve the original meaning, tone, clarity, and important information.",

            "ONLY a few paraphrased versions. Do not provide explanations or quotation marks."
          )
        end,
      },
      {
        name = "Refine Sentence ",
        command_name = "GeminiRefineSentence",
        menu = "Refine Sentence ✨",

        get_prompt = function(_, bufnr)
          return build_sentence_prompt(
            bufnr,

            "Refine the writing above to convey its ideas with greater precision and impact. "
              .. "Improve clarity, logical flow, transitions, and conciseness. "
              .. "Remove unnecessary wordiness and ambiguity without changing the original meaning.",

            "ONLY the refined sentence. Do not provide explanations or quotation marks."
          )
        end,
      },

      {
        name = "Translate to English",
        command_name = "GeminiTranslateEnglish",
        menu = "Translate to English 🌐",

        get_prompt = function(_, bufnr)
          return build_sentence_prompt(
            bufnr,

            "Translate the sentence above into natural, accurate, and fluent English. "
              .. "Preserve the original meaning, tone, context, and level of formality.",

            "ONLY the English translation. Do not provide explanations or quotation marks."
          )
        end,
      },
      -- ===================================================
      -- WRITING - VISUAL SELECTION
      -- ===================================================

      {
        name = "Summarize",
        command_name = "GeminiSummarize",
        menu = "Summarize 📝",

        get_prompt = function(_, bufnr)
          return build_selected_text_prompt(
            bufnr,

            "Summarize the selected text concisely while preserving "
              .. "its main ideas, important facts, essential arguments, "
              .. "and logical relationships. Remove repetition and "
              .. "unnecessary details.",

            "ONLY the summary. Do not provide explanations, commentary, " .. "introductions, or quotation marks."
          )
        end,
      },

      {
        name = "Grammar",
        command_name = "GeminiGrammar",
        menu = "Grammar & Spelling ✅",

        get_prompt = function(_, bufnr)
          return build_selected_text_prompt(
            bufnr,

            "Correct all spelling, grammar, punctuation, word-choice, "
              .. "and sentence-structure errors in the selected text. "
              .. "Preserve the original meaning, tone, organization, "
              .. "and important terminology.",

            "ONLY the corrected text. Show corrections in **bold** "
              .. "so the changes are clearly visible. "
              .. "Do not provide explanations or quotation marks."
          )
        end,
      },

      {
        name = "Refine Writing",
        command_name = "GeminiRefine",
        menu = "Refine Writing ✨",

        get_prompt = function(_, bufnr)
          return build_selected_text_prompt(
            bufnr,

            "Refine the selected text to make the writing clearer, "
              .. "more precise, coherent, logical, concise, and impactful. "
              .. "Improve transitions between ideas, remove unnecessary "
              .. "wordiness, reduce ambiguity, and strengthen the overall "
              .. "flow without changing the original meaning.",

            "ONLY the refined text. Do not provide explanations, " .. "commentary, or quotation marks."
          )
        end,
      },

      {
        name = "Academic Outline",
        command_name = "GeminiOutline",
        menu = "Academic Outline 📚",

        get_prompt = function(_, bufnr)
          return build_selected_text_prompt(
            bufnr,

            "Develop a clear and logical academic outline based on "
              .. "the selected text. Identify the central topic or "
              .. "research question, then organize the content into "
              .. "appropriate main sections and subsections. Ensure "
              .. "that the structure supports a coherent academic argument.",

            "ONLY the outline. Use a hierarchical structure with "
              .. "main sections and subsections. Do not provide "
              .. "explanations before or after the outline."
          )
        end,
      },

      -- ===================================================
      -- PROGRAMMING
      -- ===================================================

      {
        name = "Unit Test",
        command_name = "GeminiUnitTest",
        menu = "Unit Test 🚀",

        get_prompt = function(lines, bufnr)
          return build_code_prompt(
            lines,
            bufnr,

            "Write appropriate unit tests for the code above. "
              .. "Cover the main behavior, important edge cases, and likely failure scenarios.",

            "ONLY the test code unless additional context is absolutely necessary."
          )
        end,
      },

      {
        name = "Code Review",
        command_name = "GeminiCodeReview",
        menu = "Code Review 📜",

        get_prompt = function(lines, bufnr)
          return build_code_prompt(
            lines,
            bufnr,

            "Perform a thorough code review of the code above. "
              .. "Identify bugs, logical problems, edge cases, maintainability issues, security concerns, "
              .. "performance problems, and opportunities for improvement. "
              .. "Be precise and sincere in your comments.",

            "Provide a structured review with actionable recommendations."
          )
        end,
      },

      {
        name = "Code Explain",
        command_name = "GeminiCodeExplain",
        menu = "Code Explain 💡",

        get_prompt = function(lines, bufnr)
          return build_code_prompt(
            lines,
            bufnr,

            "Explain the code above clearly and thoroughly. "
              .. "Describe what it does, how the main parts work, the flow of execution, "
              .. "important variables or functions, and any noteworthy behavior.",

            "Provide a clear explanation suitable for someone learning this code."
          )
        end,
      },
    },
  },

  -- =======================================================
  -- TASK MODE
  -- =======================================================
task = {
  enabled = true,

  get_system_text = function()
    return "You are an academic research assistant who helps the user "
      .. "research, write, edit, analyze, and improve academic documents."
      .. "\n\n"
      .. "Academic writing rules:"
      .. "\n"
      .. "* Maintain academic rigor, clarity, precision, coherence, and logical structure."
      .. "\n"
      .. "* Preserve the original meaning unless a change is explicitly requested."
      .. "\n"
      .. "* Use formal and objective academic language."
      .. "\n"
      .. "* Avoid unsupported claims, fabricated facts, citations, references, "
      .. "data, quotations, or sources."
      .. "\n"
      .. "* Clearly distinguish facts, interpretations, assumptions, and suggestions."
      .. "\n"
      .. "* Improve argumentation and logical connections when appropriate."
      .. "\n"
      .. "* Preserve important technical terminology and domain-specific meaning."
      .. "\n"
      .. "* When editing LaTeX, preserve valid LaTeX syntax, commands, environments, "
      .. "references, citations, labels, and formatting unless modification is requested."
      .. "\n"
      .. "* Respond in the dominant language of the Current Opened File, "
      .. "not the language used in the user's task instruction."
      .. "\n"
      .. "* Do not add explanations or commentary unless the task requires them."
  end,

  get_prompt = function(bufnr, user_prompt)
    local buffers = vim.api.nvim_list_bufs()
    local file_contents = {}

    for _, b in ipairs(buffers) do
      if vim.api.nvim_buf_is_loaded(b) then
        local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
        local filename = vim.fn.fnamemodify(
          vim.api.nvim_buf_get_name(b), ":."
        )
        local filetype = vim.api.nvim_get_option_value(
          "filetype", { buf = b }
        )

        table.insert(
          file_contents,
          string.format(
            "`%s`:\n\n```%s\n%s\n```",
            filename ~= "" and filename or "[No Name]",
            filetype,
            table.concat(lines, "\n")
          )
        )
      end
    end

    local current_filepath = vim.fn.fnamemodify(
      vim.api.nvim_buf_get_name(bufnr), ":."
    )

    return table.concat({
      table.concat(file_contents, "\n\n"),
      "Current Opened File: "
        .. (current_filepath ~= "" and current_filepath or "[No Name]"),
      "Response Language: Use the dominant language of the Current Opened File.",
      "Task: " .. user_prompt,
    }, "\n\n")
  end,
},

-- =========================================================
-- AUTO-COMMAND
-- Otomatis ubah tab/window Gemini menjadi
-- Vertical Split di sebelah kanan
-- =========================================================

vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("GeminiVerticalSplit", { clear = true }),

  callback = function(args)
    local ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })

    local buf_name = vim.api.nvim_buf_get_name(args.buf)

    if ft == "gemini" or buf_name:match "gemini" then
      vim.schedule(function()
        -- Tutup tab tambahan yang dibuat Gemini
        if vim.fn.tabpagenr "$" > 1 and vim.fn.tabpagenr() > 1 then
          vim.cmd "tabclose"
        end

        -- Pindahkan window ke sisi paling kanan
        vim.cmd "wincmd L"

        -- Atur lebar Gemini
        vim.api.nvim_win_set_width(0, 60)
      end)
    end
  end,
})
