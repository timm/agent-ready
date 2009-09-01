! App class methods !
nextId
	Ids ifNil:[ Ids := 0].
	^Ids := Ids + 1.
!
ready
	^self ready: 1
! 
ready: seed
	self 	seed: seed;
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
	Trace ifTrue: [('Status> ' s, message ) o] 
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
