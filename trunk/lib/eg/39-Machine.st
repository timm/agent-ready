|waiting machine|

machine := Machine new.
waiting := #waiting state.
running := #running state.

machine
	add: (Transition new
			state: waiting;
			then: ['i am waiting ' oo];
			next: waiting)

"
	add: (Transition new
			state: waiting;
			if:    [App random next > 0.8]);
	add: (Transition new
			staysAt: running;
			then:  ['going to the pool' oo]);
	add: (Transition new
			staysAt: running;
			then:  ['going to the shop' oo]);
	add: (Transition new
			staysAt: running;
			then:  ['going to the store' oo]);
	add: (Transition new
			state: running;
			then: ['going home to sleep. Nite!' oo];
			next: #end endState);
	add: (Transition new
			state: #start state;
			then: ['i am staring ' oo];
			next: waiting).
"
machine oo.
"mill add: machine.
mill do:  [:stagger| stagger oo].
"

!
