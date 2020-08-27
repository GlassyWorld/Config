
" __  ____   __  _   ___     _____ __  __ ____   ____
"|  \/  \ \ / / | \ | \ \   / /_ _|  \/  |  _ \ / ___|
"| |\/| |\ V /  |  \| |\ \ / / | || |\/| | |_) | |
"| |  | | | |   | |\  | \ V /  | || |  | |  _ <| |___
"|_|  |_| |_|   |_| \_|  \_/  |___|_|  |_|_| \_\\____|

" Author: @GlassyWorld

" Checkout-list
" vim-esearch
" fmoralesc/worldslice
" SidOfc/mkdx


" ===
" === Auto load for first time uses
" ===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
  let has_machine_specific_file = 0
  silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


" ===
" === Plugin On
" ===

filetype on
filetype indent on
filetype plugin on
filetype plugin indent on


" ====================
" === Editor Setup ===
" ====================
" ===
" === System
" ===
"set clipboard=unnamedplus
let &t_ut=''
set autochdir


" ===
" === Editor behavior
" ===

syntax enable
syntax on
set autoread
set number
set relativenumber
set cursorline
set hidden
set noexpandtab
set tabstop=4
set history=1000
set shiftwidth=2
set softtabstop=2
set autoindent
set hlsearch
set list
set listchars=tab:\|\ ,trail:▫
set scrolloff=4
set ttimeoutlen=0
set notimeout
set viewoptions=cursor,folds,slash,unix
set wrap
set tw=0
set indentexpr=
set foldmethod=indent
set foldlevel=99
set foldenable
set formatoptions-=tc
set splitright
set splitbelow
set noshowmode
set showcmd
set wildmenu
set ignorecase
set incsearch
set mouse=a
set smartcase
set showmatch
set shortmess+=c
set inccommand=split
set completeopt=longest,noinsert,menuone,noselect,preview
set ttyfast "should make scrolling faster
set lazyredraw "same as above
set visualbell
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
  set undofile
  set undodir=~/.config/nvim/tmp/undo,.
endif
set colorcolumn=100
set updatetime=100
set virtualedit=block

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Copy to system clipboard
vnoremap Y :w !xclip -i -sel c<CR>
" Cursor shape
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"设置编码,支持中文不乱码
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8


" ===
" === Terminal Behaviors
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'


" ===
" === Basik mappings
" === Set leader as space

let mapleader = "\<space>"  "设置leader键为空格
noremap ; :
" Save & quit
noremap S :w<CR>
noremap <LEADER>q :q<CR>
noremap <LEADER>wq :wq<CR>


" Insert Mode Cursor Movement
inoremap <C-a> <Esc>
inoremap <C-w> <Esc>:w<CR>

source ~/.config/nvim/cursor.vim

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Resource vimrc
map <LEADER>r :source $MYVIMRC<CR>

noremap <LEADER><CR> :nohlsearch<CR>

"Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Space to Tab
nnoremap <LEADER>tt :%s/    /\t/g
vnoremap <LEADER>tt :s/    /\t/g

" Folding
noremap <silent> <LEADER>o za

" Open up lazygit
noremap \g :Git
noremap <c-g> :tabe<CR>:-tabmove<CR>:term lazygit<CR>


" ===
" === Command Mode Cursor Movement
" ===
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-w> <S-Right>


" ===
" === Window management
" ===
" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>h  <C-w>h
noremap <LEADER>l  <C-w>l
map <LEADER>j  <C-w>j
map <LEADER>k  <C-w>k


" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sl :set splitright<CR>:vsplit<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>
noremap sj :set nosplitbelow<CR>:split<CR>
noremap sk :set splitbelow<CR>:split<CR>


" Resize splits with arrow keys
map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

" Place the two screens side by side
map <LEADER>sv <C-w>t<C-w>H
" Place the two screens up and down
map <LEADER>sh <C-w>t<C-w>K

" ===
" === Tab management
" ===
" Create a new tab with tu
map <LEADER>tu :tabe<CR>
" Move around tabs with tk and tj
map <LEADER>tk :-tabnext<CR>
map <LEADER>tj :+tabnext<CR>


