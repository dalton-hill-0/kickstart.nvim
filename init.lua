--[[
=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '  ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  {
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically
    opts = {
      on_tab_options = {
        ['expandtab'] = false,
        ['tabstop'] = 2,
      },
    },
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Don't attach LSP to diffview buffers
          local bufname = vim.api.nvim_buf_get_name(event.buf)
          if bufname:match '^diffview://' then
            vim.lsp.stop_client(vim.lsp.get_clients { bufnr = event.buf })
            return
          end
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      -- NOTE: The following line is now commented as blink.cmp extends capabilites by default from its internal code:
      -- https://github.com/Saghen/blink.cmp/blob/102db2f5996a46818661845cf283484870b60450/plugin/blink-cmp.lua
      -- It has been left here as a comment for educational purposes (as the predecessor completion plugin required this explicit step).
      --
      -- local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Language servers can broadly be installed in the following ways:
      --  1) via the mason package manager; or
      --  2) via your system's package manager; or
      --  3) via a release binary from a language server's repo that's accessible somewhere on your system.

      -- The servers table comprises of the following sub-tables:
      -- 1. mason
      -- 2. others
      -- Both these tables have an identical structure of language server names as keys and
      -- a table of language server configuration as values.
      ---@class LspServersConfig
      ---@field mason table<string, vim.lsp.Config>
      ---@field others table<string, vim.lsp.Config>
      local servers = {
        --  Add any additional override configuration in any of the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        --
        --  Feel free to add/remove any LSPs here that you want to install via Mason. They will automatically be installed and setup.
        mason = {
          -- clangd = {},
          markdownlint = {
            filetypes = { 'markdown' },
          },
          gopls = {
            filetypes = { 'go', 'gotmpl' },
          },
          -- yamlls = {
          --   filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values', 'yaml.gotmpl', 'gotmpl' },
          -- },
          -- pyright = {},
          -- rust_analyzer = {},
          -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
          --
          -- Some languages (like typescript) have entire language plugins that can be useful:
          --    https://github.com/pmizio/typescript-tools.nvim
          --
          -- But for many setups, the LSP (`ts_ls`) will work just fine
          -- ts_ls = {},
          --
          -- Harper-ls: Grammar and spell checker for markdown/text/git commits
          -- Keybindings are in lua/custom/plugins/harper.lua
          -- Dictionary: .harper-ls-dict.txt (project-specific)
          -- harper_ls = {
          --   filetypes = { 'markdown', 'text', 'gitcommit', 'go' },
          --   settings = {
          --     ['harper-ls'] = {
          --       linters = {
          --         -- Core linters
          --         SpellCheck = true, -- Checks spelling against dictionary
          --         AnA = true, -- Ensures correct usage of 'a' vs 'an' based on pronunciation
          --         Matcher = true, -- Pattern-based grammar corrections
          --         Spaces = true, -- Checks for spacing issues
          --
          --         -- Capitalization & formatting
          --         SentenceCapitalization = true, -- Ensures sentences start with capital letters
          --         CapitalizePersonalPronouns = true, -- Capitalizes 'I' and related contractions
          --         Months = true, -- Detects months written with a lowercase first letter
          --
          --         -- Quotes & punctuation
          --         UnclosedQuotes = true, -- Detects unclosed quotation marks
          --         WrongQuotes = false, -- Flags incorrect quote types (e.g., straight vs curly)
          --         QuoteSpacing = true, -- Checks that quotation marks have proper spacing
          --         SemicolonApostrophe = true, -- Corrects semicolons typed instead of apostrophes
          --         Dashes = true, -- Replaces -- or --- with proper en/em dashes
          --         EllipsisLength = true, -- Ensures correct number of dots in ellipsis
          --
          --         -- Sentence structure
          --         LongSentences = false, -- Warns about overly long sentences
          --         RepeatedWords = true, -- Detects repeated words (e.g., 'the the')
          --         CommaFixes = true, -- Fixes comma spacing and Asian comma errors
          --         OxfordComma = true, -- Requires Oxford comma in lists
          --         NoOxfordComma = false, -- Prohibits Oxford comma (mutually exclusive with OxfordComma)
          --
          --         -- Numbers & suffixes
          --         SpelledNumbers = false, -- Flags spelled-out numbers (e.g., 'one' instead of '1')
          --         CorrectNumberSuffix = true, -- Ensures correct ordinal suffixes (1st, 2nd, 3rd, etc.)
          --         NumberSuffixCapitalization = true, -- Prevents capitalization of number suffixes
          --
          --         -- Grammar rules - Infinitives & verb forms
          --         MissingTo = false, -- Flags missing 'to' before infinitives (e.g., 'need talk' -> 'need to talk')
          --         LetToDo = true, -- Corrects extraneous 'to' after 'let'
          --         AllowTo = true, -- Flags erroneous 'allow to' without a subject
          --         LookingForwardTo = true, -- Ensures gerund follows 'looking forward to'
          --
          --         -- Grammar rules - Subject-verb agreement
          --         IAmAgreement = true, -- Corrects 'I are' to 'I am'
          --         PronounInflectionBe = true, -- Checks subject-verb agreement for 'be'
          --         NominalWants = true, -- Ensures correct 'want'/'wants' after nominals
          --         HavePronoun = true, -- Flags 'has' with pronouns that require 'have'
          --
          --         -- Grammar rules - Modals & conditionals
          --         DoubleModal = true, -- Removes double modal verbs
          --         ModalOf = true, -- Detects 'of' mistakenly used with would/could/should
          --         IfWouldve = true, -- Corrects 'if I would've' to 'if I had'
          --
          --         -- Common confusions & typos
          --         ToTwoToo = true, -- Corrects to/two/too confusion
          --         ThenThan = true, -- Corrects then/than confusion
          --         ThatThan = true, -- Corrects 'that' typo in comparisons
          --         ItsContraction = true, -- Helps distinguish "it's" (it is) from "its" (possessive)
          --         ItsPossessive = true, -- Ensures possessive pronouns don't use apostrophes
          --         Theres = true, -- Replaces "their's" with "there's"
          --         Everyday = true, -- Distinguishes 'everyday' (adjective) from 'every day' (adverb)
          --         APart = true, -- Corrects 'a part' vs 'apart' confusion
          --         AWhile = true, -- Enforces 'awhile' after verbs, 'a while' elsewhere
          --         QuiteQuiet = true, -- Distinguishes 'quiet' from 'quite'
          --
          --         -- Possessives & contractions
          --         ElsePossessive = true, -- Detects missing apostrophes in "someone else's"
          --         PronounContraction = true, -- Fixes pronoun contraction errors
          --         LetsConfusion = true, -- Corrects "let's" confusion
          --
          --         -- Prepositions
          --         MissingPreposition = true, -- Locates potentially missing prepositions
          --         AskNoPreposition = true, -- Removes superfluous 'to' in 'ask to us'
          --         DespiteOf = true, -- Corrects 'despite of' to 'despite' or 'in spite of'
          --         InterestedIn = true, -- Ensures correct prepositions with 'interested'
          --         GoodAt = true, -- Checks for 'good in' vs 'good at'
          --         FascinatedBy = true, -- Ensures correct prepositions with 'fascinated'
          --
          --         -- Idiomatic expressions
          --         AllIntentsAndPurposes = true, -- Corrects wrong forms of this phrase
          --         BehindTheScenes = true, -- Corrects 'behind the scene' to 'behind the scenes'
          --         OutOfDate = true, -- Hyphenates 'out-of-date' when used as adjective
          --         OfCourse = true, -- Corrects 'of curse/corse' to 'of course'
          --         ViceVersa = true, -- Writes 'vice versa' without hyphens
          --
          --         -- Compound words & hyphenation
          --         DoubleClick = true, -- Hyphenates 'double-click'
          --         RightClick = true, -- Hyphenates 'right-click'
          --         WellEducated = true, -- Hyphenates 'well-educated'
          --         SoonToBe = true, -- Hyphenates 'soon-to-be' before nouns
          --
          --         -- Word choice & style
          --         FillerWords = true, -- Removes filler words
          --         Hedging = true, -- Flags hedging language
          --         BoringWords = false, -- Flags overused/boring words
          --         VeryUnique = true, -- Flags 'very unique' and similar phrases
          --         Oxymorons = true, -- Flags oxymoronic phrases
          --
          --         -- Advanced grammar
          --         NeedToNoun = true, -- Flags 'need to' before nouns (missing verb)
          --         MultipleSequentialPronouns = true, -- Catches multiple pronouns in sequence
          --         SubjectPronoun = true, -- Fixes 'me and X' to 'X and I'
          --         CompoundSubjectI = true, -- Promotes 'I' in compound subjects
          --
          --         -- Regionalisms & variants
          --         UpdatePlaceNames = true, -- Updates deprecated place names
          --         JohnsHopkins = true, -- Ensures proper spelling of Johns Hopkins
          --
          --         -- Proper nouns & capitalization
          --         WordPressDotcom = true, -- Ensures correct capitalization of WordPress.com
          --
          --         -- Redundancy
          --         RedundantAcronyms = true, -- Flags 'ATM machine' type redundancies
          --         RedundantAdditiveAdverbs = true, -- Detects redundant additive adverbs
          --
          --         -- Spell-check related
          --         Misspell = true, -- Ensures 'misspell' is one word
          --         MergeWords = true, -- Finds valid words split by whitespace
          --         SplitWords = true, -- Finds missing spaces in compound words
          --
          --         -- Less common rules (often disabled by default or specialized)
          --         Addicting = true, -- Replaces 'addicting' with 'addictive'
          --         Cant = true, -- Suggests 'can't' for 'cant'
          --         Didnt = true, -- Corrects 'dint' to "didn't"
          --         Bought = true, -- Replaces 'bough' with 'bought'
          --         FeelFell = true, -- Corrects some fell/feel confusions
          --         ThingThink = true, -- Corrects 'thing' typo when should be 'think'
          --         ThoughThought = true, -- Corrects 'though' typo when should be 'thought'
          --         ThesesThese = true, -- Corrects 'theses' misspelling of 'these'
          --         FindFine = true, -- Fixes 'find' when meaning 'fine'
          --         SafeToSave = true, -- Detects 'safe' when 'save' intended
          --         SaveToSafe = true, -- Corrects 'save to' when should be 'safe to'
          --         WasAloud = true, -- Corrects 'was aloud' to 'was allowed'
          --         Nobody = true, -- Ensures 'nobody' is one word
          --         Likewise = true, -- Ensures 'likewise' is one word
          --         Handful = true, -- Keeps 'handful' as one word
          --         HelloGreeting = true, -- Prefers 'hello' over 'halo' for greetings
          --         Hereby = true, -- Corrects 'here by' to 'hereby'
          --         Misspell = true, -- Ensures 'misspell' is one word
          --         FirstAidKit = true, -- Corrects 'kid' to 'kit' after aid/starter/travel/tool
          --         ChockFull = true, -- Ensures proper hyphenation
          --         Touristic = true, -- Suggests alternatives to 'touristic'
          --         CriteriaPhenomena = true, -- Ensures proper plural usage
          --         CureFor = true, -- Prefers 'cure for' over 'cure against'
          --         Confident = true, -- Distinguishes 'confident' from 'confidant'
          --
          --         -- Abbreviation expansion (usually off by default)
          --         ExpandTimeShorthands = true, -- Expands hr, min, sec, etc.
          --         ExpandMemoryShorthands = true, -- Expands kB, MB, GB, etc.
          --         DotInitialisms = true, -- Ensures proper dot separation
          --
          --         -- Currency & measurements
          --         CurrencyPlacement = true, -- Corrects currency symbol position
          --         HyphenateNumberDay = true, -- Hyphenates '4-day work week'
          --
          --         -- Discourse & style
          --         DiscourseMarkers = true, -- Requires comma after discourse markers
          --         NoFrenchSpaces = true, -- Prevents French-style spacing
          --
          --         -- Advanced/specialized (many enabled by default)
          --         AdjectiveOfA = true, -- Looks for 'adjective of a' patterns
          --         AdjectiveDoubleDegree = true, -- Finds double degrees like 'more prettier'
          --         AfterLater = true, -- Checks for 'later' after 'after [time]'
          --         AmInTheMorning = true, -- Flags redundant AM with 'in the morning'
          --         AmountsFor = true, -- Corrects 'amounts for' to 'amounts to'
          --         AndIn = true, -- Fixes 'an in' to 'and in'
          --         AndTheLike = true, -- Corrects mistakes in 'and the like'
          --         AnotherThingComing = true, -- Accepts modern 'another thing coming'
          --         AnotherThinkComing = false, -- Original but less common variant
          --         ApartFrom = true, -- Corrects 'apart form' to 'apart from'
          --         AvoidCurses = true, -- Flags offensive language
          --         BackInTheDay = true, -- Corrects 'back in the days' to singular
          --         BeAllowed = true, -- Ensures 'be allowed' after future negatives
          --         BestOfAllTime = true, -- Prefers singular 'time' in superlatives
          --         BrandBrandish = true, -- Distinguishes 'brand' from 'brandish'
          --         CautionaryTale = true, -- Distinguishes 'tale' from 'tail'
          --         ChangeTack = true, -- Corrects idiom errors
          --         CompoundNouns = true, -- Checks compound noun formation
          --         DespiteItIs = true, -- Corrects 'despite' with wrong 'is' form
          --         EverEvery = true, -- Corrects 'every' typo for 'ever'
          --         FarBeIt = true, -- Ensures proper 'far be it from' usage
          --         FewUnitsOfTimeAgo = true, -- Corrects 'few' to 'a few' in time expressions
          --         FleshOutVsFullFledged = true, -- Distinguishes these phrases
          --         ForNoun = true, -- Corrects archaic 'fro' to 'for'
          --         FreePredicate = true, -- Swaps 'fee' for 'free' with linking verbs
          --         FriendOfMe = true, -- Corrects pronoun usage in 'friend of' constructions
          --         GoSoFarAsTo = true, -- Ensures proper idiom form
          --         GoToWar = true, -- Corrects 'go at war' to 'go to war'
          --         HopHope = true, -- Corrects hop/hope confusion
          --         HowTo = true, -- Ensures 'to' in 'how to' constructions
          --         ItLooksLikeThat = true, -- Removes redundant 'that'
          --         JealousOf = true, -- Ensures proper preposition
          --         LeftRightHand = true, -- Hyphenates 'left-hand'/'right-hand' as adjectives
          --         LessWorse = true, -- Suggests better comparisons than 'less worse'
          --         MixedBag = true, -- Corrects 'mixed bad' to 'mixed bag'
          --         ModalBeAdjective = true, -- Finds missing 'be' between modal and adjective
          --         ModalSeem = true, -- Suggests 'seem' or 'be' after modals
          --         MoreBetter = true, -- Flags redundant 'more' with comparatives
          --         MostNumber = true, -- Corrects 'most number'
          --         MostOfTheTimes = true, -- Uses singular 'time'
          --         NailOnTheHead = true, -- Corrects variants of this idiom
          --         NoMatchFor = true, -- Grammar check for 'no match for'
          --         NorModalPronoun = true, -- Corrects word order after 'nor'
          --         NounVerbConfusion = true, -- Detects noun/verb confusion
          --         ObsessPreposition = true, -- Ensures valid prepositions with 'obsess'
          --         OldestInTheBook = true, -- Uses singular 'book' in idiom
          --         OnceOrTwice = true, -- Corrects 'once a twice'
          --         OneAndTheSame = true, -- Corrects 'one in the same'
          --         OnFloor = true, -- Prefers 'on the floor' for building locations
          --         OpenCompounds = true, -- Ensures proper compound word spacing
          --         OpenTheLight = true, -- Prefers 'turn on' over 'open' for lights
          --         OrthographicConsistency = true, -- Matches dictionary capitalization
          --         OughtToBe = true, -- Corrects 'out to be' to 'ought to be'
          --         PhrasalVerbAsCompoundNoun = true, -- Checks phrasal verb compounds
          --         PiqueInterest = true, -- Corrects 'peak/peek interest' to 'pique'
          --         PluralWrongWordOfPhrase = true, -- Pluralizes main noun not last noun
          --         PossessiveYour = true, -- Prefers possessive 'your' before nouns
          --         ProgressiveNeedsBe = true, -- Fixes ungrammatical progressive constructions
          --         PronounAre = true, -- Corrects 'r' typo for 'are'
          --         PronounKnew = true, -- Corrects 'new' typo for 'knew'
          --         QuantifierNeedsOf = true, -- Adds missing 'of' after quantifiers
          --         QuantifierNumeralConflict = true, -- Detects quantifier-numeral conflicts
          --         RollerSkated = true, -- Hyphenates 'roller-skate' past tense
          --         ShootOneselfInTheFoot = true, -- Corrects variants of this idiom
          --         SimplePastToPastParticiple = true, -- Grammar check for past forms
          --         SinceDuration = true, -- Ensures 'since' with point in time not duration
          --         SingleBe = true, -- Removes duplicate 'be' forms
          --         SomeWithoutArticle = true, -- Removes redundant article before 'some'
          --         SomethingIs = true, -- Suggests "something's" or "something is"
          --         SomewhatSomething = true, -- Prefers 'something of a' traditionally
          --         SoughtAfter = true, -- Corrects 'sort after' to 'sought after'
          --         TakeALookTo = true, -- Corrects preposition to 'at'
          --         TakeMedicine = true, -- Prefers 'take' over 'eat' for medicine
          --         ThatWhich = true, -- Removes redundant 'that which'
          --         TheHowWhy = true, -- Removes extra 'the' from 'the how'
          --         TheMy = true, -- Flags article with possessive
          --         TheProperNounPossessive = true, -- Removes 'the' before possessive proper nouns
          --         ThisTypeOfThing = true, -- Checks number agreement in type phrases
          --         ThrowAway = true, -- Corrects 'through away' typo
          --         ThrowRubbish = true, -- Prefers 'throw away' rubbish
          --         ToAdverb = true, -- Removes duplicate 'to' around adverbs
          --         TryOnesHandAt = true, -- Uses singular 'hand' in idiom
          --         VerbToAdjective = true, -- Suggests adjective where verb was written
          --         ViciousCircle = true, -- Standard variant
          --         ViciousCircleOrCycle = false, -- Alternative accepted variant
          --         ViciousCycle = false, -- Less preferred variant
          --         WayTooAdjective = true, -- Replaces 'to' with 'too' after 'way'
          --         Whereas = true, -- Corrects 'where as' to 'whereas'
          --         WhomSubjectOfVerb = true, -- Detects 'whom' used as subject
          --         WidelyAccepted = true, -- Prefers adverb 'widely' over 'wide'
          --         WinPrize = true, -- Distinguishes 'prize' from 'price'/'prise'
          --         WishCould = true, -- Uses 'could' not 'can' after 'wish'
          --         WouldNeverHave = true, -- Corrects word order with 'never'
          --       },
          --       codeActions = {
          --         ForceStable = true,
          --       },
          --     },
          --   },
          -- },
          lua_ls = {
            -- cmd = { ... },
            -- filetypes = { ... },
            -- capabilities = {},
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
        },
        -- This table contains config for all language servers that are *not* installed via Mason.
        -- Structure is identical to the mason table from above.
        others = {
          -- dartls = {},
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers.mason or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'black', -- Used to format Python code
        'prettierd', -- Used to format various web related code and markdown
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- Either merge all additional server configs from the `servers.mason` and `servers.others` tables
      -- to the default language server configs as provided by nvim-lspconfig or
      -- define a custom server config that's unavailable on nvim-lspconfig.
      for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
        if not vim.tbl_isempty(config) then
          vim.lsp.config(server, config)
        end
      end

      -- After configuring our language servers, we now enable them
      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_enable = true, -- automatically run vim.lsp.enable() for all servers that are installed via Mason
      }

      -- Manually run vim.lsp.enable for all language servers that are *not* installed via Mason
      if not vim.tbl_isempty(servers.others) then
        vim.lsp.enable(vim.tbl_keys(servers.others))
      end
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        local timeout_by_ft = {
          python = 3000, -- Black can be slow, give it 3 seconds
        }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = timeout_by_ft[vim.bo[bufnr].filetype] or 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        markdown = { 'prettierd' },
        python = { 'black' },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'default',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        -- Optionally, set `auto_show = true` to show the documentation after a delay.
        documentation = { auto_show = false, auto_show_delay_ms = 500 },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  {
    -- 'sainnhe/everforest',
    -- lazy = false,
    -- priority = 1000,
    -- config = function()
    --   vim.g.everforest_background = 'hard'
    --   vim.cmd.colorscheme 'everforest'
    -- end,
    -- Alternative gruvbox material setup
    'sainnhe/gruvbox-material',
    priority = 0,
    config = function()
      vim.o.background = 'dark'
      vim.cmd [[ let g:gruvbox_material_background = 'hard' ]]
      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'helm',
        'html',
        'gotmpl',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = {
        enable = true,
        disable = { 'ruby' },
      },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },

  {
    -- Adapted from https://github.com/ngalaiko/tree-sitter-go-template
    -- But the go-template treesitter doesn't seem to work for yaml. Helm seems
    -- like a better option.
    vim.filetype.add {
      extension = {
        gotmpl = 'helm',
      },
      pattern = {
        ['.*/templates/.*%.tpl'] = 'helm',
        ['.*/templates/.*%.ya?ml'] = 'helm',
        ['helmfile.*%.ya?ml'] = 'helm',
      },
    },
  },

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.o.relativenumber = true

vim.opt.linebreak = true
vim.opt.textwidth = 80

vim.o.spell = true

-- Easier way to display diagnostic.
vim.keymap.set('n', '<C-I>d', function()
  vim.diagnostic.open_float()
end, { noremap = true })

function SetIndentTo2()
  vim.bo.shiftwidth = 2
  vim.bo.tabstop = 2
  vim.bo.softtabstop = 2
  vim.bo.expandtab = true
end

vim.api.nvim_create_user_command('SetIndentTo2', SetIndentTo2, {})

-- Configure SetIndentTo2 to be called when opening all files.
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    SetIndentTo2()
  end,
})

-- Configure SetIndentTo2 to be called when creating new files.
vim.api.nvim_create_autocmd('BufNewFile', {
  pattern = '*',
  callback = function()
    SetIndentTo2()
  end,
})

-- Setup keys for Copilot.
vim.keymap.set('n', '<leader>ce', function()
  vim.cmd.Copilot 'enable'
end, { noremap = true, desc = 'Copilot Enable' })
vim.keymap.set('n', '<leader>cd', function()
  vim.cmd.Copilot 'disable'
end, { noremap = true, desc = 'Copilot Disable' })
