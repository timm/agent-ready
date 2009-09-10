"XXX find an implement any empty methods in the following"
!Tag class methods!
handles
	 ^'someImpossibBle STRing'
!
handlerOf: line
	   self allSubclasses do: [:class|	
	   		line ~ class handles  ifTrue: [^class]].
       ^nil "XXX once TagError is running, get rid of this return" 
!!
!Tag class methods !
handles
	^'^\s*\[.+\]\s*$'
!
line: string for: this at: line
	this block: (Behavior evaluate: string )
!!
! TagWidth class methods !
handles
	 ^'^\s*width\s+(\d+)\s*$'
!!

! TagWidth methods !
line: string for: graph at: line
	graph width: string asWords second asInteger.
!!
! TagHeight class methods !
handles
	 ^'^\s*height\s+(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second asInteger.
!!
! TagRange class methods !
handles
	^'^\s*range(\s\d+)\s*$'
!!

! TagRange methods !
line: string for: graph at: line
	|rangeString xMin xMax yMin yMax|
	rangeString := string asWords.
	xMin := rangeString at: 2.
	xMax := rangeString at: 4.
	(xMin < xMax) 
		ifTrue: [
			graph xrange add: xMin.
			graph xrange add: xMax.]
		ifFalse: [
			'Warning: Your max is smaller than your min. They will be swapped' o.
			graph xrange add: xMin.
			graph xrange add: xMax.].	 
	yMin := rangeString at: 3.
	yMax := rangeString at: 5.
	(yMin < yMax) 
		ifTrue: [
			graph yrange add: yMin.
			graph yrange add: yMax.]
		ifFalse: [
			'Warning: Your max is smaller than your min. They will be swapped' o
			graph yrange add: yMin.
			graph yrange add: yMax.].
!!
! TagBottom class methods !
handles
	^'^\s*bottom\s*ticks(\s\d+)*\s*$'
!!
! TagBottom methods !
line: string for: graph at: line
	|bottomString where|
	bottomString := string asWords.
	3 to: (bottomString size) do: [:ticks|
		where := graph xscale:((bottomString at: ticks) asInteger).
		graph plot: (Point x:where y:(graph oy)) with: '|'.
		graph splot: (Point x:where y:((graph oy)-1)) with: (bottomString at:ticks).].	
!!
! TagLeft class methods !
handles
	^'^\s*left\s*ticks(\s\d+)*\s*$'
!!
! TagLeft methods !
line: string for: graph at: line
	|leftString where|
	leftString := string asWords.
	3 to: (leftString size) do: [:ticks|
		where := graph yscale:((leftString at: ticks) asInteger).
		graph plot: (Point x:(graph ox) y:where) with: '-'.
		graph splot: (Point x:0 y:where) with: (leftString at: ticks).].
!!
! TagLabel class methods !
handles
	^'^\s*label(\s\d+)*\s*$'
!!
! TagLabel methods !
line: string for: graph at: line
	|label|
	label := string
	graph splot: (Point x:(((graph width)+(graph ox)-(label size))/2) y:0) with: label.
!!
! TagData class methods !
handles
	^'^(\s*\d+)*\s\*$'
!!
! TagData methods !
line: string for: graph at: line
	|dataString whereX whereY what|
	dataString := string asWords.
	whereX := graph xscale: ((dataString at: 1) asInteger).
	whereY := graph yscale: ((dataString at: 2) asInteger).
	what := dataString at: 3.
	graph plot: (Point x:whereX y:whereY) with: what.
	graph draw
!!
