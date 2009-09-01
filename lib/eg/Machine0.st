|machines running waiting machine|

machines := Machines new.
machine := Machine new: machines.
waiting := #waiting state.
running := #running state.


machine add:
	 (Transition new
			state: #start state;
			then: ['i am staring ' oo];
			next: waiting).
machines add: machine.
machines do:  [:machine| 1 oo. machine transitions oo].
!
