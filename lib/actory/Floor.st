! Floor class methodsFor: 'creation'!
new: name
      ^(super new: name) init.
!!

"--------------------------------"
! Floor methodsFor: 'creation' !

init
    squares := 36. "divide floor in squares on a grid 6 x 6"
    rooms := Array new: squares.
    sensors := Dictionary new.
    professorsIn := OrderedCollection new.
!!

"----------------------------------"
! Floor methodsFor: 'operations' !

worksIn: building
    building floor: self;
       go: #start   to: #run	then: [The machine
       	   	    		      	 sensorAtEntrances;
       	   	    		      	 talks: 'Starting sensing at ', self name s, ' floor'];
       go: #run	    to: #run    then: [The machine talks: 'detecting'; detecting];
       go: #run	    to: #endF	if: [ professorsIn size  <=0 ]
       	   	    		then: [The machine talks: 'Floor is empty'.
       	   	    		    		       	The yourself oo.
							The state oo.
							The next oo.
							The machine oo.
							The factory oo]
!

detecting
    | tRoom tRange tProf tDist det |
    det := 0.
    professorsIn do: [:j|
         tProf := self building getProfessor: j.
	 det := 0.
    	 sensors keysDo: [:i|
             tRoom := i.
             tRange := (sensors at: i).
	     tDist := self distance: tRoom to: (tProf currentRoom).
	     tDist < tRange ifTrue: [det := det + 1].
	     tDist = 0 ifTrue: [det := det + 2].
	     App say: ('The distance between Prof: ', tProf name s, ' who is at ', tProf currentRoom s,
	      ' and the sensor in room ', tRoom s, ' which has a range of ', tRange s,
	      ' is ', tDist s).

	 ].
	 ('Professor ', tProf name s, ' in room ' , tProf currentRoom s) o.
	 self building addDetectionCycle.
	 (det >= 3) ifTrue: [' was triangulated' oo. self building addDetection.] 
	       	    ifFalse: [' couldn''t be triangulated' oo. self sensorAt: tProf currentRoom].
    ]
!

distance: aRoom to: another
    | side xdist ydist |
    side := squares sqrt.
    ydist := (((aRoom / side) floor) - ((another / side) floor)) abs.
    xdist := ((aRoom rem: side) - (another rem: side)) abs.
    ydist > xdist ifTrue: [ ^ydist] ifFalse: [ ^xdist ].
!
reports
    self building report.
!!


"-----------------------------------"
! Floor methodsFor: 'storing' !

professorIn: aProfessorId
    professorsIn addLast: aProfessorId
!

professorOut: aProfessorId
    professorsIn remove: aProfessorId
!

room: aRoom isa: roomType
      ^rooms at: (aRoom asInteger) put: (Room new: roomType).
!

sensorAt: aRoom
    sensors at: aRoom put: (App random next * 2) asInteger.
    The machine talks: 'Placed a sensor at ', aRoom s.
    self building addSensorCost.
!

sensorAtEntrances
    1 to: squares do: [:i|
      ((rooms at: i) type = 'strs' or: [(rooms at: i) type = 'elev']) ifTrue: [self sensorAt: i]
      ]
!!


"--------------------------------"
! Floor methodsFor: 'accessing' !

professorsIn
    ^professorsIn
!

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