!Building class methodsFor: 'creation'!
new
	self error: 'Should not create Building without Name'
!
new: nameString
     ^super new: nameString
!!

"-----------------------------"
!Building methodsFor: 'creation' !

init: aString
      totalSensorCost := 0.
      floors := OrderedCollection new.
      professors := OrderedCollection new.
      ^super init: aString
!!

"------------------------------"
!Building methodsFor: 'storing' !

professor: aProfessor
    professors addLast: aProfessor id.
    self machine: aProfessor.
!

floor: aFloor
    floors addLast: aFloor id.
    self machine: aFloor.
!

professorOut: nameString
	professors remove: nameString ifAbsent: [The machine 
		   	   	      		     talks: 'Weird stuff happened'.]
!!




"-----------------------------"
!Building methodsFor: 'accessing' !
professors
	^professors
!

floors
	^floors
!!
