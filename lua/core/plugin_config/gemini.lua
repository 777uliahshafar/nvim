-- =========================================================
-- Gemini.nvim Configuration
-- =========================================================
-- =========================================================
-- Gemini Completion Toggle
-- =========================================================
local gemini_completion_enabled = false

local gemini_completion_ns = vim.api.nvim_create_namespace "gemini_completion"

vim.api.nvim_create_user_command("GeminiToggleCompletion", function()
  gemini_completion_enabled = not gemini_completion_enabled

  if not gemini_completion_enabled then
    -- Hapus completion yang sedang tampil
    vim.api.nvim_buf_clear_namespace(0, gemini_completion_ns, 0, -1)
  end

  vim.cmd "redraw"

  vim.notify("Gemini Completion: " .. (gemini_completion_enabled and "ON" or "OFF"), vim.log.levels.INFO)
end, {
  desc = "Toggle Gemini Completion",
})
-- =========================================================
-- HELPER: Ambil Visual Selection secara langsung
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

  -- LINEWISE VISUAL: V
  if visual_mode == "V" then
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)
    return table.concat(lines, "\n")
  end

  -- BLOCKWISE VISUAL: <C-v>
  if visual_mode == "\22" then
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, end_row, false)
    local selected = {}
    for _, line in ipairs(lines) do
      local part = line:sub(start_col, end_col)
      table.insert(selected, part)
    end
    return table.concat(selected, "\n")
  end

  -- CHARWISE VISUAL: v
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

  return string.format(
    "Context:\n\n```%s\n%s\n```\n\nObjective: %s\n\nOutput: %s",
    filetype,
    text,
    objective,
    output_instruction
  )
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

  -- Cari batas awal kalimat
  for i = col - 1, 1, -1 do
    local char = line_text:sub(i, i)
    if char:match "[%.%!%?]" then
      sentence_start = i + 1
      break
    end
  end

  -- Cari batas akhir kalimat
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
-- =========================================================
local function get_two_sentences(bufnr)
  local info = get_sentence_info(bufnr)
  local line_text = info.line_text
  local start_pos = info.sentence_start
  local end_pos = info.sentence_end

  local first_sentence
  local second_sentence

  local remaining = line_text:sub(end_pos + 1)
  local next_start = remaining:find "%S"
  local next_sentence_start

  if next_start then
    next_sentence_start = end_pos + next_start
    for i = next_sentence_start, #line_text do
      local char = line_text:sub(i, i)
      if char:match "[%.%!%?]" then
        second_sentence = line_text:sub(next_sentence_start, i):match "^%s*(.-)%s*$"
        break
      end
    end
  end

  if second_sentence then
    first_sentence = line_text:sub(start_pos, end_pos):match "^%s*(.-)%s*$"
  else
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
-- HELPER: Prompt Builders
-- =========================================================
local function build_sentence_prompt(bufnr, objective, output_instruction)
  local info = get_sentence_info(bufnr)
  return string.format(
    "Context:\n\n```%s\n%s\n```\n\nObjective: %s\n\nOutput: %s",
    info.filetype,
    info.sentence,
    objective,
    output_instruction
  )
end

local function build_two_sentence_prompt(bufnr, objective, output_instruction)
  local first, second, filetype = get_two_sentences(bufnr)

  if not first or not second then
    local info = get_sentence_info(bufnr)
    return string.format(
      "Context:\n\n```%s\n%s\n```\n\nObjective: %s\n\nOutput: %s",
      filetype,
      info.sentence,
      objective,
      output_instruction
    )
  end

  local context = first .. "\n\n" .. second
  return string.format(
    "Context:\n\n```%s\n%s\n```\n\nObjective: %s\n\nOutput: %s",
    filetype,
    context,
    objective,
    output_instruction
  )
end

