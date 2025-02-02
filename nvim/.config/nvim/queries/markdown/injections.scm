; extends

((paragraph)
  @injection.content
  (#match? @injection.content "^\\{\\% pgf [A-Z0-9a-z ]+\\%\\}.*$")
  (#set! injection.language "latex")
  (#set! injection.combined)
  (#set! injection.include-children)
)