" ===
" === Markdown Settings
" ===
" Snippets
source ~/.config/nvim/md-snippets.vim
"cauto spell
autocmd BufRead,BufNewFile *.md setlocal spell

" ===
" === Other useful stuff
" ===
" Open a new instance of st with the cwd

" Opening a terminal window
noremap <LEADER>/ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Press space twice to jump to the next '<++>' and edit it
noremap <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Spelling Check with <space>sc
noremap <LEADER>sc :set spell!<CR>

" Find and replace global
noremap \s :%s//g<left><left>




" 将F4绑定为跳出括号
inoremap <F4> <c-r>=SkipPair()<CR>
"设置跳出自动补全的括号
func SkipPair()
  if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
	return "\<ESC>la"
  else
	return "\t"
  endif
endfunc

"设置<F5>自动编译运行当前程序
map <F5> :call CompileRunGcc()<CR>

func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
	exec '!g++ % -o %<'
	exec '!time ./%<'
  elseif &filetype == 'cpp'
	set splitbelow
	exec "!g++ -std=c++11 % -Wall -o %<"
	"exec '!time ./%<'
	:term ./%<
  elseif &filetype == 'python'
	set splitbelow
	:term python3 %
  elseif &filetype == 'sh'
	:!time bash %
  endif
endfunction


" ===
" === Install Plugins with Vim-Plug
" ===

call plug#begin('~/.vim/plugged')

" Pretty Dress
" Plug 'vim-airline/vim-airline'           "底部状态栏
" Plug 'vim-airline/vim-airline-themes'
" Plug 'connorholyday/vim-snazzy'           "主题
" Plug 'morhetz/gruvbox'
" Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'bling/vim-bufferline'
Plug 'bpietravalle/vim-bolt'
Plug 'ajmwagar/vim-deus'

" Status line
Plug 'theniceboy/eleline.vim'

"General Highlighter
Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'RRethy/vim-illuminate'

" File navigation
" Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'kevinhwang91/rnvimr'
Plug 'airblade/vim-rooter'
Plug 'pechorin/any-jump.vim'


" Taglist
Plug 'liuchengxu/vista.vim'

" Error checking
Plug 'w0rp/ale'

" Debugger
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python --enable-go'}

"Auto-complete
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" Plug 'wellle/tmux-complete.vim'

" Snippets
" Plug 'SirVer/ultisnips'
Plug 'theniceboy/vim-snippets'

" Undo Tree
Plug 'mbbill/undotree/'

" Other visual enhancement
Plug 'mhinz/vim-startify'


" Git
Plug 'theniceboy/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }
Plug 'fszymanski/fzf-gitignore', { 'do': ':UpdateRemotePlugins' }
"Plug 'mhinz/vim-signify'
Plug 'airblade/vim-gitgutter'
Plug 'cohama/agit.vim'

" Autoformat
Plug 'Chiel92/vim-autoformat'

" For latex
Plug 'lervag/vimtex'

" Python
" Plug 'vim-scripts/indentpython.vim', { 'for' :['python', 'vim-plug'] }
" Plug 'tmhedberg/SimpylFold'
Plug 'hdima/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent',{'for' :['python','vim-plug']}
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'vim-plug'] }


" Markdown
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'mzlogin/vim-markdown-toc'
Plug 'itchyny/calendar.vim'

" Bookmarks
Plug 'kshenoy/vim-signature'

" Other useful utilities
Plug 'junegunn/goyo.vim' " distraction free writing mode

" Editor Enhancement
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi'
Plug 'tomtom/tcomment_vim' " in <space>cn to comment a line
Plug 'theniceboy/antovim' " gs to switch
Plug 'tpope/vim-surround' " type yskw' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'gcmt/wildfire.vim' " in Visual mode, type k' to select all text in '', or type k) k] k} kp
Plug 'junegunn/vim-after-object' " da= to delete what's after =
Plug 'godlygeek/tabular' " ga, or :Tabularize <regex> to align
Plug 'tpope/vim-capslock'	" Ctrl+L (insert) to toggle capslock
Plug 'easymotion/vim-easymotion'
Plug 'svermeulen/vim-subversive'
Plug 'theniceboy/argtextobj.vim'
Plug 'rhysd/clever-f.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'AndrewRadev/splitjoin.vim'


