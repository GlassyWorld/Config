-- /lua/plugins/blink.lua
-- Configure blink.cmp completion behavior
-- Disable preselect
return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
    },
  },
}
