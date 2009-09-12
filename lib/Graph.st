"=============================================="
! Graph class methodsFor: 'creation' !
new
	^super new init
!!
"=============================================="
! Graph methodsFor: 'creation' !
init
	label  := ''. 
	xrange := Range new.
	yrange := Range new.
	matrix := OrderedCollection new.
	xTicks := OrderedCollection new.
	yTicks := OrderedCollection new.
	dataPoints := Dictionary new. "<- this idea borrowed from Luyi. Very good idea!"
	self height: 0  width: 0.
	ox:=6. 
	oy:=2.
!!
"=============================================="
! Graph methodsFor: 'doing' !
frame
       ox to: width do: [:i| self plot: i  @ oy           with: $- ].
       ox to: width do: [:i| self plot: i  @ (height-1) with: $- ].
       oy to: (height-1) do: [:i| self plot: ox @ i            with: $| ].
       oy to: (height-1) do: [:i| self plot: (width-1) @ i   with: $| ] 
!
height: h 
	self height: h width: width 
!
height: h width: w
	height := h.
	width  := w.
	self resize 
!
label: aString
	label := aString.
!
resize 
       matrix := Array new: height.
       1 to: height do: [:i|
           matrix at: i put: (Array new: width) ].
!
plot: aPoint with: aSymbol	
      (matrix at: aPoint y) at: aPoint x put: aSymbol. 
!
splot: aPoint with: aString
       |i|
       i := 0.
       aString do: [:elm |
       	    self plot: (aPoint x + i) @ aPoint y with: elm.
            i := i + 1 ]
!
width: aNumber
	^width := aNumber
!
wxidth: w 
       self height: height width: w
!
xscale: aNumber
	^((xrange scale: aNumber) * (width - 1 - ox) + ox) rounded 
!
yscale: aNumber
	^((yrange scale: aNumber) * (height - 1 - oy) + oy) rounded
!!
"================================================================"
!Graph methodsFor: 'printing'!
drawLabel
	self splot: (Point x:(((width+ox-(label size))/2) rounded) y:1) with: label.
!
drawTicks
	|xPoint yPoint|
	1 to: (xTicks size) do:[:where|
		xPoint:= xTicks at: where.
		self plot: (Point x:(self xscale: (xPoint x)) y:(xPoint y)) with: '|'.
		self plot: (Point x:((self xscale: (xPoint x))-1) y:(oy-1)) with: (xPoint x)].
	1 to: (yTicks size) do:[:where2|
		yPoint:= yTicks at: where2.
		self plot: (Point x:(yPoint x) y:(self yscale: (yPoint y))) with: '-'.
		self plot: (Point x:(ox-5) y:(self yscale: (yPoint y))) with: (yPoint y)].	
!
"Idea for how to handle this also borrowed from Luyi"
prepData
	|tempX tempY|
	dataPoints keysAndValuesDo: [:key :value|
		tempX := (self xscale: key x).
		tempY := (self yscale: key y).
		self plot: (Point x: (self xscale: key x) y: (self yscale: key y)) with: value ].
!
draw
	|currentSet currentItem|
	self frame.
	self drawTicks.	
	"self drawLabel."
	self prepData.
	(matrix size) to: 1 by: -1 do: [:where|
		currentSet := (matrix at: where).
		1 to: (currentSet size) do:[:where2|
			currentItem := currentSet at: where2.
			(currentItem isNil)
				ifTrue: [
					' ' o.]
				ifFalse:[
					currentItem o.]
		].
		' ' oo.
	].
!!
"================================================================"
!Graph methodsFor: 'accessing'!
dataPoints
	^dataPoints
!
height
	^height
!
width
	^width
!
label
	^label
!
matrix
	^matrix
!
ox
	^ox
!
oy
	^oy
!
xrange
	^xrange
!
yrange
	^yrange
!
xTicks
	^xTicks
!
yTicks
	^yTicks
!!
