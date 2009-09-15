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
	tags := OrderedCollection new.
	height:= 24.
	width:= 80.
	ox := 6.
	oy := 3.
!


frame
       self resize.
       ox to: width	do: [:i| self plot: i	    @ oy      with: $- ].
       ox to: width 	do: [:i| self plot: i	    @ height  with: $- ].
       oy to: height 	do: [:i| self plot: ox 	    @ i       with: $| ].
       oy to: height 	do: [:i| self plot: width   @ i       with: $| ]
!



writeticks
	| scaled tick |
	1 to: bottomticks size do: [:i|
	  tick := (bottomticks at: i) asWords.
	  scaled := self xscale: tick first asInteger.
	  self plot: scaled @ oy with: $|.
	  self splot: scaled @ (oy - 1) with: (tick second) ].
	1 to: tags size do: [:i|
	  tick := (tags at: i) asWords.
	  scaled := self xscale: tick first asInteger.
	  self plot: scaled @ oy with: $|.
	  self splot: scaled @ (oy - 1) with: (tick second) ].
	1 to: leftticks size  do: [:i|
	  tick := (leftticks at: i) asWords.
	  scaled := self yscale: (tick first) asInteger.
	  self plot: ox @ (scaled) with: $-.
	  self splot: 1 @ scaled with: (tick second) ].
!

tags: t
      | tick |
      [t isEmpty] whileFalse: [ 
      	 tick := t removeFirst.
      	 xrange add: tick asInteger.
	 tags add: tick , ' ', (t removeFirst)
	 ].
!


writedata
	|datapoint xsc ysc|
	1 to: data size do: [:i|
	  datapoint := data at: i.
	  xsc := self xscale: datapoint first.
	  ysc := self yscale: datapoint second.
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
	self frame.
	self writeticks.
	self writedata.
	self writelabel.
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
      | datapoint tmp |
      tmp := d asWords.
      datapoint := Array new: 3.
      tmp size = 3 ifTrue: [
      	  datapoint at: 1 put: tmp first asInteger.
	  datapoint at: 2 put: tmp second asInteger.
	  datapoint at: 3 put: tmp third].
      tmp size = 2 ifTrue: [
      	  datapoint at: 1 put: data size asInteger.
	  datapoint at: 2 put: tmp first asInteger.
	  datapoint at: 3 put: tmp second].
      xrange add: datapoint first.
      yrange add: datapoint second.
      data addLast: datapoint.
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

leftticks: y
	   1 to: y size do: [:i|
	     yrange add: (y at: i) asInteger.
	     leftticks add: (((y at: i) asString), ' ') , ((y at: i) asString).
	     ].
!

bottomticks
	^bottomticks
!

bottomticks: x
	   1 to: x size do: [:i|
	     xrange add: (x at: i) asInteger.
	     bottomticks add: (((x at: i) asString), ' ') , ((x at: i) asString).
	     ].
!

label
	^label
!

label: l
       label := l
!

mb: s
    |c a b xt yt datapoint|
    a := s first asInteger.
    b := s second asInteger.
    c := s third.
    1 to: data size do: [:i|
      datapoint := Array new: 3.
      xt := (data at: i) first.
      yt := (a * xt) + b.
      datapoint at: 1 put: xt.
      datapoint at: 2 put: yt.
      datapoint at: 3 put: c.
      data addLast: datapoint.
      ].
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
