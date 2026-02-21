-- =====================================================================
-- OBSIDIAN.NVIM QUICK REFERENCE
-- =====================================================================
--
-- QUICK NOTE WORKFLOW:
--   1. Press <leader>on to create/search for a note
--   2. Type [[ to link to another note (autocomplete enabled)
--   3. Press gf or <CR> on a link to follow it
--   4. Press <leader>ob to see who links to this note
--
-- KEYMAPS (<leader>o prefix):
--   Normal Mode:
--     <leader>on  - Quick note (create/search)
--     <leader>of  - Follow link under cursor
--     <leader>ob  - Show backlinks (notes linking here)
--     <leader>ol  - Show all links in current note
--     <leader>os  - Search notes by content
--     <leader>oq  - Quick switch between notes
--     <leader>ot  - Insert template
--     <leader>ow  - Switch workspace
--     <leader>op  - Preview markdown (if available)
--     gf          - Follow link (vim-style)
--     <CR>        - Smart action (follow link/toggle checkbox)
--
--   Visual Mode:
--     <leader>ol  - Link selected text to a note
--
-- LINKING EXAMPLES:
--   [[note-name]]         - Link to note-name.md
--   [[note-name|alias]]   - Link with custom text
--   #tag                  - Tag a note
--
-- COMMANDS:
--   :Obsidian             - Show all available commands
--   :Obsidian help        - Open obsidian.nvim help
--   :Obsidian search      - Full-text search
--
-- NOTE: URL opening now uses vim.ui.open by default (works on Linux/Mac/Windows)
--       To customize URL handling, configure vim.ui.open in your init.lua
--
-- WORKSPACES:
--   Workspaces are loaded from ~/.config/nvim/obsidian-workspaces.json
--   This allows different vault configurations on different machines.
--
--   Example obsidian-workspaces.json:
--   [
--     {
--       "name": "work-notes",
--       "path": "~/Documents/work/notes"
--     },
--     {
--       "name": "personal",
--       "path": "~/Documents/vaults/personal"
--     }
--   ]
--
--   If the file doesn't exist, default workspaces will be used.
--
-- TEMPLATES:
--   peptribe-docs: ~/projects/github.com/dalton-hill-0/peptribe/docs/templates/
--   personal:      ~/Documents/vaults/personal/templates/
--
-- =====================================================================

-- Load workspaces from external file or use defaults
-- This allows different workspace configurations per machine
local function load_workspaces()
  local workspaces_file = vim.fn.expand '~/.config/nvim/obsidian-workspaces.json'

  -- Try to read the workspaces file
  local file = io.open(workspaces_file, 'r')
  if not file then
    -- If the file does't exist, error out. Force user to resolve.
    vim.notify('Obsidian workspaces file not found: ' .. workspaces_file .. '\nPlease create this file with your vault configurations.', vim.log.levels.ERROR)
  end
  if file then
    local content = file:read '*a'
    file:close()

    local ok, workspaces = pcall(vim.json.decode, content)
    if ok and workspaces and #workspaces > 0 then
      return workspaces
    else
      vim.notify('Failed to parse obsidian-workspaces.json, using defaults', vim.log.levels.WARN)
    end
  end
end

return {
  'obsidian-nvim/obsidian.nvim',
  version = 'v3.14.7',
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'saghen/blink.cmp',
  },

  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,

    -- Workspaces - loaded from file or defaults
    workspaces = load_workspaces(),

    -- Note ID generation - use simple lowercase with hyphens
    -- Example: "my-new-note.md"
    note_id_func = function(title)
      if title == nil then
        return tostring(os.time())
      end
      local suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      return suffix
    end,

    -- Note path function - where new notes are placed
    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix '.md'
    end,

    -- Frontmatter configuration (replaces disable_frontmatter)
    frontmatter = {
      enabled = function(path)
        -- Never update frontmatter for specific files
        -- path is vault-relative, e.g. "some/dir/SKILL.md"
        local skip_frontmatter_files = {
          'SKILL.md',
          'README.md',
        }

        if path then
          for _, filename in ipairs(skip_frontmatter_files) do
            -- Escape special pattern characters and match at end of path
            local pattern = filename:gsub('([%.%-])', '%%%1') .. '$'
            if path:match(pattern) then
              return false
            end
          end
        end

        return true
      end,
    },

    -- Templates configuration
    templates = {
      folder = 'templates',
      date_format = '%Y-%m-%d',
      time_format = '%H:%M',
    },

    -- Completion configuration
    completion = {
      nvim_cmp = false,
      blink = true,
      min_chars = 1,
    },

    -- Daily notes
    daily_notes = {
      folder = 'daily',
      date_format = '%Y-%m-%d',
      alias_format = '%B %-d, %Y',
      template = nil,
    },

    -- Picker configuration
    picker = {
      name = 'telescope.nvim',
      mappings = {
        new = '<C-x>',
        insert_link = '<C-l>',
      },
    },

    -- Checkbox configuration (replaces ui.checkboxes)
    checkbox = {
      enabled = true,
      create_new = true,
      order = { ' ', 'x', '>', '~' },
    },

    -- UI configuration
    ui = {
      enable = true,
      update_debounce = 200,
      bullets = { char = '•', hl_group = 'ObsidianBullet' },
      external_link_icon = { char = '', hl_group = 'ObsidianExtLinkIcon' },
      reference_text = { hl_group = 'ObsidianRefText' },
      highlight_text = { hl_group = 'ObsidianHighlightText' },
      tags = { hl_group = 'ObsidianTag' },
      hl_groups = {
        ObsidianTodo = { bold = true, fg = '#f78c6c' },
        ObsidianDone = { bold = true, fg = '#89ddff' },
        ObsidianRightArrow = { bold = true, fg = '#f78c6c' },
        ObsidianTilde = { bold = true, fg = '#ff5370' },
        ObsidianBullet = { bold = true, fg = '#89ddff' },
        ObsidianRefText = { underline = true, fg = '#c792ea' },
        ObsidianExtLinkIcon = { fg = '#c792ea' },
        ObsidianTag = { italic = true, fg = '#89ddff' },
        ObsidianHighlightText = { bg = '#75662e' },
      },
    },

    -- Attachments (images, etc.) - uses 'folder' instead of 'img_folder'
    attachments = {
      folder = 'assets/imgs',
      img_text_func = function(client, path)
        local link_path = client:vault_relative_path(path) or path
        return string.format('![%s](%s)', path.name, link_path)
      end,
    },
  },

  -- Keymaps
  keys = {
    {
      '<leader>on',
      '<cmd>Obsidian new<CR>',
      desc = '[O]bsidian: [N]ew note',
    },
    {
      '<leader>of',
      '<cmd>Obsidian follow_link<CR>',
      desc = '[O]bsidian: [F]ollow link',
    },
    {
      '<leader>ob',
      '<cmd>Obsidian backlinks<CR>',
      desc = '[O]bsidian: [B]acklinks',
    },
    {
      '<leader>ol',
      '<cmd>Obsidian links<CR>',
      desc = '[O]bsidian: [L]inks',
      mode = 'n',
    },
    {
      '<leader>ol',
      ':Obsidian link<CR>',
      desc = '[O]bsidian: [L]ink selection',
      mode = 'v',
    },
    {
      '<leader>os',
      '<cmd>Obsidian search<CR>',
      desc = '[O]bsidian: [S]earch',
    },
    {
      '<leader>oq',
      '<cmd>Obsidian quick_switch<CR>',
      desc = '[O]bsidian: [Q]uick switch',
    },
    {
      '<leader>ot',
      '<cmd>Obsidian template<CR>',
      desc = '[O]bsidian: [T]emplate',
    },
    {
      '<leader>ow',
      '<cmd>Obsidian workspace<CR>',
      desc = '[O]bsidian: [W]orkspace',
    },
    {
      '<CR>',
      function()
        return require('obsidian').util.smart_action()
      end,
      desc = 'Obsidian: Smart action',
      ft = 'markdown',
      expr = true,
      buffer = true,
    },
    {
      'gf',
      function()
        return require('obsidian').util.gf_passthrough()
      end,
      desc = 'Obsidian: Follow link',
      ft = 'markdown',
      expr = true,
      buffer = true,
    },
  },

  config = function(_, opts)
    require('obsidian').setup(opts)

    -- Add markdown preview keymap if available
    if vim.fn.exists ':MarkdownPreview' == 2 then
      vim.keymap.set('n', '<leader>op', '<cmd>MarkdownPreview<CR>', {
        desc = '[O]bsidian: [P]review markdown',
      })
    end

    -- Better link display
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.opt_local.conceallevel = 2
      end,
    })
  end,
}
