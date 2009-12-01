!Machine class methodsFor: 'creation' !
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
	tcounter :=1.
!!

"============================================="
! Machine methodsFor: 'storing' !
add: transition
	|what|
	transition tid: tcounter.
	tcounter:=tcounter+1. 
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
!!

"============================================="
! Machine methodsFor: 'accessing' !
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

factory
	^container
!
factory: aFactory
	container := aFactory
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
!
tcounter
	^tcounter
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
pick: aSortedCollection
	|r n max|
	
	max:=0.
	aSortedCollection do:[:x|
		((x value asInteger) > max) ifTrue:[max:=(x value asInteger)].
	].
	r:= (App random next * (max+(max/3 asFloat))) rounded.
	n:=0.
	
	aSortedCollection do:[:x|
		n:=(x value s).
		(r>(x key)) ifTrue:[^n]	
	].

	^n.
!
stepBias
	|now next cdf numB max cands candidate r temp|
	self stopped ifTrue: [^false].
	numB:= The factory biases size. 
	cdf:= SortedCollection new. 
	cands:=Dictionary new.
	max:=0.
	
	"Populate weight list"
	self candidates do: [:c|
		(The factory biases includesKey: (c tid s))
		ifTrue:[cdf add: (Association key: (The factory biases at: (c tid s)) asInteger value: (c tid))]
		ifFalse:[cdf add: (Association key: (The factory bases at: (c tid s)) asInteger value: (c tid))].

		cands at: (c tid s) put: c.
	].

	(cands size) timesRepeat: [
		r:= (self pick: cdf) s.
		temp:= SortedCollection new.
		cdf do:[:x|
			(x value s = r) ifFalse:[temp add: x].
		].
		cdf:=temp.

		candidate:= cands at: r.
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
