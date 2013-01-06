if exists('g:loaded_ctrlp_sudden_death') && g:loaded_ctrlp_sudden_death
  finish
endif
let g:loaded_ctrlp_sudden_death = 1

let s:sudden_death_var = {
  \ 'init':   'ctrlp#sudden_death#init()',
  \ 'accept': 'ctrlp#sudden_death#accept',
  \ 'lname':  'sudden-death',
  \ 'sname':  's-death',
  \ 'type':   'line',
  \ 'enter':  'ctrlp#sudden_death#enter()',
  \ 'sort':   0,
  \ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:sudden_death_var)
else
  let g:ctrlp_ext_vars = [s:sudden_death_var]
endif

function! ctrlp#sudden_death#init()
  return reverse(copy(s:list))
endfunc

function! ctrlp#sudden_death#accept(mode, str)
  call ctrlp#exit()
  if a:mode == 'e'
    exe "normal! ddk"
  elseif a:mode == 'h'
    exe "new"
  elseif a:mode == 'v'
    exe "vnew"
  elseif a:mode == 't'
    exe "tabe"
  endif
  silent! put = s:data
endfunction

function! ctrlp#sudden_death#enter()
  let s:string = getline('.')
  if !strlen(s:string)
    let s:string = '突然の死'
  endif
  let s:indicator =
        \ substitute(substitute(s:string, '[ -~]', '_', 'g'), '[^ -~]', '__', 'g')
  if strlen(s:indicator) % 2
    let s:string .= ' '
    let s:indicator .= '_'
  endif
  let s:list = [
      \ '＿人'.substitute(s:indicator, '__', '人', 'g').'人＿',
      \ '＞  '.s:string.'  ＜',
      \ '￣Ｙ'.substitute(s:indicator, '__', 'Ｙ', 'g').'Ｙ￣',
      \ ]
  let s:data = join(s:list, "\n")
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#sudden_death#id()
  return s:id
endfunction

" vim:fen:fdl=0:ts=2:sw=2:sts=2
