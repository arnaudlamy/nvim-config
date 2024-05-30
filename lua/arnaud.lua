-- Remapping Ctrl + p to :Leaderf file
vim.api.nvim_set_keymap('n', '<C-p>', ':Leaderf file<CR>', { noremap = true, silent = true })

-- FormatJson
vim.cmd('command! FormatJson %!python -m json.tool')

