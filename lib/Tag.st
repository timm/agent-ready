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
! TagBottom class methods !
handles
	^'^\s*bottom\s*ticks(\s\d+)*\s*$'
!!
! TagBottom methods !
line: string for: graph at: line
	|bottomString where|
	bottomString := string asWords.
	3 to: (bottomString size) do: [:ticks|
		where := (bottomString at: ticks) asInteger.
		graph xTicks add: (Point x:where y:(graph oy)).].
!!
! TagData class methods !
handles
	^'^\s*((\d+)\s+)+.\s*$'
!!
! TagData methods !
line: string for: graph at: line
	|dataString|
	dataString := string asWords.
	graph dataPoints at: (Point x:((dataString at:1) asInteger) y:((dataString at: 2) asInteger)) put: (dataString at: 3).
!!
! TagHeight class methods !
handles
	 ^'^\s*height\s+(\d+)\s*$'
!!
! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second asInteger.
!!
! TagLabel class methods !
handles
	^'^\s*label\s+'
!!
! TagLabel methods !
line: string for: graph at: line
	"Idea for handling this from Andres."
	graph label: (string replacingRegex: '^\s*label\s+' with: '').
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
		where := (leftString at: ticks) asInteger.
		graph yTicks add: (Point x:(graph ox) y:where).].
!!
! TagRange class methods !
handles
	^'^\s*range(\s\d+)*\s*$'
!!
! TagRange methods !
line: string for: graph at: line
	|rangeString xMin xMax yMin yMax|
	rangeString := string asWords.
	xMin := (rangeString at: 2) asInteger.
	xMax := (rangeString at: 4) asInteger.
	(xMin < xMax) 
		ifTrue: [
			graph xrange add: xMin.
			graph xrange add: xMax.]
		ifFalse: [
			'Warning: Your max is smaller than your min. They will be swapped' o.
			graph xrange add: xMin.
			graph xrange add: xMax.].	 
	yMin := (rangeString at: 3) asInteger.
	yMax := (rangeString at: 5) asInteger.
	(yMin < yMax) 
		ifTrue: [
			graph yrange add: yMin.
			graph yrange add: yMax.]
		ifFalse: [
			'Warning: Your max is smaller than your min. They will be swapped' o
			graph yrange add: yMin.
			graph yrange add: yMax.].
!!
! TagWidth class methods !
handles
	 ^'^\s*width\s+(\d+)\s*$'
!!

! TagWidth methods !
line: string for: graph at: line
	graph width: string asWords second asInteger.
!!
