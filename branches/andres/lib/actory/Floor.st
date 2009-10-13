! Floor class methodsFor: 'creation'!
new: name
      ^(super new: name) init.
!!

"--------------------------------"
! Floor methodsFor: 'creation' !

init
    squares := 36. "divide floor in squares on a grid 6 x 6"
    rooms := Array new: squares.
    ('****Initial values are:   *****')oo.
    ('floor= ', name s)oo.
!!

"----------------------------------"
! Floor methodsFor: 'operations' !

worksIn: building
    building floor: self;
       go: #start   to: #run	then: [The machine
       	   	    		      	 sensorAtEntrances;
       	   	    		      	 talks: 'Starting sensing at ', self name s, ' floor'];
       go: #run	    to: #run    then: [The machine talks: 'detecting'];
       go: #run	    to: #endF	if: [ sensors size <=0 ]  then: [The machine talks: 'Floor sensors drained'.
       	   	    		    		       	The yourself oo.
							The state oo.
							The next oo.
							The machine oo.
							The factory oo.
							self rooms oo.].
!

detecting
    | tRoom tRange tProf |
    1 to: (sensors size) do: [:i|
        tRoom := (sensors at: i) room.
        tRange := (sensors at: i) range.
	1 to: (self building professors size) do: [:j|
	    tProf := (self building machines) at: (self building professor at: j).
	    self distance: tRoom to: tProf > tRange ifTrue: [self sensorAt: tProf]
	]
    ]
!

distance: aRoom to: another
    | side xdist ydist |
    side := squares squared.
    ydist := ((aRoom / side floor) - (another / side floor)) abs.
    xdist := ((aRoom / side rem) - (another / side rem)) abs.
    ydist > xdist ifTrue: [ ^ydist] ifFalse: [ ^xdist ].
!!


"-----------------------------------"
! Floor methodsFor: 'storing' !

room: aRoom isa: roomType
      ^rooms at: (aRoom asInteger) put: roomType.
!

sensorAt: aRoom
      |s|
      s := Sensor new: aRoom.
      sensors at: aRoom put: Sensor new: aRoom.
!

sensorAtEntrances
    1 to: squares do: [:i|
      ((rooms at: i) = 'strs' or: [(rooms at: i) = 'elev']) ifTrue: [self sensorAt: i]
      ]
!!


"--------------------------------"
! Floor methodsFor: 'accessing' !

squares
    ^squares.
!

building
    ^container.
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
       ('Floor:[', name s, '] ', x s) oo.
!!