return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = "kevinhwang91/promise-async",
    opts = {},
  }, -- nvim-ufo {for folded lines}
  { "Pocco81/auto-save.nvim" }, -- autosave
  { "norcalli/nvim-colorizer.lua" }, -- color highlighter,
  {
    "numToStr/Comment.nvim",
    opts = {},
    lazy = false,
  },
  {
    "elkowar/yuck.vim",
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

}
