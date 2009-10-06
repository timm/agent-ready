! SideEffect class methodsFor: 'creation'!
new
 	^super new init.
!!

! SideEffect methodsFor: 'creation'!
init
	effects := Dictionary new. 
!
rand
	^effects at: ((effects size) *(Random next) rounded).
!
add: aSideEffect
	effects at: (effects size) put: aSideEffect. 
!!
