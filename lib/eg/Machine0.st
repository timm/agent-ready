|machines running waiting machine|

machines := Machines new.
machine := Machine new.
waiting := #waiting state.
running := #running state.

machine 
	add: (Transition new
			state: #start state;
			then: ['i am staring ' oo];
			next: waiting).

machines add: machine.
"
machine transitions do: [:cycle| 
	cycle do: [:t| 
		t oo]]"
!
