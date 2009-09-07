! Machine class methods !
new: name
	^super new init: name
!!
! Machine methods !
add: transition
	|what|
	transition machine: self.
	what := transition state name.
	transitions at: what
				ifAbsent: [transitions at: what
                                      put: Stagger new].
	(transitions at: what) add: transition.

!
addState: aState
	|new|
	new := states at: aState name ifAbsent: [aState].
	new machine: self.
	states at: aState name put: new.
	(aState name == #start) ifTrue: [start := aState].
	^new.
!
anyState
	states do: [:state | ^state].
!
candidates
	^self candidates:  current 
!
candidates: aState
     ^transitions at: aState name
	    ifAbsent: [#()].
!
continue
	^current continue
!
current
	^current
!
error: message
	^super error: ('Machine[,'id s,']: ', message) 
! 
factory
	^container
!
factory: aFactory
	container := aFactory
!
id
	^id
!
init: aString
	name        := aString.
	id          := App nextId.
	transitions := Dictionary new.
	states      := Dictionary new.
!
name
	^name
!
printOn: aStream
	|s|
	aStream nextPut: $(;
	        nextPutAll: self class name  asString;
			nextPut: $#.
	id printOn: aStream.
    aStream space.
	name printOn: aStream.
	aStream nextPutAll: ' with '.
	s := transitions size .
	s printOn: aStream.
	aStream nextPutAll: ' group'.
    s=1 ifFalse: [aStream nextPut: $s].
    aStream nextPut: $)
!
reset
	current := start isNil ifTrue:  [self anyState]
                           ifFalse: [start].
	states do: [:state|
		state reset]
!
start
	^current := start
!
step
	|now next|
	self stopped ifTrue: [^false].
	self candidates do: [:candidate |
		The := candidate.
		candidate ready 
			ifTrue: [
				now  := current.
				next := candidate fire.
				(next name = current name)
					ifTrue:  [current onStay]
					ifFalse: [now onExit.
							  current := next.
							  current onEntry].
				^true]].
	^false
!
stopped
	^current stopped
!
transitions
	^transitions
!!
