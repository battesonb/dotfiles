" Vim syntax file
" Language: WebGPU Shader Language

if exists("b:current_syntax")
    finish
endif

let b:current_syntax = "wgsl"

" Basics
syn keyword conditional if else elseif switch case
syn keyword repeat for
syn keyword basicKeyword struct var fn let return continue continuing discard
syn keyword operator * + - /
syn match float '\d*\.\d\+'
syn match comment '//.*'
syn keyword builtinFunctions
  \ abs
  \ acos
  \ asin
  \ atan
  \ atan2
  \ ceil
  \ clamp
  \ cos
  \ cosh
  \ cross
  \ distance
  \ exp
  \ exp2
  \ faceForward
  \ floor
  \ fma
  \ fract
  \ frexp
  \ inverseSqrt
  \ ldexp
  \ length
  \ log
  \ log2
  \ max
  \ min
  \ mix
  \ modf
  \ normalize
  \ pow
  \ reflect
  \ round
  \ sign
  \ sin
  \ sinh
  \ smoothStep
  \ sqrt
  \ step
  \ tan
  \ tanh
  \ trunc

hi def link conditional      Conditional
hi def link repeat           Repeat
hi def link basicKeyword     Keyword
hi def link operator         Operator
hi def link float            Number
hi def link comment          Comment
hi def link builtinFunctions Special

" Pre-processors
syn match preProcStart '\[\[' nextgroup=preProcKeyword,preProcFunction,preProcEnd
syn keyword preProcKeyword nextgroup=preProcEnd contained
  \ block
syn match preProcEnd '\]\]' contained

syn keyword preProcFunction nextgroup=preProcFunctionStart contained
  \ binding
  \ builtin
  \ group
  \ location
  \ stage

syn match preProcFunctionSeparator ', *' nextgroup=preProcFunction contained

syn match preProcFunctionStart '(' nextgroup=preProcFunctionArgument,preProcFunctionNumericArgument contained
syn match preProcFunctionEnd ')' nextgroup=preProcFunctionSeparator,preProcEnd contained

syn match preProcFunctionNumericArgument '\d*' nextgroup=preProcFunctionEnd contained
syn keyword preProcFunctionArgument nextgroup=preProcFunctionEnd contained
  \ fragment
  \ position
  \ vertex

hi def link preProcStart             PreProc
hi def link preProcEnd               PreProc
hi def link preProcKeyword           PreProc
hi def link preProcFunction          PreProc
hi def link preProcFunctionArgument  PreProc
hi def link preProcFunctionNumericArgument Number
hi def link preProcFunctionStart     PreProc
hi def link preProcFunctionEnd       PreProc

" Types
syn keyword typeTemplateKey
  \ array
  \ vec2
  \ vec3
  \ vec4
  \ texture_2d
  \ mat2x2
  \ mat2x3
  \ mat2x4
  \ mat3x2
  \ mat3x3
  \ mat3x4
  \ mat4x2
  \ mat4x3
  \ mat4x4
  \ nextgroup=typeTemplate
syn region typeTemplate matchgroup=typeTemplateKey start='<' end='>' contains=basicType contained
syn keyword basicType f32 i32 u32 sampler bool 

syn match customType 'struct \w+'hs=s+7

hi def link typeTemplateKey Type
hi def link basicType       Type
hi def link customType      Type

