set indentexpr=

if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:jinja_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1

setlocal indentexpr=GetJinjaIndent()
setlocal indentkeys+==end,=endif,=endfor,=else,=elif

if exists('*GetJinjaIndent')
  finish
endif

function! s:count(string,pattern)
  let string = substitute(a:string,'\C'.a:pattern,"\n",'g')
  return strlen(substitute(string,"[^\n]",'','g'))
endfunction

function! GetJinjaIndent(...)
  if a:0 && a:1 == '.'
    let v:lnum = line('.')
  elseif a:0 && a:1 =~ '^\d'
    let v:lnum = a:1
  endif
  let vcol = col('.')
  call cursor(v:lnum,1)
  exe "let ind = ".b:jinja_subtype_indentexpr
  let lnum = prevnonblank(v:lnum-1)
  let line = getline(lnum)
  let cline = getline(v:lnum)
  let line  = substitute(line,'\C^\%(\s*{%\s*end\w*\s*%}\)\+','','')
  let line .= matchstr(cline,'\C^\%(\s*{%\s*end\w*\s*%}\)\+')
  let cline = substitute(cline,'\C^\%(\s*{%\s*end\w*\s*%}\)\+','','')
  let ind += &sw * s:count(line,'{%\s*\%(if\|elif\|else\|for\|block\|autoescape\|macro\)\>')
  let ind -= &sw * s:count(line,'{%\s*end\%(if\|for\|block\|autoescape\|macro\)\>')
  let ind -= &sw * s:count(cline,'{%\s*\%(elif\|else\)\>')
  let ind -= &sw * s:count(cline,'{%\s*end\w*$')
  return ind
endfunction
