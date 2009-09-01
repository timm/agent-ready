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
	^if value 
!!
