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
stepBias
	|now next cands numB base found done|
	self stopped ifTrue: [^false].
	cands:= Stagger new.
	cands:= self candidates.
	numB:= The factory biases size. 	
	done:=Dictionary new.

	self candidates do: [:candidate |
		(done includesKey: (candidate tid s)) ifFalse:[
		found:=false. 
		The factory biases associationsDo: [:b|
			"Add N times if it is already in biases"
			(candidate tid= b key) ifTrue:[
				(b value)-1 timesRepeat:[
					cands add: candidate.
				].
				found:=true.
			].
		].
		(found)
			"Add 1/remaining unbiased if not"
			ifFalse:[
				base:= ((1/(self tcounter -1 -numB) asFloat)*100) rounded.
				(base-1) timesRepeat:[
					cands add: candidate.
				].
		].

		done at: (candidate tid s) put: 1.
		].
	].

	"cands reset."

	"cands do:[:x |
		x tid oo.
	].
	'----' oo."

	cands do: [:candidate |
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
