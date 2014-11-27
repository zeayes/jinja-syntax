" Vim syntax file
" Language:     jinja
" Maintainer:   Tim Pope <vimNOSPAM@tpope.org>
" Filenames:    *.jinja
" Last Change:	2013 May 30

syn case match

syn region  jinjaStatement  matchgroup=jinjaDelimiter start="{%-\?" end="-\?%}" contains=@jinjaStatement containedin=ALLBUT,@jinjaExempt keepend
syn region  jinjaExpression matchgroup=jinjaDelimiter start="{{-\?" end="-\?}}" contains=@jinjaExpression  containedin=ALLBUT,@jinjaExempt keepend
syn region  jinjaComment    matchgroup=jinjaDelimiter start="{#" end="#}" contains=jinjaTodo,@Spell containedin=ALLBUT,@jinjaExempt keepend
syn region  jinjaRaw        matchgroup=jinjaDelimiter start="{%\s*raw\s*%}" end="{%\s*endraw\s*%}" contains=TOP,@jinjaExempt containedin=ALLBUT,@jinjaExempt keepend

syn cluster jinjaExempt contains=jinjaStatement,jinjaExpression,jinjaComment,jinjaRaw,@jinjaStatement
syn cluster jinjaStatement contains=jinjaImport,jinjaWith,jinjaConditional,jinjaRepeat,jinjaKeyword,jinjaFilter,jinjaBlock,@jinjaExpression
syn cluster jinjaExpression contains=jinjaOperator,jinjaNumber,jinjaFloat,jinjaBoolean,jinjaString,jinjaPipe,jinjaLoop


" let b:blocks = exists('g:jinja_highlight_blocks')? g:jinja_highlight_blocks : ['block', 'macro', 'autoescape', 'set', 'call', 'filter', 'trans', 'with', 'contained']
" for block in b:blocks
    " exe 'syn region jinjaBlock start="{%-\?\s*'.matchstr(block, '[^=]*').'\s\+[a-zA-Z_][a-zA-Z0-9_]*\s\+-\?%}" end="{%-\?\s*end'.matchstr(block, '[^=]*').'\s*-\?%}" keepend'
" endfor

" Jinja builtin filters
syn keyword jinjaBuiltinFilter abs attr batch capitalize center default d dictsort escape
syn keyword jinjaBuiltinFilter filesizeformat first float forceescape format groupby indent
syn keyword jinjaBuiltinFilter int join last length list lower map ppirnt random reject
syn keyword jinjaBuiltinFilter rejectattr replace reverse round safe select selectattr slice
syn keyword jinjaBuiltinFilter sort string striptags sum title trim truncate upper urlencode
syn keyword jinjaBuiltinFilter urlize wordcount wordwrap xmlattr callable defined divisibleby
syn keyword jinjaBuiltinFilter equalto escaped even iterable lower mapping none number odd
syn keyword jinjaBuiltinFilter sameas sequence string undefined upper range lipsum dict

syn region jinjaString matchgroup=jinjaQuote start=+"+ skip=+\\"+ end=+"+ contained
syn region jinjaString matchgroup=jinjaQuote start=+'+ skip=+\\'+ end=+'+ contained
syn match jinjaNumber "-\=\<\d\+\>" contained
syn match jinjaWith "\<with\(out\)\?\s\+context\>" contained
syn match jinjaFloat "-\=\<\d\+\>\.\.\@!\%(\d\+\>\)\=" contained
syn keyword jinjaBoolean true false contained

syn keyword jinjaImport from import include as contained
syn keyword jinjaOperator and or not is in recursive contained
syn match jinjaPipe '|' contained skipwhite nextgroup=jinjaFilter

syn keyword jinjaRepeat for else endfor contained
syn keyword jinjaConditional if elif else continue break endif contained
syn keyword jinjaKeyword none False True None super caller varargs kwargs extends contained
syn keyword jinjaKeyword block autoescape macro set call filter trans endwith contained
syn keyword jinjaKeyword endblock endautoescape endmacro endset endcall endfilter endtrans contained



syn keyword jinjaLoop loop nextgroup=jinjaloopDot contained
syn match jinjaLoopDot "\." nextgroup=jinjaloopAttribute contained
syn keyword jinjaLoopAttribute index index0 revindex revindex0 first last length cycle depth depth0 contained


hi def link jinjaBuiltinFilter         jinjaFilter

hi def link jinjaImport                Include
hi def link jinjaDelimiter             PreProc
hi def link jinjaComment               Comment
hi def link jinjaConditional           Conditional
hi def link jinjaRepeat                Repeat
hi def link jinjaKeyword               Keyword
hi def link jinjaOperator              Operator
hi def link jinjaString                String
hi def link jinjaQuote                 Delimiter
hi def link jinjaNumber                Number
hi def link jinjaFloat                 Float
hi def link jinjaBoolean               Boolean
hi def link jinjaBlock  Function
hi def link jinjaFilter                Function
hi def link jinjaLoop                  Statement
hi def link jinjaWith                  Statement
hi def link jinjaLoopAttribute         Statement
