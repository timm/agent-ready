! Transition methods!
printOn: aStream
	aStream nextPutAll: #Transition;
			nextPut: $(;
			nextPutAll: 'from: ';
			nextPutAll: state name;
			nextPutAll: ' to: ';
			nextPutAll: next name;
			nextPut: $)
!
machine: aMachine
	container := aMachine
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
	state := next := here.
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
