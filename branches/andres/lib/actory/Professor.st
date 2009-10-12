! Professor class methodsFor: 'creation'!
new: name
      ^(super new: name) init
!!

"--------------------------------"
! Professor methodsFor: 'creation' !

init
    hunger := (App random next * 10 rounded) asInteger.
    exhaustion := (App random next * 10 rounded) asInteger.
    taught := (App random next * 10 rounded) asInteger.
    ('****Initial values are:   *****')oo.
    ('name= ', name s)oo.
    ('hunger= ', hunger s)oo.
    ('exhaustion= ',exhaustion s)oo.
    ('taught= ',taught s)oo.
!!

"----------------------------------"
! Professor methodsFor: 'operations' !

worksIn: building
    building professor: self;
	go: #start   to: #run	then: [The machine
	    	     	 	      	  entersBuilding;
	    	       	   		  talks: 'I just entered the building'];
	go: #run     to: #hungry if: [The machine hunger > 10]
	    	     	 	 then: [The machine talks: 'I am hungry, gotta eat.'];
	go: #hungry  to: #hungry then: [The machine eats.];
	go: #hungry  to: #run    if: [The machine hunger < 1]
	   	     	 	 then: [The machine talks: 'I am full and ready'];
	go: #run     to: #teach	 then: [The machine talks: 'going to teach.';
	    	     	 	      	   startsClass.];
	go: #teach   to: #teach then: [The machine teaches; talks: 'teaching.'];
	go: #teach   to: #run   if: [The machine taught > 2]
		    	      	then: [The machine talks: 'See you next week.'];
	go: #run     to: #run   if: [The machine exhaustion > 5]
		    	     	then: [The machine naps.];
	go: #run     to: #endF  if: [The machine exhaustion > 7]
		    	     	 	then: [The machine
					      	   leavesBuilding;
						   talks: 'Leaving the building'.
					      The yourself oo.
					      The state oo.
					      The next oo.
					      The machine oo.
					      The factory oo.
					      building logs oo.].
!

entersBuilding
    self factory professorIn: self name.
    self goToOffice.
!

leavesBuilding
   self factory professorOut: self name.
!

goToOffice
    ^true.
!

eats
    hunger := hunger - 2.
!

naps
    exhaustion := exhaustion - 2.
    hunger := hunger + 1
!

startsClass
    taught := 0.
!

teaches
    hunger := hunger + 1.
    exhaustion := exhaustion + 1.
    taught := taught + 1.
!!

"----------------------------------"
! Professor methodsFor: 'accessing' !

hunger
    ^hunger.
!

exhaustion
    ^exhaustion.
!

taught
    ^taught.
!!


"--------------------------------"
! Professor methodsFor: 'printing' !
talks: x
       ('Professor:[', name s, '] ', x s) oo.
!!