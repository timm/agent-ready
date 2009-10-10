! Floor class methodsFor: 'creation'!
new: name
      ^(super new: name) init.
!!

"--------------------------------"
! Floor methodsFor: 'creation' !

init
    squares := 36. "divide floor in squares on a grid 6 x 6"
    rooms := Array new: squares.
    sensors := Array new: squares.
    interferenceSources := 0.
    ('****Initial values are:   *****')oo.
    ('floor= ', name s)oo.
!!

"----------------------------------"
! Floor methodsFor: 'operations' !

worksIn: building
    building floor: self.
!!

"-----------------------------------"
! Floor methodsFor: 'storing' !

room: aRoom isa: roomType
      ^rooms at: (aRoom asInteger) put: roomType.
!

sensorAt: aRoom
      ^sensors at: (aRoom asInteger) put: true.
!!


"--------------------------------"
! Floor methodsFor: 'accessing' !

squares
    ^squares.
!

rooms
    ^rooms.
!

sensors
    ^sensors.
!!


"--------------------------------"
! Floor methodsFor: 'printing' !
talks: x
       ('Floor:[', id s, '] ', x s) oo.
!!