" Vim Applications
Plug 'itchyny/calendar.vim'
Plug 'vimwiki/vimwiki'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'

" Other visual enhancement
Plug 'ryanoasis/vim-devicons'
Plug 'luochen1990/rainbow'
Plug 'mg979/vim-xtabline'
Plug 'wincent/terminus'
Plug 'mhinz/vim-startify'           "开始界面
Plug 'aperezdc/vim-template'        "文件模板

" Other useful utilities
Plug 'lambdalisue/suda.vim' " do stuff like :sudowrite

call plug#end()


set re=0
" experimental
set lazyredraw

" ===
" === Dress up my vim
" ===
set termguicolors " enable true colors support
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
color deus
"colorscheme snazzy
"color dracula
"color gruvbox

hi NonText ctermfg=gray guifg=grey10


" ===================== Start of Plugin Settings =====================


" ===
" === NERDTree
" ===
" map <LEADER>ft :NERDTreeToggle<CR>
" let NERDTreeMapOpenExpl = ""
" let NERDTreeMapUpdir = ""
" let NERDTreeMapUpdirKeepOpen = "l"
" let NERDTreeMapOpenSplit = ""
" let NERDTreeOpenVSplit = ""
" let NERDTreeMapActivateNode = "i"
" let NERDTreeMapOpenInTab = "o"
" let NERDTreeMapPreview = ""
" let NERDTreeMapCloseDir = "n"
" let NERDTreeMapChangeRoot = "y"


" ==
" == NERDTree-git
" ==
" let g:NERDTreeIndicatorMapCustom = {
"             \ "Modified"  : "✹",
"             \ "Staged"    : "✚",
"             \ "Untracked" : "✭",
"             \ "Renamed"   : "➜",
"             \ "Unmerged"  : "═",
"             \ "Deleted"   : "✖",
"             \ "Dirty"     : "✗",
"             \ "Clean"     : "✔︎",
"             \ "Unknown"   : "?"
"             \ }
"


" ===
" === ale
" ===
let b:ale_linters = ['pylint']
let b:ale_fixers = {
	  \ 'python':['add_blank_lines_for_python_control_statements','autopep8','isort','yapf',
	  \ 'remove_trailing_lines','trim_whitespace'],
	  \ 'markdown': ['prettier','remove_trailing_lines','trim_whitespace'],
	  \ }


" ===
" === eleline.vim
" ===
let g:airline_powerline_fonts = 0


" ==
" == GitGutter
" ==
" let g:gitgutter_signs = 0
let g:gitgutter_sign_allow_clobber = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
let g:gitgutter_sign_added = '▎'
let g:gitgutter_sign_modified = '░'
let g:gitgutter_sign_removed = '▏'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '▒'
" autocmd BufWritePost * GitGutter
nnoremap <LEADER>gf :GitGutterFold<CR>
nnoremap H :GitGutterPreviewHunk<CR>
nnoremap <LEADER>g- :GitGutterPrevHunk<CR>
nnoremap <LEADER>g= :GitGutterNextHunk<CR>


"coc.nvim
"To support completion trigger on insert enter
" Installing plugins
let g:coc_global_extensions = [
	  \ 'coc-actions',
	  \ 'coc-css',
	  \ 'coc-explorer',
	  \ 'coc-gitignore',
	  \ 'coc-highlight',
	  \ 'coc-json',
	  \ 'coc-lists',
	  \ 'coc-prettier',
	  \ 'coc-pyright',
	  \ 'coc-python',
	  \ 'coc-snippets',
	  \ 'coc-sourcekit',
	  \ 'coc-stylelint',
	  \ 'coc-syntax',
	  \ 'coc-tasks',
	  \ 'coc-texlab',
	  \ 'coc-todolist',
	  \ 'coc-translator',
	  \ 'coc-tslint-plugin',
	  \ 'coc-tsserver',
	  \ 'coc-vimlsp',
	  \ 'coc-yank']
