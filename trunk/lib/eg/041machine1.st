|mill trans|

(mill := Mill new: 'city')
	newMachine: 'suburb';
	transition: (trans:= Transition new
					state: #waiting state;
					then: ['i am running ' oo];
					next: #running state).
trans oo.
trans state oo.
trans next oo.

mill do:  [:stagger| stagger oo].


!
