! Sensor class methodsFor: 'creation'!
new: name
      ^(super new: name) init.
!!

"--------------------------------"
! Sensor methodsFor: 'creation' !

init
    range :=  2 + (App random next * 2) asInteger. 
    batteryLife := 100.
    "self worksIn: container."
    ('****Initial values are:   *****')oo.
    ('name= ', name s)oo.
    ('range= ', range s)oo.
    ('batteryLife= ',batteryLife s)oo.
!!

"----------------------------------"
! Sensor methodsFor: 'operations' !

worksIn: building
    building sensor: self;
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
    batteryLife := batteryLife - range.
    range := range raisedTo: 0.98.
!!

"--------------------------------"
! Sensor methodsFor: 'accessing' !

range
    ^range rounded.
!

batteryLife
    ^batteryLife rounded.
!!


"--------------------------------"
! Sensor methodsFor: 'printing' !
talks: x
       ('Sensor:[', id s, '] ', x s) oo.
!!