<center><font size=10>Emacs配置</center><font /size=10>

  Windows 下配置Vim太过麻烦，不喜欢spacevim,所以选择了Emacs，所以选择使用spacemacs的developer分支。使用时下载spacemacs.txt，重命名为.spacemacs即可

<!--more-->
## 基本配置  

该配置文件中增加了一些自己常用的插件和配置。添加了html,auto-completion,emacs-lisp,markdown,multiple-cursors,org,spell-checking,syntax-checking和treemacs,并对syntax-checking,spell-checking和auto-completion做出了基本配置。
同时，增加了markdown文件的及时渲染插件。

配置文件中增加了国内源，防止由于网络问题带来的插件下载速度慢甚至无法下载的情况发生。

## 新增插件
### yasnippet
新增了yasnippet片段模板插件，并对org-mode进行了设置，允许在org-mode进行片段补全，使用方式如下:
首先打开相应文件，yasnippet默认首先将新片段保存为该文档格式的片段
M-x :yas-new-snippet新建模板，C-c C-c应用模板，保存时请保存到private/snippet文件夹下。
### org-cdlatex-mode
允许在org-mode中一LaTeX方式插入数学公式
### ox-gfm
允许将org文件导出为markdown格式
### LaTeX
添加了LaTeX配置，使spacemacs可以对tex文件进行编译。首先要安装LaTeX套件TexLive和PDF查看器Sumatra Pdf，并设置相应路径。
C-c-c启动编译，C-c-v查看
