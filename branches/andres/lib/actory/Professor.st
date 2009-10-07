! Professor class methodsFor: 'creation'!
new: name
     ^(super new: name) init
!

worksIn: factory
	 factory machine: (self new: 'Professor');
		go: #start   to: #run	then: [The machine
		    	     	 	      	  eats;
		    	       	   		  talks: 'I just woke up.'];
	        go: #run     to: #hungry if: [The machine hunger > 10]
		    	     	 	 then: [The machine talks: 'I am hungry, gotta eat.'];
		go: #hungry  to: #hungry then: [The machine eats.];
		go: #hungry  to: #run    if: [The machine hunger < 1]
		    	     	 	 then: [The machine talks: 'I am full and ready'];
		go: #run     to: #teach	then: [The machine talks: 'going to teach.';
		    	     	 	      	   	  startsClass.];
		go: #teach   to: #teach then: [The machine teaches; talks: 'teaching.'];
	        go: #teach   to: #run   if: [The machine taught > 2]
		    	     	 	then: [The machine talks: 'See you next week.'];
		go: #run     to: #run   if: [The machine exhaustion > 5]
		    	     	 	then: [The machine naps.];
		go: #run     to: #endF  if: [App random next > 0.9]
		    	     	 	then: [The machine talks: 'Going to sleep'.
					      The yourself oo.
					      The state oo.
					      The next oo.
					      The machine oo.
					      The factory oo.].
!!

"--------------------------------"
! Professor methodsFor: 'creation' !
init
    hunger := (App random next * 10 rounded) asInteger.
    exhaustion := (App random next * 10 rounded) asInteger.
    taught := (App random next * 10 rounded) asInteger.
    ('Initial values are: hunger=', hunger s,' exhaustion=',exhaustion s,'taught=',taught s)oo.
!!

"----------------------------------"
! Professor methodsFor: 'operations' !
eats
    hunger := hunger - 2.
!

naps
    exhaustion := 0.
    hunger := hunger + 1
!

startsClass
    taught := 0.
!

teaches
    hunger := hunger + 1.
    exhaustion := exhaustion + 1.
    taught := taught + 1.
!

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
       ('Machine:[', id s, '] ', x s) oo.
!!