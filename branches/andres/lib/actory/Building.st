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
    current := floor.
    floors addLast: floor.
    floor factory: self.
!

log: aThing at: aPlace
	logs at: aThing put: aPlace.
!

professorOut: nameString
	logs removeKey: nameString.
!

professorIn: nameString
	   self log: nameString at: 'ground'.
!

placeSensor: aStringID at: floorID
	self log: aStringID to: floorID.
	super machine aStringID.
!!




"-----------------------------"
!Building methodsFor: 'accessing' !
logs
	^logs
!

floors
	^floors
!!