"use <tab> for trigger completion and navigate to the next complete item
inoremap <silent><expr> <Tab>
	  \ pumvisible() ? "\<C-n>" :
	  \<SID>check_back_space() ? "\<Tab>" :
	  \coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <silent><expr> <c-o> coc#refresh()
function! Show_documentation()
  call CocActionAsync('highlight')
  if (index(['vim','help'], &filetype) >= 0)
	execute 'h '.expand('<cword>')
  else
	call CocAction('doHover')
  endif
endfunction
nnoremap <LEADER>hs :call Show_documentation()<CR>

nnoremap <silent><nowait> <LEADER>d :CocList diagnostics<cr>
nmap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nnoremap <c-c> :CocCommand<CR>


" ===
" === coc.snippets
" ===
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'



" Text Objects
xmap kf <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap kf <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap kc <Plug>(coc-classobj-i)
omap kc <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)



" Useful commands
nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <LEADER>rn <Plug>(coc-rename)
" coc-explorer
nmap tt :CocCommand explorer<CR>
" coc-translator
nmap ts <Plug>(coc-translator-p)

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" coctodolist
nnoremap <leader>tn :CocCommand todolist.create<CR>
nnoremap <leader>tl :CocList todolist<CR>
nnoremap <leader>tu :CocCommand todolist.download<CR>:CocCommand todolist.upload<CR>
" coc-tasks
noremap <silent> <leader>ts :CocList tasks<CR>
" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-e> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-e>'
let g:coc_snippet_prev = '<c-n>'
imap <C-e> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'GlassyWorld'


" ===
" === vim-instant-markdown
" ===
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
let g:instant_markdown_autoscroll = 1


" ===
" === vim-markdown-toc
" ===
"let g:vmt_auto_update_on_save = 0
"let g:vmt_dont_insert_fence = 1
let g:vmt_cycle_list_item_markers = 1
let g:vmt_fence_text = 'TOC'
let g:vmt_fence_closing_text = '/TOC'


" ===
" === vim-table-mode
" ===
map <LEADER>tm :TableModeToggle<CR>
let g:table_mode_cell_text_object_i_map = 'k<Bar>'


" ===
" === FZF
" ===
set rtp+=/usr/local/opt/fzf
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf
set rtp+=/home/david/.linuxbrew/opt/fzf
" noremap <silent> <C-p> :Files<CR>
noremap <silent> <C-p> :Leaderf file<CR>
noremap <silent> <C-f> :Rg<CR>
noremap <silent> <C-h> :History<CR>
"noremap <C-t> :BTags<CR>
noremap <silent> <C-l> :Lines<CR>
noremap <silent> <C-w> :Buffers<CR>
noremap <leader>; :History:<CR>

let g:fzf_preview_window = 'right:60%'
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
	  \ 'source': s:list_buffers(),
	  \ 'sink*': { lines -> s:delete_buffers(lines) },
	  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
	  \ }))

noremap <c-d> :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }


" ===
" === Leaderf
" ===
" let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewCode = 1
let g:Lf_ShowHidden = 1
let g:Lf_ShowDevIcons = 1
let g:Lf_CommandMap = {
	  \   '<C-k>': ['<C-u>'],
	  \   '<C-j>': ['<C-e>'],
	  \   '<C-]>': ['<C-v>'],
	  \   '<C-p>': ['<C-n>'],
	  \}

" ===
" === Undotree
" ===
noremap L :UndotreeToggle<CR>
let g:undotree_DiffAutoOpen = 1
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_WindowLayout = 2
let g:undotree_DiffpanelHeight = 8
let g:undotree_SplitWidth = 24
function g:Undotree_CustomMap()
  nmap <buffer> u <plug>UndotreeNextState
  nmap <buffer> e <plug>UndotreePreviousState
  nmap <buffer> U 5<plug>UndotreeNextState
  nmap <buffer> E 5<plug>UndotreePreviousState
endfunc

" ===
" === Vimwiki
" ===
let g:vimwiki_list = [{'path': '~/Work/vimwiki/',
	  \ 'ext': '.markdown', 'syntax': 'markdown'}]
