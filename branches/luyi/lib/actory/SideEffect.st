! SideEffect class methodsFor: 'creation'!
new
 	^super new init.
!!

! SideEffect methodsFor: 'creation'!
init
	effects := Dictionary new. 
	effects at: 0 put: true.
!
Rand
	^effects at: (((effects size)-1) * (Random next)) rounded.
!
add: aSideEffect
	effects at: (effects size) put: aSideEffect. 
!!
