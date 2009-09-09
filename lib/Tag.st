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
	"if we expect a float, use Float readFrom: self"
! !

! TagHeight class methods !
handles
	^'\s*height\s+(\d+)\s*$'
!!

! TagHeight methods !
line: string for: graph at: line
	graph height: string asWords second asInteger.
	"if we expect a float, use Float readFrom: self"
! !

! TagLabel class methods !
handles
	^'\s*label\s+(\w+\s*)+$'
!!

! TagLabel methods !
line: string for: graph at: line
      | lbl |
      lbl := string asWords.
      lbl removeFirst.
      graph label: lbl asArray.
!!

! TagBottomTicks class methods !
handles
	^'\s*bottom\s+ticks\s+(\d+)+$'
!!


! TagBottomTicks methods !
line: string for: graph at: line
     graph width: string asWords second asInteger.
!!