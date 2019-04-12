" 引入tags
set tags+=/Users/jian.cao/.indexer_fles_tags/linux 
set tags+=/home/jian.cao/workspace/kernel/common/tags
set tags+=/home/jian.cao/workspace/my_build/arm_isp/gdc_test/gdc_to_ge2d_test_for_gdc_fw/tags
set tags+=/home/jian.cao/workspace/eureka/chrome/vendor/amlogic/common/libge2d/tags
" 定义快捷键的前缀，即<Leader>
let mapleader=";"
" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
" vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
call vundle#begin()
" #########################################
Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tomasr/molokai'
Plugin 'vim-scripts/phd'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'majutsushi/tagbar'
Plugin 'vim-scripts/indexer.tar.gz'
Plugin 'vim-scripts/DfrankUtil'
Plugin 'vim-scripts/vimprj'
Plugin 'Valloric/YouCompleteMe'
Plugin 'dyng/ctrlsf.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/DrawIt'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" #########################################
" 插件列表结束
call vundle#end()
filetype plugin indent on

" 配色方案
set background=dark
" colorscheme solarized
colorscheme molokai
" colorscheme phd
" 设置状态栏主题风格
" let g:Powerline_colorscheme='solarized256'
set t_Co=256
" let g:solarized_termcolors=256
let g:molokai_original = 1
let g:rehash256 = 1

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
set cursorline
set cursorcolumn
" highlight CursorLine   cterm=NONE ctermbg=black ctermfg=red guibg=black guifg=red
" highlight CursorColumn cterm=NONE ctermbg=black ctermfg=red guibg=black guifg=red

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

" 使用 ctrlsf.vim 插件在工程内全局查找光标所在关键字，设置快捷键。快捷键速记法：search in project
nnoremap <Leader>s :CtrlSF<CR>
" 指定搜索工具
let g:ctrlsf_ackprg = 'ag'


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
" let g:ycm_use_clangd = 0
" 指定python版本
let g:ycm_server_python_interpreter='/usr/bin/python'
" 指定.ycm_extra_conf.py
" let g:ycm_global_ycm_extra_conf='~/.ycm_extra_conf.py'


" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
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
" set ambiwidth=double "防止特殊符号无法正常显示
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts=1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled=1 " 显示窗口tab和buffer
" 设置tab键映射
nmap <tab> :bn<cr>
" 'papercolor'  " air line theme
let g:airline_theme='papercolor' " 'base16'
" 关闭状态栏whitespace提示
let g:airline#extensions#whitespace#enabled=0

" set listchars=tab:»\ ,space:·,trail:•,extends:»,precedes:« " Unprintable chars mapping
set listchars=tab:»\ ,trail:█,extends:»,precedes:« " Unprintable chars mapping
set list          " Display unprintable characters

" +-----------------------------------+
" C风格注释
" <leader>cs
" 取消注释
" <leader>cu
"
" 画图注释
" :Distart
" +-----------------------------------+

