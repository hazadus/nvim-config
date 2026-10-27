-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.ghcommitmsg")
require("config.commitmsg")
require("config.keymaps_normal")
require("config.keymaps_insert")

require("venv-selector").setup({
  -- Опционально: пути для поиска venv
  venv_wrappers = { "venv", ".venv", "env", ".env" },
  -- Автоматический выбор на основе .python-version или pyproject.toml
  auto_refresh = true,
})

-- Включаем проверку орфографии в текстовых файлах
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "text", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "ru", "en" }
  end,
})
