! Course class methodsFor: 'creation'!
new: name
	|r|
	r:= super new: name.
	self init.
	^r.
!!

"======================================"
! Course methodsFor: 'creation'!
init
	trans := super transitions.
	selfEvents := CourseEvent new.
	selfEvents course: self.
	patience := 100.
!!
"======================"
! Course methodsFor: 'storing'!
worksIn: factory
	factory machine: self.
	self factory: factory.
	self checkandrun.
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
!!		
