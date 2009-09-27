! Republican class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
       machine: (self new: 'A Republicanic senator');
       go: #start   to: #run     then:  [The machine talks: 0];
       go: #run     to: #oddHaHa then:  [The machine talks: 1];
       go: #run     to: #even    then:  [The machine talks: 2];
       go: #oddHaHa to: #oddHaHa then:  [The machine 
                                            naughty; 
                                            talks: 3];
       go: #oddHaHa to: #run     if:    [The machine scandals < 2 ] 
                                 then:  [The machine 
                                            talks: 4;
                                            talks: 'caught in the airport bathroom with Pepe.'];
       go: #even    to: #run;
       go: #run     to: #endF    if:    [App random next > 0.9] 
                                 then:  [The machine 
                                            talks: 5;
                                            talks: 'that is all folks'.
                                         The yourself oo.
                                         The state oo.
                                         The next oo.
                                         The machine oo.
                                         The factory oo].
!!

"============================================"
! Republican methodsFor: 'creation' !
init
    scandals := 0.
    caughtLikelihood := 0.
    comittee := ((App random next)*16). 
!!

"============================================"
! Republican methodsFor: 'operations' !
naughty
    scandals := scandals+1.
    caughtLikelihood := caughtLikelihood+(caughtLikelihood sqrt).
!
scandals
    ^scandals
!
caughtLikelihood
    ^caughtLikelihood
!
comittee
    ^comittee
!!
"============================================"
! Republican methodsFor: 'printing' !
talks: x
    ('Machine:[', id s, '] ', x s)o
!!
