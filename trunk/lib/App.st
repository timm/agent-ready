! App class methods !
nextId
	Ids ifNil:[ Ids := 0].
	^Ids := Ids + 1.
!
tooManyLoops
	^TooManyLoops
!
tooManyLoops: anInteger
	^TooManyLoops := anInteger.
!
dawnOfTime
	Clock := 0
!
tick
	^Clock := Clock + 1
!
ready
	^self reset.
!
reset
	^self reset: 1 maxLoops: 250
!
reset: seed maxLoops: n
	self 	dawnOfTime;
			tooManyLoops: n;
			seed: seed;
			asynchronousOff;
			silent 
!
random
	Rand ifNil: [ Rand := self seed].
	^Rand
!  
seed
	^self seed: 1
!
seed: seed
	^(Rand := Random new seed: seed )
!
say: message
	Trace ifTrue: [('Status> ' s, message ) oo] 
!
silent
	Trace := false 
!
verbose
	Trace := true 
!
asynchronousOn
	Asyncrhonoup := true 
!
asynchronousOff
	Asyncrhonoup := false 
!!
