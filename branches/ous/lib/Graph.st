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
	self rangecheck.
	self frame.
	self ticks.
	self data.
	self botlab.
	height to: 1 by: -1 do: [:i| 1 to: width do: [:j|
			"i o. ' ' o. j o. ' ' o."
			buffer := (self getColumn: j row: i).
			(buffer isNil)
				ifTrue: [' ' o.]
				ifFalse: [buffer o].
			].
		'' oo]
!
rangecheck
	((xrange min) > (xrange max))
		ifTrue: [1 to: graphpoints size do: [:i| xrange add: (graphpoints at: i) x.]].
	((yrange min) > (yrange max))
		ifTrue: [1 to: graphpoints size do: [:i| yrange add: (graphpoints at: i) y.]].	
!
frame
	ox to: width do: [:i| self plot: i  @ oy	with: $- ].
	ox to: width do: [:i| self plot: i  @ height	with: $- ].
	oy to: height do: [:i| self plot: ox @ i	with: $| ].
	oy to: height do: [:i| self plot: width @ i	with: $| ].
!
ticks
	1 to: bottomT size do: [:i|
		self plot: ((self xscale:(bottomT at: i) asInteger) @ oy) with: '|'.
		self splot: ((self xscale:((bottomT at: i) asInteger )- (0.5)) @ 2) with: (bottomT at: i)].
	
	1 to: leftT size do: [:i|
		self plot: (ox @ (self yscale:(leftT at: i) asInteger)) with: '-'.
		self splot: (1 @ (self yscale:((leftT at: i) asInteger ))) with: (leftT at: i)]. 
!
botlab
	self splot: (((width + ox - label size)/2) asInteger) @ 1 with: label
!
data	
	1 to: graphpoints size do: [:i|
		self plot: (self xyscale: (graphpoints at: i)) with: (graphsymbols at: i)]
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
	graphpoints := OrderedCollection new.
	graphsymbols := OrderedCollection new.
	xrange := Range new.
	yrange := Range new.
	matrix := OrderedCollection new.
	bottomT := OrderedCollection new.
	leftT := OrderedCollection new.	
	ox := 7.
	oy := 3.
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
	^((xrange scale: aNumber) * (width - ox) + ox) rounded
!
yscale: aNumber
	^((yrange scale: aNumber) * (height - oy) + oy) rounded
!
xyscale: aPoint
	|xs ys|
	xs := self xscale: (aPoint x).
	ys := self yscale: (aPoint y).
	^(xs @ ys)
!
label
	^label
!
label: l
	label := l
!
bottomT
	^bottomT
!
bottomT: list
	bottomT := list
!

leftT
	^leftT
!
leftT: list
	leftT := list
!
	
xrange
	^xrange
!
xrange: minx max: maxx
	xrange min: minx.
	xrange max: maxx
!

yrange
	^yrange
!
yrange: miny max: maxy
	yrange min: miny.
	yrange max: maxy
!

graphpoints
	^graphpoints
!
graphpoints: aPoint
	graphpoints addLast: aPoint
!

graphsymbols
	^graphsymbols
!
graphsymbols: symbol
	graphsymbols addLast: symbol
!!
