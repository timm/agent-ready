! Machine class methods !
new: name
	^super new init: name
!!
! Machine methods !
reset
	transitions do: [:transition|
		transition reset]
!
printOn: aStream
	|s|
	aStream nextPutAll: '(Machine#'.
    id printOn: aStream.
	aStream nextPutAll: ' with '.
	s := transitions size .
	s printOn: aStream.
	aStream nextPutAll: ' group'.
    s=1 ifFalse: [aStream nextPut: $s].
    aStream nextPut: $)
!
id
	^id
!
mill
	^container
!
mill: aMill
	container := aMill
!
init: aString
	name        := aString.
	id          := App nextId.
	transitions := Dictionary new.
	states      := Dictionary new.
!
continue
	^current continue
!
start
	current start
!
error: message
	^super error: ('Machine[,'id s,']: ', message) 
! 
addState: aState
	|new|
	new := states at: aState name ifAbsent: [aState].
	new machine: self.
	states at: aState name put: new.
	^new.
!
add: transition
	|state currentSymbol|
	transition machine: self.
	current       := transition state.
	currentSymbol := current name.
	transitions at: currentSymbol
				ifAbsent: [transitions at: currentSymbol
                                      put: Stagger new].
	(transitions at: currentSymbol) add: transition.

!
current
	^current
!
transitions
	^transitions
!
candidates
	^self candidates:  current 
!
candidates: aState
     ^transitions at: aState name
	    ifAbsent: [
           self error: ('Missing state: [', aState printString)].
!
step
	self stopped ifTrue: [^false].
	self candidates do: [:candidate |
		candidate ready 
			ifTrue: [
				current := candidate fire.
				current = candidate next
					ifTrue:  [current onStay]
					ifFalse: [current onExit.
							  current := candidate next.
							  current onEntry].
				^true]].
	^false
!
stopped
	^current stopped
!!
