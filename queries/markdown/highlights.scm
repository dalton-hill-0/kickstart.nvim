;; extends
;; Conceal fenced code block delimiters (``` or ~~~)
((fenced_code_block_delimiter) @conceal (#set! conceal ""))

;; Conceal ATX heading markers and following whitespace
;; By matching both the marker and space in sequence, we can conceal them together
; ((atx_h1_marker) @conceal (#trim! @conceal 1 1 1 1) (#set! conceal ""))
((atx_h1_marker) @conceal (#set! conceal ""))
((atx_h2_marker) @conceal (#set! conceal ""))
((atx_h3_marker) @conceal (#set! conceal ""))
((atx_h4_marker) @conceal (#set! conceal ""))
((atx_h5_marker) @conceal (#set! conceal ""))
((atx_h6_marker) @conceal (#set! conceal ""))
