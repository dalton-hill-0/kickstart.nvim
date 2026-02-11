;; extends
;; Conceal fenced code block delimiters (``` or ~~~)
((fenced_code_block_delimiter) @conceal (#set! conceal ""))

;; Conceal ATX heading markers and following whitespace
;; Using offset! to extend the capture range to include the trailing space
; ((atx_h1_marker) @conceal (#offset! @conceal 0 0 0 1) (#set! conceal ""))
; ((atx_h2_marker) @conceal (#offset! @conceal 0 0 0 1) (#set! conceal ""))
; ((atx_h3_marker) @conceal (#offset! @conceal 0 0 0 1) (#set! conceal ""))
; ((atx_h4_marker) @conceal (#offset! @conceal 0 0 0 1) (#set! conceal ""))
; ((atx_h5_marker) @conceal (#offset! @conceal 0 0 0 1) (#set! conceal ""))
; ((atx_h6_marker) @conceal (#offset! @conceal 0 0 0 1) (#set! conceal ""))
