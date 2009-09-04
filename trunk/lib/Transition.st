! Transition methods!
printOn: aStream
	aStream nextPutAll: #Transition;
			nextPut: $(;
			nextPutAll: 'from: '.
	state printOn: aStream.
    aStream	nextPutAll: ' to: '.
	next printOn: aStream.
	aStream nextPut: $)
!
machine: aMachine 
	container := aMachine.
	state := aMachine addState: state.
	next  := aMachine addState: next.
	state incFroms.
	next  incTos.
!
mill
	^container mill
!
machine
	^container
!
reset
	state reset.
	next reset.
!
start
	state onEntry
!
staysAt: here
	state := here.
	next := here.
!
fire
	then value.
	^next
!
init
	if   := [true].
	then := [true].
!
ready
	^if value.
!
fire
	then value.
	^next.
!!
