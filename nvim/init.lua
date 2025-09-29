--[[ Basic Editor Settings ]]
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.tabstop = 2            -- Number of visual spaces per <Tab>
vim.opt.softtabstop = 2        -- Number of spaces inserted/deleted for <Tab>/<BS>
vim.opt.shiftwidth = 2         -- Number of spaces for autoindent
vim.opt.scrolloff = 10
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.rnu = true          -- Show line numbers in the margin
vim.opt.list = true            -- Enable display of characters in listchars
vim.opt.clipboard = "unnamed"
vim.opt.listchars = {
  tab = '» ',                -- Show tabs as '> '
  trail = '·',               -- Show trailing whitespace with a middle dot (U+00B7)
  nbsp = '+',                -- Show non-breakable spaces as '+'
  lead = '·',                -- Show leading spaces (at the start of a line) with a middle dot
  space = '·'               -- Show all other regular spaces with a middle dot
  -- eol = '¬'
  -- You can add more, e.g., extends = '»', precedes = '«' for lines extending/preceding screen
}
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme oasis]])

-- require("gruvbox").setup({
--   terminal_colors = true, -- add neovim terminal colors
--   undercurl = true,
--   underline = true,
--   bold = true,
--   italic = {
--     strings = true,
--     emphasis = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "", -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = false,
-- })
-- vim.cmd("colorscheme gruvbox")
-- vim.cmd("language en_US") -- Uncomment if you need to force a specific language

-- Set mapleader (ensure it's a single space)
-- Note: Your original had a non-breaking space (U+00A0). If intentional, revert to "  ".
-- Using a regular space is more common and easier to type.
vim.g.mapleader = " "

--[[ Lazy.nvim Package Manager Setup ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.api.nvim_echo({
    { "Installing lazy.nvim repository...\n", "Normal" },
    { "From: " .. lazyrepo .. "\n", "Comment" },
    { "To:   " .. lazypath .. "\n", "Comment" },
  }, true, {})
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

--[[ Plugin Definitions ]]
local plugins = {
  -- Colorscheme
--  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },

--  { "gruvbox-oasis" },
--  {
--    "gruvbox-oasis",
--    lazy = false,
--    priority = 1000,
--    config = function()
--      vim.cmd("colorscheme gruvbox-oasis")
--    end,
--  },
--  { "savq/melange-nvim" },
--  {
--    "xero/miasma.nvim",
--    lazy = false,
--    priority = 1000,
--    config = function()
--      vim.cmd("colorscheme miasma")
--    end
-- 
--  -- Fuzzy Finder
--  {
--    'nvim-telescope/telescope.nvim',
--    tag = '0.1.8', -- Consider checking for a newer stable tag
--    dependencies = { 'nvim-lua/plenary.nvim' },
--    config = function()
--      local builtin = require("telescope.builtin")
--      vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = "Find files" })
--      vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = "Live grep" })
--      -- You can add more Telescope actions here
--    end
--  },

  -- Syntax Highlighting and More
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Crucial: runs :TSUpdate on install/update
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "json",
          "lua",
          "markdown",
          "python",
          "terraform",
          "vim",
          "yaml"
          -- Add other languages as needed
        },
        highlight = {
          enable = true,
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        -- Autotag for HTML/XML, etc.
        -- autotag = {
        --   enable = true,
        -- },
      })
      -- Optional: Check if parsers are installed and trigger install if not
      -- This is usually handled by `build` and `ensure_installed`, but can be a fallback.
      -- local ensure_installed = require("nvim-treesitter.configs").get_ensure_installed_parsers()
      -- local parsers_to_install = {}
      -- for _, parser_name in ipairs(ensure_installed) do
      --   if not vim.treesitter.is_parser_installed(parser_name) then
      --     table.insert(parsers_to_install, parser_name)
      --   end
      -- end
      -- if #parsers_to_install > 0 then
      --   vim.cmd("TSInstall " .. table.concat(parsers_to_install, " "))
      -- end
    end
    -- Optional: Defer TSUpdate until after Neovim has fully started if build causes issues
    -- init = function()
    --   vim.defer_fn(function()
    --     pcall(vim.cmd, "TSUpdate")
    --   end, 100)
    -- end
  }
}

--[[ Initialize Lazy.nvim ]]
-- The second argument to setup can be a table for lazy.nvim's own options (e.g., UI, performance)
-- For now, an empty table is fine if you don't need to customize lazy.nvim's behavior.
local opts = {}
require("lazy").setup(plugins, opts)

-- It's good practice to put plugin setup calls within their respective `config`
-- functions in the plugin specification as shown above.
-- If a plugin doesn't have a `config` function or you need to run something
-- globally after all plugins are loaded, you could use an autocommand:
--
-- vim.api.nvim_create_autocmd("User", {
--   pattern = "VeryLazy",
--   callback = function()
--     vim.notify("All plugins loaded by lazy.nvim!", vim.log.levels.INFO, { title = "Neovim Startup" })
--     -- vim.cmd.colorscheme "catppuccin" -- This is now in catppuccin's config
--   end
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.shiftwidth = 2
  end
})

vim.api.nvim_create_autocmd({"BufReadPost"}, {
    pattern = {"*"},
    callback = function()
        if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.api.nvim_exec2("normal! g'\"", {output = false})
        end
    end
})

