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
	^'^\s*bottom\s*ticks\s*(\s\d+)*\s*$'
!!
! TagBottom methods !
line: string for: graph at: line
	|bottomString where|
	bottomString := string asWords.
	3 to: (bottomString size) do: [:ticks|
		where := (bottomString at: ticks) asInteger.
		graph xrange add: (bottomString at: ticks) asInteger.
		graph xTicks add: (Point x:where y:(graph oy)).].
!!
! TagComment class methods !
handles
	^'^\s*\#'
!!
! TagComment methods!
line: string for: graph at: line
	"Current behavior is to do nothing with comments."
!!
! TagData class methods !
handles
	^'^\s*((\d+)\s+)+.\s*$'
!!
! TagData methods !
line: string for: graph at: line
	|dataString|
	dataString := string asWords.
	graph xrange add: ((dataString at:1) asInteger).
	graph yrange add: ((dataString at:2) asInteger).
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
	^'^\s*left\s*ticks\s*(\s\d+)*\s*$'
!!
! TagLeft methods !
line: string for: graph at: line
	|leftString where|
	leftString := string asWords.
	3 to: (leftString size) do: [:ticks|
		where := (leftString at: ticks) asInteger.
		graph yrange add: (leftString at: ticks) asInteger.
		graph yTicks add: (Point x:(graph ox) y:where).].
!!
! TagMb class methods !
handles
	^'^\s*mb'
!!
! TagMb methods !
line: string for: graph at: line
	"We are not required to impliment MB"
!!
! TagRange class methods !
handles
	^'^\s*range\s*(\s\d+)*\s*$'
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
! TagTag class methods !
handles
	^'^\s*tag\s+'
!!
!TagTag methods !
line: string for: graph at: line
	|tagString|
	tagString:=string asWords.
	graph tags at: ((tagString at:2) asInteger) put: (tagString at: 3).
	graph yrange add: ((tagString at: 4) asInteger).
	1 to: ((tagString at: 4) asInteger) do: [:where|
		graph dataPoints at: (Point x:((tagString at: 2) asInteger) y:where) put:(tagString at: 5).
	].
!!
! TagTags class methods !
handles
	^'^\s*tags\s+'
!!
!TagTags methods !
line: string for: graph at: line
	|tagString|
	tagString:=string asWords.
	2 to: tagString size by: 2 do: [:where|
		graph tags at: ((tagString at:where) asInteger) put: (tagString at: where+1).].
!!
! TagWidth class methods !
handles
	 ^'^\s*width\s+(\d+)\s*$'
!!

! TagWidth methods !
line: string for: graph at: line
	graph width: string asWords second asInteger.
!!
