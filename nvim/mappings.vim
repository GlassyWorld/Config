" ===
" === Basic Mappings
" ===
" Set <LEADER> as <SPACE>, ; as :
let mapleader=" "
noremap ; :

" Save & quit
noremap Q :q<CR>
noremap <C-q> :qa<CR>
noremap <C-s> :w<CR>

" Open the vimrc file anytime
noremap <LEADER>rc :e ~/.config/nvim/init.vim<CR>

" Resource vimrc
noremap <LEADER>r :source $MYVIMRC<CR>

" Indentation
nnoremap < <<
nnoremap > >>

" Search
noremap <LEADER><CR> :nohlsearch<CR>

" Adjacent duplicate words
noremap <LEADER>dw /\(\<\w\+\>\)\_s*\1

" Space to Tab
" nnoremap <LEADER>tt :%s/    /\t/g
" vnoremap <LEADER>tt :s/    /\t/g

" Folding
noremap <silent> <LEADER>o za

" Open up lazygit
" noremap \g :Git 
" noremap <c-g> :enew<CR>:term lazygit<CR>
" nnoremap <c-n> :enew<CR>:term lazynpm<CR>


" ===
" === Cursor Movement
" ===

inoremap <C-a> <ESC>
inoremap <C-w> <ESC>:w<CR>
inoremap <C-f> <ESC>0<insert>

source ~/.config/nvim/cursor.vim

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
noremap <LEADER>j  <C-w>j
noremap <LEADER>k  <C-w>k

" Disable the default s key
noremap s <nop>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap sj :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sk :set splitbelow<CR>:split<CR>
noremap sh :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H


" ===
" === Tab/Buffer management
" ===

" Tabs
" Create a new tab with tj
noremap tj :tabe<CR>
" Move around tabs with tn and ti
noremap tj :-tabnext<CR>
noremap tk :+tabnext<CR>
" Move the tabs with tmn and tmi
"noremap tmn :-tabmove<CR>
"noremap tmi :+tabmove<CR>

" Buffers
nnoremap <silent> tl :ls<CR>
nnoremap <silent> tu :enew<CR>
nnoremap <silent> ti :bnext<CR>
nnoremap <silent> tn :bprevious<CR>
nnoremap <silent> te :bdelete<CR>

