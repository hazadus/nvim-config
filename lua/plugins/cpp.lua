return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      clangd = {
        -- Корень проекта — каталог с .clangd или compile_commands.json, и только потом .git.
        -- Иначе файлы из libs/juce (там свой .git) запускают отдельный clangd.
        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, { ".clangd", "compile_commands.json" }) or vim.fs.root(bufnr, { ".git" })
          if root then
            on_dir(root)
          end
        end,
      },
    },
  },
}
