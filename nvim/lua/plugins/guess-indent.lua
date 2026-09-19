-- lua/plugins/guess-indent.lua
return {
  "nmac427/guess-indent.nvim", -- 插件仓库路径
  event = "BufReadPre", -- 优化：只在读取缓冲区之前加载
  opts = {
    auto_cmd = true, -- 启用自动命令以在加载文件时猜测缩进
    override_editorconfig = true, -- 允许覆盖.editorconfig 的设置
  },
}
