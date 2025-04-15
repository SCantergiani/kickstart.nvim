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
              command = { 'python3' }, -- or { "ipython", "--no-autoindent" }
              format = common.bracketed_paste_python,
              block_dividers = { '# %%', '#%%' },
            },
          },
          repl_filetype = function(bufnr, ft)
            return ft
          end,
        },
        keymaps = {
          toggle_repl = '<space>Prr', -- toggles the repl open and closed.
          -- If repl_open_command is a table as above, then the following keymaps are
          -- available
          -- toggle_repl_with_cmd_1 = "<space>Prv",
          -- toggle_repl_with_cmd_2 = "<space>Prh",
          restart_repl = '<space>PrR', -- calls `IronRestart` to restart the repl
          send_motion = '<space>Psc',
          visual_send = '<space>Psc',
          send_file = '<space>Psf',
          send_line = '<space>Psl',
          send_paragraph = '<space>Psp',
          send_until_cursor = '<space>Psu',
          send_mark = '<space>Psm',
          send_code_block = '<space>Psb',
          send_code_block_and_move = '<space>Psn',
          mark_motion = '<space>Pmc',
          mark_visual = '<space>Pmc',
          remove_mark = '<space>Pmd',
          cr = '<space>Ps<cr>',
          interrupt = '<space>Ps<space>',
          exit = '<space>Psq',
          clear = '<space>Pcl',
        },
        ignore_blank_lines = true,
      }
    end,
  },
}
