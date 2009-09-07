! KillJoy class methods !
new: name
	^(super new: name) init
!
worksIn: factory
	factory 
       machine: (self new: 'party boy');
	   go: #start   to: #run     then:  [The machine talks: 0];
	   go: #run     to: #oddHaHa then:  [The machine talks: 1];
	   go: #run     to: #even    then:  [The machine talks: 2];
	   go: #oddHaHa to: #oddHaHa then:  [The machine 
                                            drinks; 
                                            talks: 3];
	   go: #oddHaHa to: #run     if:    [The machine happiness < 2 ] 
                                 then:  [The machine 
                                               talks: 4;
                                               talks: 'Too drunk to stay awake.'];
	   go: #even    to: #run;
	   go: #run     to: #endF    if:    [App random next > 0.5] 
							     then:  [The machine 
											talks: 5;
											talks: 'that is all folks'.
							             The yourself oo.
							             The state oo.
									     The next oo.
									     The machine oo.
									     The factory oo].
!!
! KillJoy methods !
drinks
	happiness := happiness sqrt
!
happiness
	^happiness
!
init
	happiness := 10
!
talks: x
	('Machine:[', id s, '] ', x s)o
!!
