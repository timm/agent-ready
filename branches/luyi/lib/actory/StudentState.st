!StudentState class methodsFor: 'creation' !
new
	^super new init.
!!
"=========================================="
!StudentState methodsFor: 'creation'!
init
	states := Dictionary new. 
	states at: 0 put: #start.
	states at: 1 put: #CourseEndF.
	states at: 2 put: #CourseworkL.
	states at: 3 put: #CourseHaHa.
!!
"=========================================="
!StudentState methodsFor: 'storing'!
add: state
	(states includes: state)
		ifFalse: [states at: (states size) put: state].
!
states
	^states.
!
RandState
	|index|
	index := (Random next * ((states size)-1)) rounded.
	^State from: (states at: index).
!
startState
	^State from: (states at: 0).
!!
