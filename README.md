# Config
各种配置文件
## 防止各种配置文件丢失，留做备份
## git配置免密方式
vim ~/.git-credentials

https://{username}:{passwd}@github.com

终端运行
git config --global credential.helper store
查看~/.gitconfig文件的变化
[credential]\
	helper = store
