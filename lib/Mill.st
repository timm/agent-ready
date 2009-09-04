! Mill class methods !
new: aString
	^super new init: aString
!
! Mill methods !
init: aString 
	machines := Stagger new.
	name := aString
!
printOn: aStream
	super printOn: aStream.
	name printOn: aStream
!
reset
	machines do:[:machine | machine reset]
!
newMachine: name
	self machine: (Machine new: name).
!
machine: machine
	current := machine.
	machines add: machine.
	machine mill: self.
!
transition: trans
	current add: trans
!
do: aBlock
	machines do: [:machine| aBlock value: machine]
!
start
	self do: [:machine| machine start].
!
step
	| more |
	more := false.
	self do: [:machine|
	  machine step 
		ifTrue: [
			more := true.
		    Asynchronousp 
		   	   ifTrue: [^true]]].
	^more
!
walk
	"Important: must be tail recursive."
	App tick.
	self step ifTrue: [self walk].
!
run
	App reset.
	self reset; start; walk
!!
