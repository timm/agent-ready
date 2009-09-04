|mill running waiting machine|

mill := Mill new.
machine := Machine new: mill.
waiting := #waiting state.
running := #running state.


machine add:
	 (Transition new
			state: #start state;
			then: ['i am staring ' oo];
			next: waiting).
mill add: machine.
mill do:  [:machine| 1 oo. machine transitions oo].
!
