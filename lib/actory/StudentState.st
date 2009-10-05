!StudentState class methodsFor: 'creation' !
new
	^super new init.
!!
"=========================================="
!StudentState methodsFor: 'creation'!
init
	states := Dictionary new. 
!!
"=========================================="
!StudentState methodsFor: 'storing'!
add: state
	states at: (states size) put: state.
!
RandState
	|index|
	index := (Random next * ((states size)-1)) rounded.
	^State from: (states at: index).
!!
