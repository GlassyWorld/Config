# Vim配置文件介绍,NeoVim同样适用

## 插件列表

| 插件作用             | 插件名                           |
| ----------           | -----------                      |
| 插件管理器           | vim-plug                         |
| 底部状态栏           | vim-airline,vim-airline-themes   |
| 主题                 | vim-snazzy                       |
| 目录树               | nerdtree,nerdtree-git-plugin     |
| 函数列表             | tagbar                           |
| 语法检查             | ale                              |
| 文件更改历史         | undotree                         |
| 增强插件             | vim-indent-guides,vim-cursorword |
| pythoon              | indentpython.vim                 |
| Markdown预览         | markdown-preview-vim             |
| Markdown表格格式化   | vim-table-mode                   |
| 笔记插件             | vimwiki                          |
| Bookmarks            | vim-signature                    |
| 专注模式             | goyo.vim                         |
| 自动补全             | coc.nvim                         |
| LaTeX                | vimtex,vim-latexlive-preview     |
| 代码片段             | vim-snippets                     |
| 自动补全括号         | auto-pairs                       |
| 显示带有细垂线的缩进 | indentLine                       |
| 开始界面             | vim-startify                     |
| 彩色括号             | rainbow__parentheses.vim         |
| 文件模板             | vim-template                     |

## 部分插件配置注意事项
* coc.nvim插件的配置文件在coc-settings.json中
* snippits.vim是.vimrc的扩展配置，里面相应配置了Markdown文件的部分常用快捷键
* vimtex

    * 需要手动安装Zathura来浏览编译完成的PDF文件
    * Manjaro KDE安装Zatura后还要安装Zatura-cb和Zatura-pdf-popler才能正常显示PDF文件
    * 若想使用xelatex编译，则需要在～目录下新建.latexmkrc，文件内容见latexmkrc
