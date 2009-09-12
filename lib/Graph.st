"design note: this is a MODEL class that should not be polluted with
 DATA concepts (e.g. reading graph spec)
"
! Graph class methods !
new
	^super new init
!!
! Graph methods !
init
	label  := ''. 
	xrange := Range new.
	yrange := Range new.
	data := OrderedCollection new.
	matrix := OrderedCollection new.
	bottomticks := OrderedCollection new.
	leftticks := OrderedCollection new.
	height:= 0.
	width:= 0.
	ox := 6.
	oy := 3.
!


frame
       ox to: (width) do: [:i| self plot: i  @ oy           with: $- ].
       ox to: (width) do: [:i| self plot: i  @ (height) with: $- ].
       oy to: (height) do: [:i| self plot: ox @ i            with: $| ].
       oy to: (height) do: [:i| self plot: (width) @ i   with: $| ]
!



writeticks
	| scaled |
	1 to: bottomticks size do: [:i|
	  scaled := self xscale: (bottomticks at: i) asInteger.
	  self plot: scaled @ oy with: $|.
	  self splot: scaled @ (oy - 1) with: (bottomticks at: i) ].
	1 to: leftticks size  do: [:i|
	  scaled := self yscale: (leftticks at: i) asInteger.
	  self plot: ox @ (scaled) with: $-.
	  self splot: 1 @ scaled with: (leftticks at: i) ].
!

writedata
	|datapoint xsc ysc|
	1 to: data size do: [:i|
	  datapoint := (data at: i) asWords.
	  xsc := self xscale: datapoint first asInteger.
	  ysc := self yscale: datapoint second asInteger.
	  self plot: xsc @ ysc with: datapoint third.
	  ]
!

writelabel
	self splot: (self lcenter: label) @ 1 with: label.
!

resize 
       matrix := Array new: (height + oy).
       1 to: height do: [:i|
           matrix at: i put: (Array new: width + ox) ].
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

draw
	|row|
	(matrix size - oy) to: 1 by: -1 do: [:x|
	      	     	      row := matrix at: x.
			      1 to: row size do: [:y|
						(row at: y) isNil ifTrue: [' ' o]
			      			  	ifFalse: [(row at: y) o].
						].
			      '' oo.
			      ].
!
data 
     ^data
!

data: d
	data addLast: d.
!

range: r
       xrange add: r first asInteger.
       yrange add: r second asInteger.
       xrange add: r third asInteger.
       yrange add: r fourth asInteger.
!

xrange
	^xrange
!

yrange
	^yrange
!

leftticks
	^leftticks
!

leftticks: x
	leftticks := x
!

bottomticks
	^bottomticks
!

bottomticks: y
	bottomticks := y
!

label
	^label
!

label: l
       label := l
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

width
	^width
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

lcenter: aString
	 ^(self xscale: xrange max / 2) rounded - (aString size / 2) rounded.
!!
