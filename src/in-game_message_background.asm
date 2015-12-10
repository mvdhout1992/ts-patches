%include "macros/patch.inc"
%include "macros/datatypes.inc"

; Set the background color of in-game messages to solid black.
; Default 0 = transparent. C = black, D = grey, E = light grey, F = white
 
@SET 0x0064D15D, push 0Ch
 
; Boldness can also be set, but I don't see any demand for it.
; 1 = Default, 2 = bold. 3 is huge
; @SET 0x0064D15A, push 2