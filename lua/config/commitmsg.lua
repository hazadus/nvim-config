function InsertCommitmsg()
  -- Перед выполнением команды нужные изменения должны быть добавлены в
  -- staging area через `git add .`, например. Также предполагается, что
  -- дифф делается с главной веткой.
  -- TODO: придумать что-то для работы в других ветках!
  local diff = vim.fn.system("git diff main")

  if vim.v.shell_error ~= 0 then
    vim.notify("Ошибка выполнения git diff main: " .. diff, vim.log.levels.ERROR)
    return
  end

  local prompt = table.concat({
    "Составь commit message в стиле conventional commit по приведённому git diff.",
    "Ответь просто текстом, без ```text...```  и прочих излишеств.",
    "В теле собщения кратко перечисли, что изменено и причины изменений, если это уместно.",
    "Правила оформления сообщения о коммите:",
    "- Описание — на русском языке",
    "- Тема — до 72 символов, без точки в конце, в повелительном наклонении (добавить, исправить, и т.п.).",
    "- Тело — каждая строка до 90 символов.",
    "",
    "Diff:",
    diff,
  }, "\n")

  local commit_message = vim.fn.system({
    "opencode",
    "run",
    "--model",
    "openrouter/openai/gpt-6-luna",
    prompt,
  })

  if vim.v.shell_error ~= 0 then
    vim.notify("Ошибка выполнения opencode: " .. commit_message, vim.log.levels.ERROR)
    return
  end

  -- Преобразуем строку в массив с разделением по переносам строк
  local lines = vim.split(commit_message, "\n", { plain = true })
  -- Сохраняем текущее положение курсора в буфере
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Вставляем текст в текущий буфер. Пропускаем первые две строки, потому что в них
  -- OpenCode выдаёт служебную информацию.
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, vim.list_slice(lines, 3))
  -- Восстанавливаем положение курсора в буфере
  vim.api.nvim_win_set_cursor(0, { row, col })
end

-- Команда выполняется через <Esc>:InsertCommitmsg
vim.api.nvim_create_user_command("InsertCommitmsg", InsertCommitmsg, {})
