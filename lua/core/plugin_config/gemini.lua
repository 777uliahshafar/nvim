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
  instruction = {
    enabled = true,
    menu_key = "<Leader><Leader><Leader>g",
    prompts = {
      {
        name = "Unit Test",
        command_name = "GeminiUnitTest",
        menu = "Unit Test 🚀",
        get_prompt = function(lines, bufnr)
          local code = vim.fn.join(lines, "\n")
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          local prompt = "Context:\n\n```%s\n%s\n```\n\n"
            .. "Objective: Write unit test for the above snippet of code\n"
          return string.format(prompt, filetype, code)
        end,
      },
      {
        name = "Code Review",
        command_name = "GeminiCodeReview",
        menu = "Code Review 📜",
        get_prompt = function(lines, bufnr)
          local code = vim.fn.join(lines, "\n")
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          local prompt = "Context:\n\n```%s\n%s\n```\n\n"
            .. "Objective: Do a thorough code review for the following code.\n"
            .. "Provide detail explaination and sincere comments.\n"
          return string.format(prompt, filetype, code)
        end,
      },
      {
        name = "Code Explain",
        command_name = "GeminiCodeExplain",
        menu = "Code Explain",
        get_prompt = function(lines, bufnr)
          local code = vim.fn.join(lines, "\n")
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          local prompt = "Context:\n\n```%s\n%s\n```\n\n"
            .. "Objective: Explain the following code.\n"
            .. "Provide detail explaination and sincere comments.\n"
          return string.format(prompt, filetype, code)
        end,
      },
    },
  },
  task = {
    enabled = true,
    get_system_text = function()
      return "You are an AI assistant that helps user write code."
        .. "\n* You should output the new content for the Current Opened File"
    end,
    get_prompt = function(bufnr, user_prompt)
      local buffers = vim.api.nvim_list_bufs()
      local file_contents = {}

      for _, b in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(b) then -- Only get content from loaded buffers
          local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
          local abs_path = vim.api.nvim_buf_get_name(b)
          local filename = vim.fn.fnamemodify(abs_path, ":.")
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = b })
          local file_content = table.concat(lines, "\n")
          file_content = string.format("`%s`:\n\n```%s\n%s\n```\n\n", filename, filetype, file_content)
          table.insert(file_contents, file_content)
        end
      end

      local current_filepath = vim.api.nvim_buf_get_name(bufnr)
      current_filepath = vim.fn.fnamemodify(current_filepath, ":.")

      local context = table.concat(file_contents, "\n\n")
      return string.format("%s\n\nCurrent Opened File: %s\n\nTask: %s", context, current_filepath, user_prompt)
    end,
  },
}
