! Course class methodsFor: 'creation'!
new: name
	 ^(super new: name) init.
	
!!

"======================================"
! Course methodsFor: 'creation'!
init
	trans := super transitions.
	selfEvents := CourseEvent new: (self name).
	selfEvents course: self.
	patience := selfEvents patience. 
!!
"======================"
! Course methodsFor: 'storing'!
worksIn: factory
	factory machine: self.
	self factory: factory.
!
add: aTransition
	super add: aTransition.
!!
"========================================"
! Course methodsFor: 'accessing'!
check
	(trans size == 0)
		ifTrue:  ['no courseEvent at all' o.]
!
patience
	^patience.
!
getSelfEvents
	^selfEvents.
!!		
