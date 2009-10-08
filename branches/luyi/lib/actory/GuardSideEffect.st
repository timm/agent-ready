!GuardSideEffect class methodsFor: 'creation'!
new
	^super new init.
!!

!GuardSideEffect methodsFor: 'creation'!
init
	|parray|
	gsesets := Dictionary new. 
	self guard: [true] effect: [true].
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
	gsesets at: (gsesets size) put: gsepair.
!!
!GuardSideEffect methodsFor: 'accessing'!
Rand
        |index|
        index := (Random next * ((gsesets size) -1)) rounded.
        ^(gsesets at: index).

!!
