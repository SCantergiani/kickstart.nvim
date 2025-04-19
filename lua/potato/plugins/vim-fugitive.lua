return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.keymap.set('n', '<leader>gg', '<cmd>G<CR>', { desc = 'Git status' })
      vim.keymap.set('n', '<leader>ga', '<cmd>G add .<CR>', { desc = 'Git add all' })
      vim.keymap.set('n', '<leader>gc', '<cmd>G commit<CR>i', { desc = 'Git commit' })
      vim.keymap.set('n', '<leader>gp', '<cmd>G push<CR>', { desc = 'Git push' })
    end,
  },
}
