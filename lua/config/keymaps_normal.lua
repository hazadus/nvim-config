-- Выводит кастомное окно красного цвета по центру экрана, исчезающее через 2 сек
local function show_custom_layout_warning()
  -- Определяем размеры экрана Neovim
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")

  -- Размеры нашего кастомного окна
  local win_width = 70
  local win_height = 5

  -- Координаты левого верхнего угла окна для размещения по центру экрана
  local row = math.floor((height - win_height) / 2)
  local col = math.floor((width - win_width) / 2)

  -- Создаём буфер с текстом для нашего окна
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "",
    "",
    "            Переключи раскладку клавиатуры на английскую!",
    "",
    "",
  })

  -- Опции нашего окна
  local opts = {
    relative = "editor", -- Относительно всего редактора
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  }

  -- Создаём наше окно
  local win = vim.api.nvim_open_win(buf, false, opts)

  -- Устанавливаем красный цвет для окна
  vim.api.nvim_win_set_option(win, "winhl", "Normal:ErrorMsg")

  -- Отложенное выполнение - закрыть окно и очистить буфер через 2 секунды
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end, 2000)
end

-- Диапазон кириллицеских символов в Unicode
for i = 0x0410, 0x044F do
  local char = vim.fn.nr2char(i) -- Преобразование Unicode в символ
  -- Назначаем на каждый кириллический символ в режиме Normal вывод уведомления о переключении раскладки
  vim.keymap.set("n", char, show_custom_layout_warning, { noremap = true, silent = true })
end

-- Выводит красное уведомление о необходимости переключения раскладки, которое исчезает через 2 сек
local function show_layout_warning()
  vim.notify(
    "Переключи раскладку клавиатуры на английскую!",
    vim.log.levels.ERROR, -- уровень ошибки для красного цвета уведомления
    { timeout = 2000 }
  )
end
