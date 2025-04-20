return {
  {
    'Vigemus/iron.nvim',
    cmd = { 'IronRepl', 'IronRestart', 'IronFocus', 'IronHide' },
    config = function()
      local iron = require 'iron.core'
      local view = require 'iron.view'
      local common = require 'iron.fts.common'

      iron.setup {
        config = {
          -- Whether a repl should be discarded or not
          repl_open_cmd = view.split.vertical.botright(0.5),
          scratch_repl = true,
          -- Your repl definitions come here
          repl_definition = {
            python = {
              command = { 'ipython' }, -- or { "ipython", "--no-autoindent" }
              format = common.bracketed_paste_python,
              block_dividers = { '# %%', '#%%' },
            },
          },
          repl_filetype = function(bufnr, ft)
            return ft
          end,
        },
        ignore_blank_lines = true,
      }
    end,
  },
}
