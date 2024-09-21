" TLA+ syntax file
" Language: TLA+ and PlusCal

if exists("b:current_syntax")
    finish
endif

" TLA+ syntax {{{
syn keyword tlaInclude
    \ EXTENDS
    \ INSTANCE
    \ LOCAL
syn keyword tlaStructure
    \ MODULE
syn keyword tlaKeyword
    \ ASSUME
    \ CHOOSE
    \ CONSTANT[S]
    \ DOMAIN
    \ ELSE
    \ ENABLED
    \ EXCEPT
    \ IF
    \ IN
    \ LET
    \ RECURSIVE
    \ SUBSET
    \ THEN
    \ THEOREM
    \ UNCHANGED
    \ VARIABLE[S]
syn region tlaComment start="(\*\( --algorithm\)\@!" end="\*)" contains=tlaComment
syn match tlaLineComment /\\\*.*/
syn match tlaEnd /=\{4,\}/
syn match tlaRule /-\{4,\}/
syn keyword tlaBoolean TRUE FALSE BOOLEAN
syn region tlaString  start=/"/ skip=/\\"/ end=/"/
syn match tlaNumber /-\?\d\+\.\d\+/
syn keyword tlaNumber Int
syn match tlaFunc /\\\(\*\)\@!/ nextgroup=tlaFuncName
syn keyword tlaFuncName contained
    \ in
    \ notin
    \ subseteq
    \ union
    \ intersect
    \ E " existential qualifier
    \ A " universal qualifier
    \ X " cartesian product
    \ o " combine two sequences
    \ prec

syn region tlaType start="<<" end=">>" contains=tlaType oneline
syn region tlaType start="{" end="}" contains=tlaType oneline

syn match tlaOperator /\/\\/
syn match tlaOperator /\\\//
syn match tlaOperator /\~>/
syn match tlaOperator /\[\]/
syn match tlaOperator /<>/
syn match tlaOperator /=>/
syn match tlaOperator /<=>/
syn match tlaOperator /->/
syn match tlaOperator /|->/
syn match tlaOperator /#/
syn match tlaOperator /+/
syn match tlaOperator /:/
syn match tlaOperator /\.\./
syn match tlaOperator /-\(-\)\@!/
syn match tlaOperator /==\(=\)\@!/
syn match tlaOperator /=\([=>]\)\@!/
syn match tlaFairnessOperator /[SW]F_\(<\)\{0,2\}\w\+\(>\)\{0,2\}/
" }}}

" PlusCal syntax {{{
syn keyword pluscalKeyword
    \ algorithm
    \ assert
    \ await
    \ begin
    \ define
    \ either
    \ else
    \ elsif
    \ end
    \ if
    \ macro
    \ or
    \ print
    \ process
    \ skip
    \ variables
    \ wait
    \ while
    \ with
" }}}

" Highlight {{{
hi def link tlaStructure    Structure
hi def link tlaType         Type
hi def link tlaOperator     Special
hi def link tlaBoolean      Boolean
hi def link tlaComment      Comment
hi def link tlaLineComment  Comment
hi def link tlaEnd          Comment
hi def link tlaRule         Comment
hi def link tlaFunc         Function
hi def link tlaFuncName     Function
hi def link tlaKeyword      Keyword
hi def link tlaInclude      Include
hi def link tlaNumber       Number
hi def link tlaString       String

hi def link pluscalKeyword  Keyword
" }}}
