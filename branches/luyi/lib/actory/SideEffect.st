!SideEffect class methodsFor 'creation'!
new
 	^super new init.
!
init
	effects := Dictionary new. 
!
rand
	^effects at: ((effects size) *(Random next) rounded).
!!
	
	
