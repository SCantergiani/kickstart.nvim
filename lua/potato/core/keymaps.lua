local set = vim.keymap.set

-- Disable the spacebar key's default behavior in Normal and Visual modes
set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

set('n', '<C-s>', '<cmd> w <CR>')

-- delete single character without copying into register
set('n', 'x', '"_x')

-- Vertical scroll and center
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')

-- Find and center
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')

-- [[ Basic Keymaps ]]
--  See `:help set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Iron
set('n', '<space>rr', '<cmd>IronRepl<cr>', { desc = 'Toggle REPL', noremap = true, silent = true })
set('n', '<space>rl', function()
  require('iron.core').send_line()
end, { desc = 'Send line' })

set('n', '<space>rf', function()
  require('iron.core').send_file()
end, { desc = 'Send file' })

set('n', '<space>rp', function()
  require('iron.core').send_paragraph()
end, { desc = 'Send paragraph' })

set('n', '<space>rc', function()
  require('iron.core').repl_restart()
end, { desc = 'Clear terminal' })

-- Terminal
set('n', '<space>tt', '<cmd>ToggleTerm<cr>', { desc = 'Toggle terminal', noremap = true, silent = true })
