! Status class methods !
init
	^self init: Random new.
!
init: seed
	self 	seed: seed;
			asynchronousOff;
			silent 
!
seed: seed
	Random the seed: seed !
say: message
	Trace ifTrue: [('Status> ' s, message ) o] !
silent
	Trace := false !
verbose
	Trace := true !
asynchronousOn
	Asyncrhonoup := true !
asynchronousOff
	Asyncrhonoup := false !
!
