return {
  {
    'zbirenbaum/copilot.lua',
    -- event = 'InsertEnter',
    opts = {
      suggestion = {
        auto_trigger = false,
        hide_during_completion = false,
        keymap = {
          accept = false,
        },
      },
    },
    config = function(_, opts)
      require('copilot').setup(opts)
      -- https://github.com/zbirenbaum/copilot.lua/discussions/153
      vim.keymap.set('i', '<Tab>', function()
        if require('copilot.suggestion').is_visible() then
          require('copilot.suggestion').accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
        end
      end, { desc = 'Super Tab' })
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim', branch = 'master' }, -- for curl, log and async functions
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    opts = {},
  },
}
