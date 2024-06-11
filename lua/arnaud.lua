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
