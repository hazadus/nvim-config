return {
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
  keys = {
    { "<leader>gv", "<cmd>DiffviewOpen<cr>", desc = "Diffview: все изменения" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: закрыть" },
    { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "Diffview: история текущего файла" },
    { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Diffview: история репозитория" },
  },
  opts = {},
}
