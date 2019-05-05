let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ ['homemode', 'paste'],
      \             ['fugitive', 'gitgutter'], ['filename']],
      \   'right':[ ['lineinfo'],
      \             ['percent'], ['fileencoding'], ['tagbar'] ],
      \ },
      \ 'inactive': {
      \   'left': [['homemode'], ['filename']],
      \   'right':[['lineinfo'], ['percent']],
      \ },
      \ 'tabline': {
      \   'left': [['buffers']],
      \   'right': [['close']],
      \ },
      \ 'component': {
      \   'lineinfo': ' %3l:%-2v',
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_function': {
      \   'homemode': 'LightlineMode',
      \   'paste': 'PasteMode',
      \   'fugitive': 'LightLineFugitive',
      \   'gitgutter': 'LightLineGitGutter',
      \   'readonly': 'LightLineReadonly',
      \   'filetype': 'LightLineFiletype',
      \   'tagbar': 'Currenttag',
      \ },
      \ 'component_type': {'buffers': 'tabsel'},
      \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2"},
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3"}
      \ }

function! LightlineMode()
  let nr = s:get_buffer_number()
  let nmap_num = [ '⓪ ', '① ', '② ', '③ ', '④ ', '⑤ ', '⑥ ', '⑦ ', '⑧ ', '⑨]' ]
  if nr == 0
    return ''
  endif
  let l:number = nr
  let l:result = ''
  for i in range(1, strlen(l:number))
    let l:result = get(nmap_num, l:number % 10, l:number % 10) . l:result
    let l:number = l:number / 10
  endfor
  return join([lightline#mode()[0],l:result])
endfunction

function! PasteMode()
  if &paste == 1
    return 'P'
  else
    return ''
  endif
endfunction

function! Currenttag()
  return  winwidth(0) > 70 ? tagbar#currenttag("%s", "") : ''
endfunction

function! s:get_buffer_number()
  let i = 0
  for nr in filter(range(1, bufnr('$')), 'bufexists(v:val) && buflisted(v:val)')
    let i += 1
    if nr == bufnr('')
      return i
    endif
  endfor
  return ''
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if winwidth(0) > 70
    if exists("*fugitive#head")
      let _ = fugitive#head()
      return strlen(_) ? ''._ : ''
    endif
  else
   return ''
  endif
  return ''
endfunction

function! LightLineGitGutter()
  if ! exists('*GitGutterGetHunkSummary')
        \ || ! get(g:, 'gitgutter_enabled', 0)
        \ || winwidth('.') <= 90
    return ''
  endif
  let symbols = ['+','~','-']
  let hunks = GitGutterGetHunkSummary()
  let ret = []
  for i in [0, 1, 2]
    if hunks[i] > 0
      call add(ret, symbols[i] . hunks[i])
    endif
  endfor
  return join(ret, ' ')
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . '') : ''
endfunction

let g:lightline#bufferline#unicode_symbols = 1         " unicode
let g:lightline#bufferline#show_number  = 2
let g:lightline#bufferline#shorten_path = 1
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#filename_modifier = ':t'  " tabline只显示文件名  :help filename-modifiers
let g:lightline#bufferline#unnamed      = '[No Name]'
let g:plug_skip=['nerdtree', 'tagbar', 'startify', 'Mundo', 'MundoDiff']
let g:lightline#bufferline#number_map = {
       \ 0: '₀', 1: '₁', 2: '₂', 3: '₃', 4: '₄',
       \ 5: '₅', 6: '₆', 7: '₇', 8: '₈', 9: '₉'}
"let g:lightline#bufferline#number_map = {
"      \ 0: '⓿ ', 1: '❶ ', 2: '❷ ', 3: '❸ ', 4: '❹ ',
"      \ 5: '❺ ', 6: '❻ ', 7: '❼ ', 8: '❽ ', 9: '❾ '}

nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
