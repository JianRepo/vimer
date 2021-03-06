let $BUNDLE = expand("$HOME/.vim/bundle")
let $PLUG_DIR = expand("$BUNDLE/vim-plug")

if empty(glob(expand("$PLUG_DIR/plug.vim")))
  silent !curl -fLo $PLUG_DIR/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif
source $PLUG_DIR/plug.vim
" detect system ----------------------------------------------------------------
let system = {}
let system['isWindows'] = has('win16') || has('win32') || has('win64')
let system['isLinux'] = has('unix') && !has('macunix') && !has('win32unix')
let system['isOSX'] = has('macunix')

" PlugList ---------------------------------------------------------------------
call plug#begin(expand($BUNDLE))
Plug 'morhetz/gruvbox'                                  , { 'on' : 'colorscheme gruvbox' }
Plug 'whatyouhide/vim-gotham'                           , { 'on' : 'colorscheme gotham256' }
Plug 'altercation/vim-colors-solarized'                 , { 'on' : 'colorscheme solarized' }
Plug 'tomasr/molokai'                                   , { 'on' : 'colorscheme molokai' }
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'YCbCr/tagbar'
Plug 'vim-scripts/indexer.tar.gz'
Plug 'vim-scripts/DfrankUtil'
Plug 'vim-scripts/vimprj'
Plug 'Valloric/YouCompleteMe'                           , { 'on' : [] } " CPU too high
Plug 'dyng/ctrlsf.vim'                                  , { 'on' : 'CtrlSF'  }
Plug 'scrooloose/nerdtree'                              , { 'on' : 'NERDTreeToggle' }
Plug 'vim-scripts/DrawIt'                               , { 'on' : 'DrawIt' }
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'YCbCr/vim-airline'                                , { 'on' : [] }
Plug 'vim-airline/vim-airline-themes'                   , { 'on' : [] }
Plug 'Yggdroot/LeaderF'                                 , { 'on' : 'LeaderfFile' }
Plug 'YCbCr/FlyGrep.vim'                                , { 'on' : 'FlyGrep' }
Plug 'mhinz/vim-startify'
Plug 'xolox/vim-easytags'                               , { 'on' : [] }  " CPU too high
Plug 'xolox/vim-misc'                                   , { 'on' : [] }  " vim-easytags need this plugin
Plug 'vim-scripts/TagHighlight'                         , { 'on' : [] }
Plug 'junegunn/fzf'                                     , { 'dir': '$HOME/.vim/bundle/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'YCbCr/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'jeaye/color_coded'                                , { 'on' : [] }
Plug 'mbriggs/mark.vim'
Plug 'yonchu/accelerated-smooth-scroll'
Plug 'simnalamburt/vim-mundo'
Plug 'vim-scripts/LargeFile'
Plug 'edkolev/tmuxline.vim'

" SnipMate 携带的四个插件
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'

" Jedi
Plug 'davidhalter/jedi-vim'

" EasyComplete 插件和 Dictionary 词表
Plug 'jayli/vim-easycomplete'
Plug 'jayli/vim-dictionary'                             , { 'on' : [] } " bad performance when opening
call plug#end()

" PlugList - lazy load ---------------------------------------------------------
augroup group_exec
    autocmd!
    autocmd VimEnter * hi Normal guifg=#83a598 ctermfg=109 | hi! link StartifyFile GruvboxRedBold
    autocmd vimEnter * set tags+=getcwd()/tags | autocmd! group_exec
augroup END

"augroup ops_exec
"    autocmd!
"    autocmd InsertEnter * call plug#load('YouCompleteMe') | autocmd! ops_exec
"augroup END

augroup set_syn
    autocmd!
    autocmd BufEnter * syn keyword cType u8 s8 u16 s16 u32 s32 u64 s64 dma_addr_t autocmd! set_syn
augroup END

" initial setting --------------------------------------------------------------
set ff=unix                                   " 避免DOS结尾报错(^M)
let mapleader=";"                             " 定义快捷键的前缀
let maplocalleader=","
set incsearch                                 " 开启实时搜索功能
set ignorecase                                " 搜索时大小写不敏感
set nocompatible                              " 关闭兼容模式
set wildmenu                                  " vim 自身命令行模式智能补全
set updatetime=100                            " 刷新时间
set relativenumber                            " 显示相对行号

"                                             " 关闭当前buffer
nmap <Leader>bd :bd<CR>

autocmd BufWritePost $MYVIMRC source $MYVIMRC " 让配置变更立即生效

set listchars=tab:»\ ,space:·,trail:█,extends:»,precedes:«
" set listchars=tab:-\ ,space:-,trail:@,extends:>,precedes:<
set list                                      " 显示不可打印字符
syntax enable                                 " 开启语法高亮功能
syntax on                                     " 允许用指定语法高亮配色方案替换默认方案

filetype plugin indent on
set background=dark                           " 配色方案
" set background=light
colorscheme gruvbox
let g:gruvbox_italic = 1
let g:gruvbox_italicize_comments = 0
" let g:gruvbox_italicize_strings = 1
" colorscheme gotham256                       " 夜间
" colorscheme solarized
" colorscheme molokai
" colorscheme phd
set t_Co=256
set gcr=a:block-blinkon0                      " 禁止光标闪烁
set guioptions-=l                             " 禁止显示滚动条
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m                             " 禁止显示菜单和工具条
set guioptions-=T
set laststatus=2                              " 总是显示状态栏
set showtabline=2                             " 总是显示tabline
set ruler                                     " 显示光标当前位置
set number                                    " 开启行号显示
"set cursorline                              " 高亮显示当前行/列
"set cursorcolumn
" highlight CursorLine   cterm=NONE ctermbg=red ctermfg=NONE guibg=red guifg=NONE
" highlight CursorColumn cterm=NONE ctermbg=red ctermfg=NONE guibg=red guifg=red

"set textwidth=80                              " 80字符提示 (满80自动换行)
"set cc=+1
set cc=81                                      " 80字符提示

" hi ColorColumn ctermbg=23 guibg=green

set hlsearch                                  " 高亮显示搜索结果
" set guifont=                                " 设置 gvim 显示字体
set nowrap                                    " 禁止折行

filetype indent on                            " 自适应不同语言的智能缩进
" set expandtab                               " 将制表符扩展为空格
set tabstop=8                                 " 设置编辑时制表符占用空格数
set shiftwidth=8                              " 设置格式化时制表符占用空格数
set softtabstop=8                             " 让 vim 把连续数量的空格视为一个制表符
set pastetoggle=<Leader>p                     " paste 模式
"set foldmethod=indent                        " 基于缩进或语法进行代码折叠
set foldmethod=syntax
set nofoldenable                              " 启动 vim 时关闭折叠代码

noremap oo o<esc>                             " 加入空行, 不进insert模式
noremap OO O<esc>
nmap <Leader>j :tnext<CR>
nmap <Leader>k :tprevious<CR>
nmap <Leader>q :q<CR>
nmap <Leader>w :w<CR>
" nnoremap ww <C-W><C-W>                      " 依次遍历子窗口
" nnoremap wl <C-W>l                          " 跳转至右方的窗口
" nnoremap wh <C-W>h                          " 跳转至左方的窗口
" nnoremap wk <C-W>k                          " 跳转至上方的子窗口
" nnoremap wj <C-W>j                          " 跳转至下方的子窗口
" nmap <Leader>M %                            " 定义快捷键在结对符之间跳转

                                              " 上次关闭的位置
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

if system.isOSX
  let g:clang_use_library=1
  let g:clang_library_path='$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clang/lib/'
elseif system.isLinux
  let g:clang_use_library=1
  let g:clang_library_path='$HOME/.vim/bundle/YouCompleteMe/third_party/ycmd/third_party/clang/lib/'
endif

" PlugSetting - indexer --------------------------------------------------------
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q --language-force=c++ --exclude=*.so --exclude=*.o --exclude=*.builtin --exclude=*.order --exclude=*.patch"
let g:indexer_dontUpdateTagsIfFileExists = 1

" PlugSetting - tagbar ---------------------------------------------------------
let tagbar_left=1                            " 设置 tagbar出现在主编辑区的左边
"                                              列表子窗口的快捷键
nnoremap <Leader>t :TagbarToggle<CR>
let tagbar_width=30                          " 设置标签子窗口的宽度
let g:tagbar_compact=1                       " tagbar子窗口中不显示冗余帮助信息
let g:tagbar_iconchars = ['▸', '▾']
" let g:tagbar_autopreview = 1
let g:tagbar_sort = 0
"let g:tagbar_status_func = 'TagbarStatusFunc'
"function! TagbarStatusFunc(current, sort, fname, ...) abort
"  return '%#LightlineLeft_active_0#%( tagbar %)%#LightlineLeft_active_0_1#'
"endfunction

                                             " 设置ctags对哪些代码标识符生成标签
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

" PlugSetting - ctrlsf ---------------------------------------------------------
nnoremap <Leader>s :CtrlSF<CR>
let g:ctrlsf_ackprg = 'ag'                           " 指定搜索工具
let g:ctrlsf_auto_focus = {
    \ "at": "start"
    \ }

" PlugSetting - nerdtree -------------------------------------------------------
nmap <Leader>n :NERDTreeToggle<CR>
let NERDTreeWinSize=25                               " 设置NERDTree子窗口宽度
let NERDTreeWinPos="right"                           " 设置NERDTree子窗口位置
let NERDTreeShowHidden=1                             " 显示隐藏文件
let NERDTreeMinimalUI=1                              " NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeAutoDeleteBuffer=1                       " 删除文件时自动删除文件对应 buffer
let g:NERDTreeStatusline=' '

" PlugSetting - gitgutter ------------------------------------------------------
let g:gitgutter_max_signs=1500
" PlugSetting - airline --------------------------------------------------------
" nmap <tab> :bn<cr>                                   " 设置tab键映射
" let g:airline_theme='base16'                         " 'base16_google' 'tomorrow' 'base16_spacemacs' 'base16_monokai' 'papercolor' 'base16'
" let g:airline_powerline_fonts = 1                    " 使用powerline字体
" let g:airline#extensions#tabline#enabled = 1
" "let g:airline#extensions#whitespace#enabled=0        " 关闭状态栏whitespace提示
" " let g:airline#extensions#tabline#show_tab_type = 1 " 打开下面这个选项会显示标签类型-->去掉右上角[buffers]
"
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline#extensions#tabline#buffer_idx_format = {
"         \  '1': '❶ ',
"         \  '2': '❷ ',
"         \  '3': '❸ ',
"         \  '4': '❹ ',
"         \  '5': '❺ ',
"         \  '6': '❻ ',
"         \  '7': '❼ ',
"         \  '8': '❽ ',
"         \  '9': '❾ ',
"         \ '10': '➓ '
"         \}
"
" nmap <leader>1 <Plug>AirlineSelectTab1
" nmap <leader>2 <Plug>AirlineSelectTab2
" nmap <leader>3 <Plug>AirlineSelectTab3
" nmap <leader>4 <Plug>AirlineSelectTab4
" nmap <leader>5 <Plug>AirlineSelectTab5
" nmap <leader>6 <Plug>AirlineSelectTab6
" nmap <leader>7 <Plug>AirlineSelectTab7
" nmap <leader>8 <Plug>AirlineSelectTab8
" nmap <leader>9 <Plug>AirlineSelectTab9

" PlugSetting - LeaderfFile ----------------------------------------------------
nmap <Leader>lf :LeaderfFile<CR>
let g:Lf_StlSeparator = { 'left': '⮀', 'right': '⮂' }

" PlugSetting - youcompleteme  -------------------------------------------------
                                                             " 只能是 #include 或已打开的文件
nnoremap <leader>jc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>

let g:ycm_complete_in_comments=1                             " 补全功能在注释中同样有效
let g:ycm_confirm_extra_conf=0                               " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_collect_identifiers_from_tags_files=1              " 开启 YCM 标签补全引擎
" set tags+=/data/misc/software/misc./vim/stdcpp.tags        " 引入 C++ 标准库tags
" inoremap <leader>; <C-x><C-o>                              " YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
set completeopt-=preview                                     " 补全内容不以分割子窗口形式出现，只显示补全列表
let g:ycm_min_num_of_chars_for_completion=1                  " 从第一个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0                                   " 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1                     " 语法关键字补全

if system.isLinux                                            " 指定python版本
  let g:ycm_server_python_interpreter='/usr/bin/python'
elseif system.isOSX
  let g:ycm_python_interpreter_path='/usr/bin/python'
endif

let g:ycm_complete_in_strings = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'nerdtree' : 1,
      \}
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0

