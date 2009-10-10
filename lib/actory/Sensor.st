! Sensor class methodsFor: 'creation'!
new: name
      ^(super new: name) init.
!!

"--------------------------------"
! Sensor methodsFor: 'creation' !

init
    frequency := (App random next * 10 rounded) asInteger. 
    range := 100 - frequency.
    batteryLife := 100.
    ('****Initial values are:   *****')oo.
    ('name= ', name s)oo.
    ('frequency= ', frequency s)oo.
    ('range= ', range s)oo.
    ('batteryLife= ',batteryLife s)oo.
!!

"----------------------------------"
! Sensor methodsFor: 'operations' !

worksIn: factory
    factory machine: self;
	go: #start   to: #run	then: [The machine
	    	       	   		  talks: 'I just got placed in ', self name];
	go: #run     to: #run if: [The machine batteryLife > 1]
	    	     	 	 then: [The machine discharges; talks: ('battery: ', batteryLife s)];
	go: #run     to: #endF  if: [batteryLife <= 1]
		    	     	 	then: [The machine talks: 'out of battery'.
					      The yourself oo.
					      The state oo.
					      The next oo.
					      The machine oo.
					      The factory oo.].
!

discharges
    batteryLife := batteryLife - (frequency / 5).
    frequency := frequency sqrt.
    self calcRange.
!

calcRange
    range := range - frequency.
!!

"--------------------------------"
! Sensor methodsFor: 'accessing' !

range
    ^range.
!

batteryLife
    ^batteryLife.
!

frequency
    ^frequency.
!!


"--------------------------------"
! Sensor methodsFor: 'printing' !
talks: x
       ('Sensor:[', id s, '] ', x s) oo.
!!