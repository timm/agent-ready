! Transition methods!
fire
	then value.
	^next
!
init
	if   := [true].
	then := [true].
!
ready 
	^if value 
!
relevant: aState
	^aState == state
!!