let g:ycm_global_ycm_extra_conf = '$HOME/.ycm_extra_conf.py' " 指定.ycm_extra_conf.py
" let g:ycm_use_clangd = 0"
" let g:ycm_server_keep_logfiles = 1                         " debug for YCM
" let g:ycm_server_log_level = 'debug'

" PlugSetting - flygrep --------------------------------------------------------
nnoremap <Leader>f :FlyGrep<CR>
let g:spacevim_debug_level = 3
"let g:FlyGrep_input_delay = 50
"let g:FlyGrep_enable_statusline = 0
"let g:spacevim_commandline_prompt = '#'

" PlugSetting - lightline ------------------------------------------------------
execute 'source' '~/.vim/lightline.vim'

" PlugSetting - color_coded ----------------------------------------------------
" 安装方法
" cd ~/.vim/bundle/color_coded
" rm -f CMakeCache.txt
" mkdir build && cd build
" cmake -DCUSTOM_CLANG=1 -DLLVM_ROOT_DIR=/usr/local/Cellar/llvm ..
" make && make install

" PlugSetting - mark ---------------------------------------------------------
nmap <silent> <localleader>m <Plug>MarkSet
vmap <silent> <localleader>m <Plug>MarkSet
nmap <silent> <localleader>r <Plug>MarkRegex
vmap <silent> <localleader>r <Plug>MarkRegex
nmap <silent> <localleader>n <Plug>MarkClear
" nmap <silent> <localleader>* <Plug>MarkSearchCurrentNext
" nmap <silent> <localleader># <Plug>MarkSearchCurrentPrev
nmap <silent> <localleader>8 <Plug>MarkSearchCurrentNext
nmap <silent> <localleader>3 <Plug>MarkSearchCurrentPrev
nmap <silent> <localleader>/ <Plug>MarkSearchAnyNext
nmap <silent> <localleader>? <Plug>MarkSearchAnyPrev
nmap <silent> * <Plug>MarkSearchNext
nmap <silent> # <Plug>MarkSearchPrev
nmap <silent> <localleader>c <Plug>MarkAllClear
" No default mapping for <Plug>MarkAllClear.
" No default mapping for <Plug>MarkToggle.
highlight def MarkWord1  ctermbg=Red      ctermfg=Black  guibg=#FF7272    guifg=Black
highlight def MarkWord2  ctermbg=Magenta  ctermfg=Black  guibg=#FFB3FF    guifg=Black
highlight def MarkWord3  ctermbg=Cyan     ctermfg=Black  guibg=#8CCBEA    guifg=Black
highlight def MarkWord4  ctermbg=Green    ctermfg=Black  guibg=#A4E57E    guifg=Black
highlight def MarkWord5  ctermbg=Blue     ctermfg=Black  guibg=#9999FF    guifg=Black
highlight def MarkWord6  ctermbg=Yellow   ctermfg=Black  guibg=#FFDB72    guifg=Black

