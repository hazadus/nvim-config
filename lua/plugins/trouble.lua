return {
  "folke/trouble.nvim",
  opts = {
    modes = {
      symbols = {
        -- по умолчанию 30 колонок; длинные имена вида PluginProcessor::getName в .cpp не помещались
        win = { size = 60 },
      },
    },
  },
}
