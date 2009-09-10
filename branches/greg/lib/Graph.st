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
	self height: 0  width: 0.
	ox=6.
	oy=2.
!!
"=============================================="
! Graph methodsFor: 'doing' !
frame
       ox to: (width  - 1) do: [:i| self plot: i  @ oy           with: $- ].
       ox to: (width  - 1) do: [:i| self plot: i  @ (height - 1) with: $- ].
       oy to: (height - 1) do: [:i| self plot: ox @ i            with: $| ].
       oy to: (height - 1) do: [:i| self plot: (width - 1) @ i   with: $| ] 
!
height: h 
	self height: h width: width 
!
height: h width: w
	height := h.
	width  := w.
	self resize 
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
	^((xrange scale: aNumber) * (width - 1 - ox) + ox) round 
!
yscale: aNumber
	^((yrange scale: aNumber) * (height - 1 - oy) + oy) round 
!
draw
	|current|
	1 to: ((matrix size)-1) do: [:where|
		current := (matrix at: where).
		1 to: ((current size)-1) do:[:where|
			(current isNil)
				ifTrue: [
					'' o]
				ifFale: [
					where o]
		]
	]
!!
"================================================================"
!Graph methodsFor: 'accessing'!
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
!!
