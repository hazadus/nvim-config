function InsertGhCommitmsg()
  local output = vim.fn.system("gh commitmsg --language russian --examples 5")

  if vim.v.shell_error ~= 0 then
    vim.notify("Ошибка выполнения gh commitmsg: " .. output, vim.log.levels.ERROR)
    return
  end

  -- Выделяем текст между двумя блоками ```
  local blocks = {}
  for block in output:gmatch("```\n(.-)```\n") do
    table.insert(blocks, block)
  end

  -- Используем выделенный текст, если получилось, в противном случае - берём весь
  local commit_message = output
  if #blocks == 1 then
    commit_message = blocks[1]
  end

  -- Преобразуем строку в массив с разделением по переносам строк
  local lines = vim.split(commit_message, "\n", { plain = true })
  -- Сохраняем текущее положение курсора в буфере
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- Вставляем текст в текущий буфер
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, lines)
  -- Восстанавливаем положение курсора в буфере
  vim.api.nvim_win_set_cursor(0, { row, col })
end

vim.api.nvim_create_user_command("InsertGhCommitmsg", InsertGhCommitmsg, {})
