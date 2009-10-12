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
      logs := Dictionary new.
      floors := OrderedCollection new.
      ^super init: aString
!!

"------------------------------"
!Building methodsFor: 'storing' !

professor: professor
    self machine: professor.
!

floor: floor
    floors addLast: floor.
    self machine: floor.
!

log: aThing at: aPlace
	logs at: aThing put: aPlace.
!

professorOut: nameString
	logs removeKey: nameString.
!

professorIn: nameString
	   self log: nameString at: 'ground'.
!!




"-----------------------------"
!Building methodsFor: 'accessing' !
logs
	^logs
!

floors
	^floors
!!