local function build_code_prompt(lines, bufnr, objective, output_instruction)
  local code = vim.fn.join(lines or {}, "\n")
  local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

  local prompt = string.format("Context:\n\n```%s\n%s\n```\n\nObjective: %s", filetype, code, objective)
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
    enabled = true,

    blacklist_filetypes = {
      "help",
      "qf",
      "json",
      "yaml",
      "toml",
      "xml",
    },

    blacklist_filenames = {
      ".env",
    },

    completion_delay = 380,
    insert_result_key = "<S-Tab>",
    move_cursor_end = true,

    can_complete = function()
      return gemini_completion_enabled and vim.fn.pumvisible() ~= 1
    end,

    get_system_text = function()
      return "You are an academic writing assistant."
        .. "\n* Continue the document naturally at the cursor location marked by <cursor></cursor>."
        .. "\n* Use the surrounding document as the primary context."
        .. "\n* Follow the document's dominant language, tone, terminology, "
        .. "style, and level of formality."
        .. "\n* Do not determine the response language from the user's instruction."
        .. "\n* Continue the existing idea instead of changing its direction."
        .. "\n* Do not repeat words, phrases, or sentences that already exist around the cursor."
        .. "\n* Prefer concise, natural, and academically appropriate continuations."
        .. "\n* Do not invent facts, citations, references, statistics, quotations, "
        .. "or unsupported claims."
        .. "\n* When the document is written in LaTeX, preserve valid LaTeX syntax, "
        .. "commands, environments, labels, references, and citations."
        .. "\n* Return only the suggested continuation without explanation or commentary."
    end,

    get_prompt = function(bufnr, pos)
      local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

      local abs_path = vim.api.nvim_buf_get_name(bufnr)

      local filename = vim.fn.fnamemodify(abs_path, ":.")

      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

      local line = pos[1]
      local col = pos[2]

      local target_line = lines[line]

      if not target_line then
        return nil
      end

      lines[line] = target_line:sub(1, col) .. "<cursor></cursor>" .. target_line:sub(col + 1)

      local document = vim.fn.join(lines, "\n")

      local prompt = "Below is the content of the current academic document."
        .. "\n\n"
        .. "File: "
        .. (filename ~= "" and filename or "[No Name]")
        .. "\n"
        .. "Filetype: "
        .. filetype
        .. "\n\n"
        .. "```"
        .. filetype
        .. "\n"
        .. document
        .. "\n```\n\n"
        .. "Suggest the most natural continuation at <cursor></cursor>."
        .. "\n"
        .. "Return ONLY the continuation text."

      return prompt
    end,
  },

  instruction = {
    enabled = true,
    menu_key = "<Leader><Leader><Leader>g",

    prompts = {
      {
        name = "Connect Sentences",
        command_name = "GeminiConnectSentences",
        menu = "Connect Sentences 🔗",
        get_prompt = function(_, bufnr)
          return build_two_sentence_prompt(
            bufnr,
            "Connect the two sentences above so they form a cohesive, natural, and logically flowing paragraph. Improve the transition between ideas while preserving the original meaning, tone, and important information.",
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
            "Paraphrase the sentence above using different wording and sentence structure. Preserve the original meaning, tone, clarity, and important information.",
            "ONLY a few paraphrased versions. Do not provide explanations or quotation marks."
          )
        end,
      },
      {
        name = "Refine Sentence",
        command_name = "GeminiRefineSentence",
        menu = "Refine Sentence ✨",
        get_prompt = function(_, bufnr)
          return build_sentence_prompt(
            bufnr,
            "Refine the writing above to convey its ideas with greater precision and impact. Improve clarity, logical flow, transitions, and conciseness. Remove unnecessary wordiness and ambiguity without changing the original meaning.",
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
            "Translate the sentence above into natural, accurate, and fluent English. Preserve the original meaning, tone, context, and level of formality.",
            "ONLY the English translation. Do not provide explanations or quotation marks."
          )
        end,
      },
      {
        name = "Summarize",
        command_name = "GeminiSummarize",
        menu = "Summarize 📝",
        get_prompt = function(_, bufnr)
          return build_selected_text_prompt(
            bufnr,
            "Summarize the selected text concisely while preserving its main ideas, important facts, essential arguments, and logical relationships. Remove repetition and unnecessary details.",
            "ONLY the summary. Do not provide explanations, commentary, introductions, or quotation marks."
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
            "Correct all spelling, grammar, punctuation, word-choice, and sentence-structure errors in the selected text. Preserve the original meaning, tone, organization, and important terminology.",
            "ONLY the corrected text. Show corrections in **bold** so the changes are clearly visible. Do not provide explanations or quotation marks."
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
            "Refine the selected text to make the writing clearer, more precise, coherent, logical, concise, and impactful. Improve transitions between ideas, remove unnecessary wordiness, reduce ambiguity, and strengthen the overall flow without changing the original meaning.",
            "ONLY the refined text. Do not provide explanations, commentary, or quotation marks."
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
            "Develop a clear and logical academic outline based on the selected text. Identify the central topic or research question, then organize the content into appropriate main sections and subsections. Ensure that the structure supports a coherent academic argument.",
            "ONLY the outline. Use a hierarchical structure with main sections and subsections. Do not provide explanations before or after the outline."
          )
        end,
      },
      {
        name = "Unit Test",
        command_name = "GeminiUnitTest",
        menu = "Unit Test 🚀",
        get_prompt = function(lines, bufnr)
          return build_code_prompt(
            lines,
            bufnr,
            "Write appropriate unit tests for the code above. Cover the main behavior, important edge cases, and likely failure scenarios.",
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
            "Perform a thorough code review of the code above. Identify bugs, logical problems, edge cases, maintainability issues, security concerns, performance problems, and opportunities for improvement. Be precise and sincere in your comments.",
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
            "Explain the code above clearly and thoroughly. Describe what it does, how the main parts work, the flow of execution, important variables or functions, and any noteworthy behavior.",
            "Provide a clear explanation suitable for someone learning this code."
          )
        end,
      },
    },
  },

  task = {
    enabled = true,
    get_system_text = function()
      return "You are an AI assistant that helps the user write, edit, analyze, and modify text or code.\n"
        .. "Always respond in the dominant language of the Current Opened File.\n"
        .. "Do not determine the response language from the user's task instruction.\n"
        .. "Preserve the document's language unless translation is explicitly requested."
    end,
    get_prompt = function(bufnr, user_prompt)
      local buffers = vim.api.nvim_list_bufs()
      local file_contents = {}

      for _, b in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(b) then
          local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":.")
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = b })

          table.insert(
            file_contents,
            string.format(
              "`%s`:\n\n```%s\n%s\n```\n",
              filename ~= "" and filename or "[No Name]",
              filetype,
              table.concat(lines, "\n")
            )
          )
        end
      end

      local current_filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":.")

      return table.concat({
        table.concat(file_contents, "\n"),
        "Current Opened File: " .. (current_filepath ~= "" and current_filepath or "[No Name]"),
        "Response Language: Follow the dominant language of the Current Opened File.",
        "Task: " .. user_prompt,
      }, "\n\n")
    end,
  },
}

-- =========================================================
-- AUTO-COMMAND: Split Gemini
-- =========================================================
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("GeminiVerticalSplit", { clear = true }),
  callback = function(args)
    local ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
    local buf_name = vim.api.nvim_buf_get_name(args.buf)

    if ft == "gemini" or buf_name:match "gemini" then
      vim.schedule(function()
        if vim.fn.tabpagenr "$" > 1 and vim.fn.tabpagenr() > 1 then
          vim.cmd "tabclose"
        end
        vim.cmd "wincmd L"
        vim.api.nvim_win_set_width(0, 60)
      end)
    end
  end,
})
