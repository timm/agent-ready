! Course class methodsFor: 'creation'!
new: name
	 ^(super new: name) init.
	

!!

"======================================"
! Course methodsFor: 'creation'!
init
	trans := super transitions.
	prerequisite := Dictionary new. 
	selfEvents := CourseEvent new: (self name).
	selfEvents course: self.
	patience := selfEvents patience. 
	students := Dictionary new.
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
setPatience: aPatience
	selfEvents setPatience: aPatience. 
!
getSelfEvents
	^selfEvents.
!
getPrerequisite
	^prerequisite.
!
require: aName
	prerequisite at: aName put: aName.
!
assignStudent: aStudent
	students at: (aStudent name) put: aStudent.
!
walksIn: aFactory
	aFactory machine: self.
!!		
