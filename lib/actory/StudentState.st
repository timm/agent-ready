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
	states at: 4 put: #LifeFootball.
	states at: 5 put: #LifeLottory.
	states at: 6 put: #LifeHaHa.
	states at: 7 put: #LifeEndF.
	states at: 8 put: #LifeFun.
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
RandState: aString
	|index pstates pkeys key|
	pstates := (states select: [:value| value ~ aString]).
	pkeys := pstates keys asOrderedCollection.
	
	index := Random between: 1 and: (pkeys size). 
	key := pkeys at: index.
 	^(pstates at: key).
	
!
startState
	^(states at: 0).
!!
