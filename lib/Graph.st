"design note: this is a MODEL class that should not be polluted with
 DATA concepts (e.g. reading graph spec)
"
! Graph class methods !
new
	^super new init
!!
! Graph methods !
draw	
	|buffer|
	(height - 1) to: ox by: -1 do: [:i| oy to: (width - 1) do: [:j|
			"i o. ' ' o. j o. ' ' o."
			buffer := (self getColumn: j row: i).
			(buffer isNil)
				ifTrue: [buffer := ' '.]
				ifFalse: [].
			buffer o].
		'' oo]
!
frame
	"ox o. oy o."
	ox to: (width - 1) do: [:i| self plot: i  @ oy	with: $- ].
	ox to: (width - 1) do: [:i| self plot: i  @ (height - 1)	with: $- ].
	oy to: (height - 1) do: [:i| self plot: ox @ i	with: $| ].
	oy to: (height - 1) do: [:i| self plot: (width - 1) @ i	with: $| ].
!
matrix
	^matrix
!
matrix: x
	^(matrix at: x)
!
getColumn: x row: y
	^((self matrix: y) at: x)
!
height
	^height
!
height: h 
	self height: h width: width 
!
height: h width: w
	height := h.
	width  := w.
	self resize 
!
init
	label  := ''. 
	xrange := Range new.
	yrange := Range new.
	matrix := OrderedCollection new.
	ox := 6.
	oy := 2.
	self height: 24  width: 80	
!
resize 
	"'tt' o."
	matrix := Array new: height.
	1 to: height do: [:i|
           matrix at: i put: (Array new: width) ].
	self frame
!
plot: aPoint with: aSymbol	
      (matrix at: aPoint y) at: aPoint x put: aSymbol. 
	"((matrix at: aPoint y) at: aPoint x) o."
!
splot: aPoint with: aString
       |i|
       i := 0.
       aString do: [:elm |
       	    self plot: (aPoint x + i) @ aPoint y with: elm.
            i := i + 1 ]
!
width
	^width
!
width: aNumber
	^width := aNumber
!
width: w 
       self height: height width: w
!
xscale: aNumber
	^((xrange scale: aNumber) * ((width - 1) - ox) + ox) round 
!
yscale: aNumber
	^((yrange scale: aNumber) * ((height - 1) - oy) + oy) round 
!!