" PlugSetting - mundo  ---------------------------------------------------------
nnoremap <Leader>u :MundoToggle<CR>
let g:mundo_width = 20
let g:mundo_preview_height = 20
" let g:mundo_right = 1
let g:mundo_preview_bottom = 1
let g:mundo_close_on_revert = 1
set undofile
set undodir=~/.vim/undo

" PlugSetting - mundo  ---------------------------------------------------------
let g:LargeFile = 2

" PlugSetting - tmuxline  ------------------------------------------------------
" Tmuxline lightline
let g:tmuxline_preset = 'nightly_fox'
let g:tmuxline_preset = {
      \'b'    : 'Session|#S',
      \'win'  : '#I',
      \'cwin' : '#I',
      \'y'    : '%a|%m-%d|%H:%M'}


" PlugSetting - EasyComplete ---------------------------------------------------
imap <Tab>   <Plug>EasyCompTabTrigger
let g:pmenu_scheme = 'dark'

" PlugSetting - startify -------------------------------------------------------
let g:startify_padding_left = 20
let g:startify_change_to_dir =0
let g:startify_custom_header = [
                \ '                     __    __    _____     __    __      _____   ______   ',
                \ '                     ) )  ( (   (_   _)    \ \  / /     / ___/  (   __ \  ',
                \ '                    ( (    ) )    | |       ) \/ (     ( (__     ) (__) ) ',
                \ '                     \ \  / /     | |      / _  _ \     ) __)   (    __/  ',
                \ '                      \ \/ /      | |     / / \/ \ \   ( (       ) \ \  _ ',
                \ '                       \  /      _| |__  /_/      \_\   \ \___  ( ( \ \_))',
                \ '                        \/      /_____( (/          \)   \____\  )_) \__/ ',
                \]

let g:startify_custom_footer = [
                \ '                                +-----------------------------+',
                \ '                                |  Be a voice, not an echo !  |',
                \ '                                +-----------------------------+',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \ '                                                               ',
                \]

" PlugSetting - fzf ------------------------------------------------------------


" execute 'source' '~/.vim/fzf.vim'

"                +-------------------------+
"                |        C风格注释        |
"                |        <Leader>cs       |
"                |        取消注释         |
"                |        <Leader>cu       |
"                +-------------------------+
"                |        画图注释         |
"                |        :Distart         |
"                |        :Disop           |
"                +-------------------------+
