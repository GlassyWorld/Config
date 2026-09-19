-- lua/plugins/nvim-spider.lua
-- 支持在 CamelCase 和 snake_case 内部进行单词导航
return {
  "chrisgrieser/nvim-spider",
  event = "VeryLazy", -- 延迟加载
  opts = {}, -- 使用默认选项
  keys = {
    -- 覆盖 'w' 键，使其在普通、操作符待决、可视模式下调用
    -- nvim-spider 的'w' 动作
    {
      "w",
      function()
        require("spider").motion("w")
      end,
      mode = { "n", "x" },
      desc = "Spider-w (移动到下一个词/子词开头)",
    },
    -- 覆盖 'e' 键
    {
      "e",
      function()
        require("spider").motion("e")
      end,
      mode = { "n", "x" },
      desc = "Spider-w (移动到词/子词末尾)",
    },
    -- 覆盖 'b' 键
    {
      "b",
      function()
        require("spider").motion("b")
      end,
      mode = { "n", "x" },
      desc = "Spider-w (移动到上一个词/子词开头)",
    },
  },
}
