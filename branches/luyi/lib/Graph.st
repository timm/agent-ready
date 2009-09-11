"design note: this is a MODEL class that should not be polluted with
 DATA concepts (e.g. reading graph spec)
"
! Graph class methods !
new
	^super new init
!!
! Graph methods !
frame
       ox to: (width  - 1) do: [:i| self plot: i  @ oy           with: $- ].
       ox to: (width  - 1) do: [:i| self plot: i  @ (height - 1) with: $- ].
       oy to: (height - 1) do: [:i| self plot: ox @ i            with: $| ].
       oy to: (height - 1) do: [:i| self plot: (width - 1) @ i   with: $| ] 
!
height
	^height
!
xrange ^xrange
!
yrange ^yrange
!
ox ^ox
!
oy ^oy
!
matrix ^matrix
!
height: h 
	height := h.
!
height: h width: w
	height := h.
	width  := w.
	self resize. 
!
xindices
	^xindices
!
yindices
	^yindices
!
xindices: xin
	xindices := xin.
!
yindices: yin
	yindices := yin.
!	 
label ^label
!
rawdata ^rawdata
!
init
	label  := ''. 
	xrange := Range new.
	yrange := Range new.
	xindices := OrderedCollection new.
	yindices := OrderedCollection new.
	matrix := OrderedCollection new.
	rawdata := Dictionary new.
	ox :=6.
	oy :=2.
	self height: 0  width: 0.
!
resize
	|nheight nwidth|
	nheight := height +oy.
	nwidth := width +ox. 
       matrix := Array new: nheight.
       1 to: nheight do: [:i|
           matrix at: i put: (Array new: nwidth) ].
!
label: aString
	label := aString.
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
width
	^width
!
width: aNumber
	^width := aNumber
!
xscale: aNumber
	^((xrange scale: aNumber) * (width - 1 - ox) + ox) rounded
!
yscale: aNumber
	^((yrange scale: aNumber) * (height - 1 - oy) + oy) rounded
!
prtLabel
	|twidth|
        twidth := (width+ ox - (label size))/2.
        self splot:( Point x:twidth y:0) with: label.
!
prtticks
	|btemppoint bltemppoint ltemppoint lltemppoint xpoint ypoint|

	1 to: xindices size do:[:i|
	xpoint := xindices at: i.
	btemppoint :=(Point x: (self xscale: (xpoint x)) y: (xpoint y)).
	bltemppoint :=(Point x: (btemppoint x) y:oy-1).
        self plot: btemppoint with: '|'.
        self plot: bltemppoint with: (xpoint x)].

	1 to: yindices size do:[:j|
	ypoint := yindices at:j.
	ltemppoint := (Point x: (ypoint x) y: (self yscale: (ypoint y))).
	lltemppoint := (Point x: ox-1 y:(ltemppoint y)).
	self plot: ltemppoint with: '-'.
        self plot: lltemppoint with: (ypoint y)].
!
datatrans
	|tempx tempy|
	rawdata keysAndValuesDo: [:key :value|
	tempx := (self xscale: key x).
	tempy := (self yscale: key y).
	self plot: (Point x: (self xscale: key x) y:(self yscale: key y)) with: value ]
!
draw
	|cArray ccitem cstream|
	self frame.
	self prtticks.
	self datatrans.
	(matrix size) to: 1 by: -1 do: [:cindex|
	cArray := (matrix at: cindex).
       	1 to: (cArray size) do:[:citem|
	ccitem := cArray at: citem.
	(ccitem isNil)
		ifTrue:  [' ' o.]
		ifFalse: [ccitem o ]
	].
	' ' oo.
	]
!!
