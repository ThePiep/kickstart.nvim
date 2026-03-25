-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

---@module 'lazy'
---@type LazySpec
return {
  {
    'rmagatti/auto-session',
    lazy = false,

    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
      -- log_level = 'debug',
    },
  },
  {
    'NeogitOrg/neogit',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim', -- required

      -- Only one of these is needed.
      'sindrets/diffview.nvim', -- optional
      -- 'esmuellert/codediff.nvim', -- optional

      -- Only one of these is needed.
      'nvim-telescope/telescope.nvim', -- optional
      -- 'ibhagwan/fzf-lua', -- optional
      -- 'nvim-mini/mini.pick', -- optional
      -- 'folke/snacks.nvim', -- optional
    },
    cmd = 'Neogit',
    keys = {
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Show Neogit UI' },
    },
  },
}