map <A-Space> <Plug>VimwikiToggleListItem
let g:vimwiki_table_mappings = 0
let g:vimwiki_global_ext = 0
map <LEADER>t :VimwikiTable<CR>
let g:vimwiki_use_calendar = 1

" ===
" === vim-visual-multi
" ===
"let g:VM_theme             = 'iceblue'
"let g:VM_default_mappings = 0
let g:VM_leader                     = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_maps                       = {}
let g:VM_custom_motions             = {'n': 'h', 'i': 'l', 'u': 'k', 'e': 'j', 'N': '0', 'I': '$', 'h': 'e'}
let g:VM_maps['i']                  = 'k'
let g:VM_maps['I']                  = 'K'
let g:VM_maps['Find Under']         = '<C-k>'
let g:VM_maps['Find Subword Under'] = '<C-k>'
let g:VM_maps['Find Next']          = ''
let g:VM_maps['Find Prev']          = ''
let g:VM_maps['Remove Region']      = 'q'
let g:VM_maps['Skip Region']        = '<c-n>'
let g:VM_maps["Undo"]               = 'l'
let g:VM_maps["Redo"]               = '<C-r>'

" ===
" === Far.vim
" ===
noremap <LEADER>f :F  **/*<left><left><left><left><left>
let g:far#mapping = {
	  \ "replace_undo" : ["l"],
	  \ }

" ===
" === Bullets.vim
" ===
" let g:bullets_set_mappings = 0
let g:bullets_enabled_file_types = [
	  \ 'markdown',
	  \ 'text',
	  \ 'gitcommit',
	  \ 'scratch'
	  \]

" ===
" === Vista.vim
" ===
noremap <LEADER>v :Vista coc<CR>
noremap <c-t> :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'ctags'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
	  \   "function": "\uf794",
	  \   "variable": "\uf71b",
	  \  }

" ===
" === fzf-gitignore
" ===
noremap <LEADER>gi :FzfGitignore<CR>



" ===
" === vimtex
" ===
let g:vimtex_compiler_progname = 'nvr'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_quickfix_mode=0
let g:Tex_CompileRule_pdf = 'xelatex -src-specials -synctex=1 -interaction=nonstopmode $*'
"let g:vimtex_view_general_options_latexmk = '-reuse-instance'
let g:vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'
"隐藏功能，除光标所在行，文本中的LaTeX代码会隐藏
"set conceallevel=1
"let g:tex_conceal='abdmg'
map <LEADER>lc :VimtexCompile <CR>


" ===
" === vim-calendar
" ===
"noremap \c :Calendar -position=here<CR>
noremap \\ :Calendar -view=clock -position=here<CR>
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
augroup calendar-mappings
  autocmd!
  " diamond cursor
  autocmd FileType calendar nmap <buffer> k <Plug>(calendar_up)
  autocmd FileType calendar nmap <buffer> h <Plug>(calendar_left)
  autocmd FileType calendar nmap <buffer> j <Plug>(calendar_down)
  autocmd FileType calendar nmap <buffer> l <Plug>(calendar_right)
  autocmd FileType calendar nmap <buffer> <c-k> <Plug>(calendar_move_up)
  autocmd FileType calendar nmap <buffer> <c-h> <Plug>(calendar_move_left)
  autocmd FileType calendar nmap <buffer> <c-j> <Plug>(calendar_move_down)
  autocmd FileType calendar nmap <buffer> <c-l> <Plug>(calendar_move_right)
  autocmd FileType calendar nmap <buffer> i <Plug>(calendar_start_insert)
  autocmd FileType calendar nmap <buffer> I <Plug>(calendar_start_insert_head)
  " unmap <C-n>, <C-p> for other plugins
  autocmd FileType calendar nunmap <buffer> <C-n>
  autocmd FileType calendar nunmap <buffer> <C-p>
augroup END


" ===
" === AutoFormat
" ===
nnoremap <LEADER>af :Autoformat<CR>
let g:formatdef_custom_js = '"js-beautify -t"'
let g:formatters_javascript = ['custom_js']
au BufWrite *.js :Autoformat


" ===
" === vim-easymotion
" ===
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_do_shade = 0
let g:EasyMotion_smartcase = 1

" ===
" === Goyo
" ===
map <LEADER>gy :Goyo<CR>


" ===
" === tabular
" ===
vmap ga :Tabularize /


" ===
" === vim-after-object
" ===
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')


" ===
" === rainbow
" ===
let g:rainbow_active = 1


" ===
" === xtabline
" ===
let g:xtabline_settings = {}
let g:xtabline_settings.enable_mappings = 0
let g:xtabline_settings.tabline_modes = ['tabs', 'buffers']
let g:xtabline_settings.enable_persistance = 0
let g:xtabline_settings.last_open_first = 1
noremap to :XTabCycleMode<CR>
noremap \p :echo expand('%:p')<CR>



" ===
" === suda.vim
" ===
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%


" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
  " has to be a function to avoid the extra space fzf#run insers otherwise
  execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
	  \   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
	  \   'down': 20,
	  \   'sink': function('<sid>read_template_into_buffer')
	  \ })
" noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBad


" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
	  \ '<C-t>': 'NvimEdit tabedit',
	  \ '<C-x>': 'NvimEdit split',
	  \ '<C-v>': 'NvimEdit vsplit',
	  \ 'gw': 'JumpNvimCwd',
	  \ 'yw': 'EmitRangerCwd'
	  \ }
let g:rnvimr_layout = { 'relative': 'editor',
	  \ 'width': &columns,
	  \ 'height': &lines,
	  \ 'col': 0,
	  \ 'row': 0,
	  \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]


" ===
" === vim-illuminate
" ===
let g:Illuminate_delay = 750
hi illuminatedWord cterm=undercurl gui=undercurl



" ===
" === vim-rooter
" ===
let g:rooter_patterns = ['__vim_project_root', '.git/']
let g:rooter_silent_chdir = 1


" ===
" === AsyncRun
" ===
noremap gp :AsyncRun git push<CR>


" ===
" === AsyncTasks
" ===
let g:asyncrun_open = 6


" ===
" === tcomment_vim
" ===
nnoremap ci cl
let g:tcomment_textobject_inlinecomment = ''
nmap <LEADER>cn g>c
vmap <LEADER>cn g>
nmap <LEADER>cu g<c
vmap <LEADER>cu g<


" ===
" === NrrwRgn
" ===
let g:nrrw_rgn_nomap_nr = 1
let g:nrrw_rgn_nomap_Nr = 1
noremap <c-y> :NR<CR>


" ===
" === any-jump
" ===
nnoremap <LEADER>j :AnyJump<CR>
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.9


" ===
" === Agit
" ===
nnoremap <LEADER>gl :Agit<CR>
let g:agit_no_default_mappings = 1


" ===
" === vim-signature
" ===
let g:SignatureMap = {
	  \ 'Leader'             :  "m",
	  \ 'PlaceNextMark'      :  "m,",
	  \ 'ToggleMarkAtLine'   :  "m.",
	  \ 'PurgeMarksAtLine'   :  "dm-",
	  \ 'DeleteMark'         :  "dm",
	  \ 'PurgeMarks'         :  "dm/",
	  \ 'PurgeMarkers'       :  "dm?",
	  \ 'GotoNextLineAlpha'  :  "m<LEADER>",
	  \ 'GotoPrevLineAlpha'  :  "",
	  \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
	  \ 'GotoPrevSpotAlpha'  :  "",
	  \ 'GotoNextLineByPos'  :  "",
	  \ 'GotoPrevLineByPos'  :  "",
	  \ 'GotoNextSpotByPos'  :  "mn",
	  \ 'GotoPrevSpotByPos'  :  "mp",
	  \ 'GotoNextMarker'     :  "",
	  \ 'GotoPrevMarker'     :  "",
	  \ 'GotoNextMarkerAny'  :  "",
	  \ 'GotoPrevMarkerAny'  :  "",
	  \ 'ListLocalMarks'     :  "m/",
	  \ 'ListLocalMarkers'   :  "m?"
	  \ }




" ===================== End of Plugin Settings =====================


" ===
" === Necessary Commands to Execute
" ===
exec "nohlsearch"


" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
  exec "e ~/.config/nvim/_machine_specific.vim"
endif

