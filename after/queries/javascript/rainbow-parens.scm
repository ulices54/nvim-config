; extends

; rainbow-parens quita las etiquetas JSX pero también las llaves de las
; expresiones {valor}; VS Code sí las colorea, así que se agregan aquí.
; tsx hereda esta query (tsx -> typescript -> javascript).
(jsx_expression
  "{" @delimiter
  "}" @delimiter) @container
