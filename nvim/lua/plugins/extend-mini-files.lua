-- lua/plugins/extend-mini-files.lua
return {
  "nvim-mini/mini.files",
  keys = {
    -- 重新映射<Space>e 打开当前文件所在目录
    {
      "<leader>e", -- 键位序列(<leader> 通常是Space)
      function()
        -- 打开 mini.files, vim.api.nvim_buf_get_name(0) 获取当前缓冲区文件名作为路径
        require("mini.files").open(vim.api.nvim_buf_get_name(0))
      end,
      desc = "打开 mini.files （当前文件所在目录）", -- 在 whick-key 菜单中显示的描述
    },
    -- 重新映射<Space>E 打开当前工作目录(cwd)
    {
      "<leader>E",
      function()
        -- 打开 mini.files, vim.uv.cwd() 获取当前工作目录作为路径
        require("mini.files").open(vim.uv.cwd())
      end,
      desc = "打开 mini.files (cwd)",
    },
    -- 重新映射<Space>fm 打开项目根目录
    {
      "<leader>fm",
      function()
        -- 打开 mini.files, LazyVim.root() 获取当前项目根目录作为路径
        require("mini.files").open(LazyVim.root())
      end,
      desc = "打开 mini.files (根目录)",
    },
  },
  opts = {
    -- mappings 表用于覆盖mini.files 激活时的内部按键映射
    -- windows 表用于配置mini.files 的窗口外观
    windows = {
      width_nofocus = 20,
      width_focus = 50,
      width_preview = 100,
    },
    -- options 表用于配置mini.files 的行为
    options = {
      -- 将 mini.files 设置为默认的文件浏览器(可能会影响某些操作)
      use_as_default_explorer = true,
    },
  },
}
