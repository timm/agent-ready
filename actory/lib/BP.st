! BP class methodsFor: 'creation' !
new: name
	^(super new: name) initbp
!
worksIn: factory
    factory 
    	machine: (self new: 'BP');
    	go: #start	to: #waitingI	then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	go: #waitingI	to: #waitingI	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	go: #waitingB	to: #waitingB	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingI	to: #waitingB	if: [(The factory time > 0) & (App random next > 0.5) ]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingB	to: #waitingI	if: [(The factory time > 0) & (App random next < 0.5) ]
    					then: [The machine talks: 'waiting for the ceremony, I can help now'];
    	go: #waitingI	to: #endF	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingB	to: #endF	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingI	to: #helpingB	if: [(The factory peopleNeedHelp size) > 0]
    					then: [The machine helps: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp addFirst: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp removeLast.
    						The machine talks: 'helping out'.];
    	go: #helpingB	to: #waitingI 	if: [(The factory task: (The machine taskhelp)) peopleNum = 1]
    					then: [The machine donehelping; talks: 'Back to waiting'];
    	go: #waitingB	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory task: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #waitingI	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory task: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecorH	then: [The machine seesdecor: (The factory task: 'decoration') cost];
    	go: #noticesdecorH	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptionsH	then: [The machine seesoptions: (The factory task: 'food') options; talks: 'checking options'];
    	go: #checksoptionsH	to: #eatingH		then: [The machine eats: (The factory task: 'food') portions; talks: 'having something to eat'];
    	go: #eatingH 		to: #endF.
!!

"============================================"
! BP methodsFor: 'creation' !
initbp
	taskname := ''.
	needhelp := false
!!

"============================================"
! BP methodsFor: 'accessing' !
taskname
	^taskname
!
needhelp
	^needhelp
!!

"============================================"
! BP methodsFor: 'setting' !
pleasehelp
	needhelp := true
!
nomorehelp
	needhelp := false
!
thanks4help
	|tname|
	tname = self taskname.
	(The factory tasks at:tname) releaseWorkers
!!
