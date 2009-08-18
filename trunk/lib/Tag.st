"XXX find an implement any empty methods in the following"
!Tag class methods!
handles
	 ^'someImpossibBle STRing'
!
handlerOf: line
	   "XXX if not class handles tag, then instiate  TagError
           and get it to handle it by printing an error message"
	   self allSubclasses do: [:class|	
	   		class handles ~ line ifTrue: [^class]].
       ^nil "XXX once TagError is running, get rid of this return" !
!!
!Tag methods !
handles
	^'^\s*\[.+\]\s*$'
!
line: string for: this at: line
	this block: (Behavior evaluate: string )
!!
! TagWidth class methods !
handles
	^'^\s+width\s+(\d+)\s*$'
!!

! TagWidth methods !
line: string for: graph at: line
	graph width: string asWords first asInteger.
	"if we expect a float, use Float readFrom: self"
! !
