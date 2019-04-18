" download vim-plug and source it
let $BUNDLE = expand("$HOME/.vim/bundle")
let $PLUG_DIR = expand("$BUNDLE/vim-plug")

if empty(glob(expand("$PLUG_DIR/plug.vim")))
  silent !curl -fLo $PLUG_DIR/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
source $PLUG_DIR/plug.vim

" detect system
let system = {}
let system['isWindows'] = has('win16') || has('win32') || has('win64')
let system['isLinux'] = has('unix') && !has('macunix') && !has('win32unix')
let system['isOSX'] = has('macunix')
" -------------------

" 定义快捷键的前缀
let mapleader=";"
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu
"  关闭当前buffer
nmap <Leader>bd :bd<CR>

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

filetype off
call plug#begin(expand($BUNDLE))
" #########################################
Plug 'morhetz/gruvbox'
Plug 'whatyouhide/vim-gotham'
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/indexer.tar.gz'
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'
Plug 'Valloric/YouCompleteMe'
Plug 'dyng/ctrlsf.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-scripts/DrawIt'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/LeaderF'
" #########################################
call plug#end()
filetype plugin indent on

" 配色方案
set background=dark
" set background=light
colorscheme gruvbox
" colorscheme gotham256
" colorscheme solarized
" colorscheme molokai
" colorscheme phd
set t_Co=256

" 禁止光标闪烁
set gcr=a:block-blinkon0
" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T
" 总是显示状态栏
" set laststatus=2
" 显示光标当前位置
set ruler
" 开启行号显示
set number
" 高亮显示当前行/列
" set cursorline
" set cursorcolumn
" highlight CursorLine   cterm=NONE ctermbg=red ctermfg=NONE guibg=red guifg=NONE
" highlight CursorColumn cterm=NONE ctermbg=red ctermfg=NONE guibg=red guifg=red

" 80字符提示
set textwidth=80
set cc=+1
" hi ColorColumn ctermbg=23 guibg=green

" 高亮显示搜索结果
set hlsearch
" 设置 gvim 显示字体
" set guifont=Inconsolata\ Nerd\ Font\ Complete\ Windows\ Compatible\ 20
" 禁止折行
set nowrap

" 开启语法高亮功能
syntax enable
" 允许用指定语法高亮配色方案替换默认方案
syntax on

" 自适应不同语言的智能缩进
filetype indent on
" 将制表符扩展为空格
" set expandtab
" 设置编辑时制表符占用空格数
set tabstop=8
" 设置格式化时制表符占用空格数
set shiftwidth=8
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=8

" 基于缩进或语法进行代码折叠
"set foldmethod=indent
set foldmethod=syntax
" 启动 vim 时关闭折叠代码
set nofoldenable

" 设置插件 indexer 调用 ctags 的参数
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"
let g:indexer_dontUpdateTagsIfFileExists = 1
" let g:vimprj_changeCurDirIfVimprjFound = 1

" 设置 tagbar 子窗口的位置出现在主编辑区的左边
let tagbar_left=1
" 设置显示／隐藏标签列表子窗口的快捷键。速记：identifier list by tag
nnoremap <Leader>t :TagbarToggle<CR>
" 设置标签子窗口的宽度
let tagbar_width=32
" tagbar 子窗口中不显示冗余帮助信息
let g:tagbar_compact=1
" 设置 ctags 对哪些代码标识符生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
         \ 'c:classes:0:1',
         \ 'd:macros:0:1',
         \ 'e:enumerators:0:0',
         \ 'f:functions:0:1',
         \ 'g:enumeration:0:1',
         \ 'l:local:0:1',
         \ 'm:members:0:1',
         \ 'n:namespaces:0:1',
         \ 'p:functions_prototypes:0:1',
         \ 's:structs:0:1',
         \ 't:typedefs:0:1',
         \ 'u:unions:0:1',
         \ 'v:global:0:1',
         \ 'x:external:0:1'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

" 正向遍历同名标签
nmap <Leader>j :tnext<CR>
" 反向遍历同名标签
nmap <Leader>k :tprevious<CR>

" 定义快捷键关闭当前分割窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 依次遍历子窗口
" nnoremap ww <C-W><C-W>
" nnoremap wl <C-W>l
" 跳转至左方的窗口
" nnoremap wh <C-W>h
" 跳转至上方的子窗口
" nnoremap wk <C-W>k
" 跳转至下方的子窗口
" nnoremap wj <C-W>j
" 定义快捷键在结对符之间跳转
" nmap <Leader>M %

nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键
nnoremap <Leader>s :CtrlSF<CR>
" 指定搜索工具
let g:ctrlsf_ackprg = 'ag'


" 使用 NERDTree 插件查看工程文件
nmap <Leader>n :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

let g:gitgutter_max_signs=1500

" set encoding=utf-8
" set langmenu=zh_CN.UTF-8
"防止特殊符号无法正常显示
" set ambiwidth=double
"永远显示状态栏
set laststatus=2
" 支持 powerline 字体
let g:airline_powerline_fonts=1
" 显示窗口tab和buffer
let g:airline#extensions#tabline#enabled=1
" 设置tab键映射
nmap <tab> :bn<cr>
" 'papercolor'  " air line theme
let g:airline_theme='tomorrow' " 'base16_google'   'tomorrow'  'base16_spacemacs'  'base16_monokai'  'papercolor'  'base16'
" 关闭状态栏whitespace提示
let g:airline#extensions#whitespace#enabled=0

if system.isOSX
  let g:clang_use_library=1
  let g:clang_library_path='/Users/jian.cao/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clang/lib/' " '/usr/local/opt/llvm/lib'
elseif system.isLinux
  let g:clang_use_library=1
  let g:clang_library_path='/home/jian.cao/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clang/lib/' " '/usr/local/opt/llvm/lib'
endif

" set listchars=tab:»\ ,space:·,trail:•,extends:»,precedes:«
set listchars=tab:»\ ,space:·,trail:█,extends:»,precedes:«
" Display unprintable characters
set list

nmap <Leader>lf :LeaderfFile<CR>
nmap <Leader>lw :LeaderfFileCword<CR>
let g:Lf_StlSeparator = { 'left': '⮀', 'right': '⮂' }


" YCM 补全菜单配色
" 菜单
" highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
" highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
" set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
" inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 指定python版本
if system.isLinux
  let g:ycm_server_python_interpreter='/usr/bin/python'
elseif system.isOSX
  " python3-path '/usr/local/bin/python3'
  let g:ycm_python_interpreter_path='/usr/bin/python'
endif

let g:ycm_complete_in_strings = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

" 指定.ycm_extra_conf.py
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_use_clangd = 0
" debug for YCM
" let g:ycm_server_keep_logfiles = 1
" let g:ycm_server_log_level = 'debug'



" +-----------------------------------+
" C风格注释
" <leader>cs
" 取消注释
" <leader>cu
"
" 画图注释
" :Distart
" +-----------------------------------+

