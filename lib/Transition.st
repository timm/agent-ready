! Transition methods!
factory
	^container factory
!
fire
	then value.
	^next
!
init
	id  := App nextId.
	if   := [true].
	then := [true].
!
machine
	^container
!
machine: aMachine 
	container := aMachine.
	state := aMachine addState: state.
	next  := aMachine addState: next.
	state oneMoreFrom.
	next  oneMoreTo.
!
printOn: aStream
	aStream nextPutAll: #Transition;
			nextPut: $(;
			nextPutAll: 'from: '.
	state printOn: aStream.
    aStream	nextPutAll: ' to: '.
	next printOn: aStream.
	aStream nextPut: $)
!
ready
	^if value.
!
start
	state onEntry
!
staysAt: here
	state := here.
	next := here.
!!
