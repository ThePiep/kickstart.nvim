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
    config = function()
      vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
      require('auto-session').setup()
    end,
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
      { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neo[G]it open [G]it UI' },
      { '<leader>gc', '<cmd>Neogit cwd=%:p:h<cr>', desc = 'Neo[G]it open on [C]urrent file' },
    },
  },
  {
    'benomahony/uv.nvim',
    -- Optional filetype to lazy load when you open a python file
    -- ft = { python }
    -- Optional dependency, but recommended:
    dependencies = {
      --   "folke/snacks.nvim"
      -- or
      'nvim-telescope/telescope.nvim',
    },
    opts = {
      picker_integration = true,
    },
  },
}
