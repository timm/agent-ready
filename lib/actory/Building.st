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
      sensors := Dictionary new.
      floors := 0.
      ^super init: aString
!!

"------------------------------"
!Building methodsFor: 'storing' !

log: nameString to: nameSensor
	logs at: nameString put: nameSensor.
!

logOut: nameString
	logs removeKey: nameString.
!

professorIn: nameString
	   log: nameString to: 'entrance'.
	   super machine: name.
!

sensorPlaced: aStringID at: floorID
	log: aStringID to: floorID.
	super machine aStringID.
!!




"-----------------------------"
!Building methodsFor: 'accessing' !
logs
	^logs
!
sensors
	^sensors
!

floors
	^floors
!!