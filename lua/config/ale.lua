-- ALE configuration
vim.g.ale_linters = {
    javascript = {'eslint'},
    python = {'flake8'},
}
vim.g.ale_fixers = {
    javascript = {'prettier_eslint', 'eslint'},
    python = {'black', 'isort'},
}
vim.g.ale_python_black_options = '--line-length=160'

-- Enable linting and fixing on save
vim.g.ale_lint_on_save = 1
vim.g.ale_fix_on_save = 1

-- Optional: use signs and virtual text to display linting errors
vim.g.ale_sign_error = '✘'
vim.g.ale_sign_warning = '⚠'
vim.g.ale_sign_hint = '…'
vim.g.ale_sign_info = '…'
vim.g.ale_virtualtext_prefix = ' '
