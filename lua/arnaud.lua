-- Remapping Ctrl + p to :Leaderf file
vim.api.nvim_set_keymap('n', '<C-p>', ':Leaderf file<CR>', { noremap = true, silent = true })

-- FormatJson
vim.cmd('command! FormatJson %!python -m json.tool')

-- Function to remove trailing whitespaces
function RemoveTrailingWhitespace()
  if vim.bo.filetype ~= "diff" then
    local curcol = vim.fn.col(".")
    local curline = vim.fn.line(".")
    vim.cmd([[
      silent! %s/\s\+$//
      silent! %s/\(\s*\n\)\+\%$//
    ]])
    vim.fn.cursor(curline, curcol)
  end
end


-- Groupe d'autocommandes
local group = vim.api.nvim_create_augroup("FormatAndTrimWhitespace", { clear = true })

-- Autocommande pour supprimer les espaces blancs avant de sauvegarder
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  callback = RemoveTrailingWhitespace,
})

-- Autocommande pour exécuter Neoformat avant de sauvegarder
vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  command = "Neoformat",
})


-- Remap keys
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'dc', ':bd<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'ma', ':BlackMacchiato<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'zq', ':set foldlevel=0<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'za', ':set foldlevel=10<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>c', ':Commentary<CR>', { noremap = true, silent = true })

-- vim.g.copilot_no_tab_map = true

vim.api.nvim_set_keymap('i', '<C-M>', 'copilot#Accept("\\<CR>")', { expr=true, noremap = true, silent = true })

vim.cmd("colorscheme onedark")


-- Go
local lspconfig = require("lspconfig")

lspconfig.gopls.setup({
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
})

-- Utilisation correcte de vim.api.nvim_create_autocmd
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- Ajouter un timeout personnalisé si nécessaire
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
          vim.lsp.util.apply_workspace_edit(r.edit, enc)
        end
      end
    end
    vim.lsp.buf.format({ async = false })
  end,
})

local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

lspconfig.gopls.setup({
  on_attach = on_attach
})
