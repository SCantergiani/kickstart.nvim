return {
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      vim.keymap.set('n', '<leader>ha', function()
        harpoon:list():add()
      end, { desc = '[H]arpoon add file' })
      vim.keymap.set('n', '<leader>hm', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = '[H]arpoon menu' })

      vim.keymap.set('n', '<F13>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<F14>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<F15>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<F16>', function()
        harpoon:list():select(4)
      end)
    end,
  },
}
