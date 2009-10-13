! CFF class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'CFF');
    	go: #start	to: #waitingI	then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	go: #waitingI	to: #waitingI	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	go: #waitingI	to: #waitingB	if: [(The factory time > 0) & (App random next > 0.15) ]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingI	to: #endF	if: [(The factory time < 1) & ((The factory tasks at: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingB	to: #endF	if: [(The factory time < 1) & ((The factory tasks at: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingI	to: #helpingB	if: [(The factory peopleNeedHelp size) > 0]
    					then: [self helps: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp addFirst: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp removeLast];    	
    	go: #helpingB	to: #waitingB;
    	go: #waitingB	to: #atceremony	if: [(The factory time < 1) & ((The factory tasks at: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory tasks at: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #waitingI	to: #atceremony	if: [(The factory time < 1) & ((The factory tasks at: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory tasks at: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecorH	then: [The machine seesdecor: (The factory tasks at: 'decoration') cost];
    	go: #noticesdecorH	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptionsH	then: [The machine seesoptions: (The factory tasks at: 'food') options; talks: 'checking options'];
    	go: #checksoptionsH	to: #eatingH		then: [The machine eats: (The factory tasks at: 'food') portions; talks: 'having something to eat'];
    	go: #eatingH 		to: #endF.
!!

"============================================"
! CFF methodsFor: 'creation' !
init
	taskhelp := ''
!!

"============================================"
! CFF methodsFor: 'accessing' !
taskhelp
	^taskhelp
!!

"============================================"
! CFF methodsFor: 'operations' !
helps: person
	|tname|
	tname = person taskname.
	taskhelp := tname.
	(The factory tasks at:tname) moreWorkers
!
donehelping
	taskhelp := ''
!!
