! Machine class methodsFor: 'creation' !
new: name
	^super new init: name
!!

"============================================="
! Machine methodsFor: 'creation' !
init: aString
	name        := aString.
	id          := App nextId.
	transitions := Dictionary new.
	states      := Dictionary new.
!!

"============================================="
! Machine methodsFor: 'storing' !
add: transition
	|what|
	transition machine: self.
	what := transition state name.
	transitions at: what
				ifAbsent: [transitions at: what
                                      put: Stagger new].
	(transitions at: what) add: transition.
	transition stagger: (transitions at: what).

!
addState: aState
	|new|
	new := states at: aState name ifAbsent: [aState].
	new machine: self.
	states at: aState name put: new.
	(aState name == #start) ifTrue: [start := aState].
	^new.
!!

"============================================="
! Machine methodsFor: 'accessing' !
anyState
	states values at: ((App random next * (states size) ) rounded)
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

factory
	^container
!
factory: aFactory
	container := aFactory
!
reload 
	transitions := Dictionary new.
	states := Dictionary new.
!
id
	^id
!
name
	^name
!
stopped
	^current stopped
!
transitions
	^transitions
!!

"============================================="
! Machine methodsFor: 'simulation' !
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
				((candidate stagger) logger) log: candidate. 
				
				(next name = current name)
					ifTrue:  [current onStay]
					ifFalse: [now onExit.
							  current := next.
							  current onEntry].
				^true]].
	^false
!!

"============================================="
! Machine methodsFor: 'errors' !
error: message
	^super error: ('Machine[,'id s,']: ', message) 
!! 

"============================================="
! Machine methodsFor: 'printing' !
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
!!
