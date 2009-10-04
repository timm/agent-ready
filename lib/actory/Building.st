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
      sensor: 'entrance' at: 'Ground'.
      floors := 0.
      ^super init: aString
!!

"------------------------------"
!Building methodsFor: 'storing' !
professor: name
	   super machine: name.
	   logIn: name at: 'entrance'.
!

sensor: name at: floor
	super machine name.
	logs at: name put: floor.
!

logIn: professor at: sensor
	logs at: professor put: sensor.
!

logOut: professor
	logs removeKey: professor
!!


"-----------------------------"
!Building methodsFor: 'accessing' !
logs
	^logs
!
sensors
	^sensors
!!