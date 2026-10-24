; HTML no tiene corchetes propios: esta query no coincide con nada, pero hace
; que rainbow-delimiters siga procesando el JS/CSS de <script>/<style>.
((element) @container
  (#eq? @container "__rainbow-brackets-none__"))
