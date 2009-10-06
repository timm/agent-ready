!GuardSideEffect class methodsFor: 'creation'!
new
	^super new init.
!!

!GuardSideEffect methodsFor: 'creation'!
init:
	gseset := Dictionary new. 
!!
!GuardSideEffect methodsFor: 'storing'!
guardeffect
	self guard: true effect: true.
!
guard: aGuard effect: aSideEffect
	|gsepair|
	gsepair := Array new: 2.
	gsepair at: 1 put: aGuard.
	gsepair at: 2 put: aSideEffect.
	gseset at: (gseset size) put: gsepair.
!!
!GuardSideEffect methodsFor: 'accessing'!
Rand
        |index|
        index := (Random next * ((gseset size) -1)) rounded.
        ^(gseset at: index).

!
