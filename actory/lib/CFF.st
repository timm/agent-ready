! CFF class methodsFor: 'creation' !
new: name
	^(super new: name) initcff
!
worksIn: factory
    factory 
    	machine: (self new: 'CFF');
    	"===============Guest Transitions==============="
    	go: #start	to: #waitingI	then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	go: #waitingI	to: #waitingI	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	"=============Close Friends/Family Transitions=============="
    	go: #waitingB	to: #waitingB	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingI	to: #waitingB	if: [(The factory time > 0) & (App random next > 0.15) ]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingB	to: #waitingI	if: [(The factory time > 0) & (App random next < 0.15) ]
    					then: [The machine talks: 'waiting for the ceremony, I can help now'];
    	go: #waitingI	to: #endF	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingB	to: #endF	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingI	to: #helpingB	if: [(The factory peopleNeedHelp size) > 0]
    					then: [The machine talks: 'helping out with',(The machine taskhelp).
    						The machine helps: (The factory peopleNeedHelp last).
    						The factory peopleNeedHelp addFirst: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp removeLast.];
    	go: #helpingB	to: #waitingI 	if: [(The factory task: (The machine taskhelp)) peopleNum = 1]
    					then: [The machine donehelping; talks: 'Back to waiting'];
    	go: #waitingB	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion < 1)]
    					then: [The machine atceremonyfor: (The factory task: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	"=============Guest Transitions================"
    	go: #waitingI	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion < 1)]
    					then: [The machine atceremonyfor: (The factory task: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecorH	if: [(The factory task: 'decoration') timetocompletion < 1]
    						then: [The machine seesdecor: (The factory task: 'decoration') cost];
    	go: #atceremony	to: #atreception	if: [(The factory task: 'decoration') timetocompletion > 0]
    						then: [The machine talks: 'at the reception'];
    	go: #noticesdecorH	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptionsH	then: [The machine seesoptions: (The factory task: 'food') options; talks: 'checking options'];
    	go: #checksoptionsH	to: #eatingH		then: [The machine eats: (The factory task: 'food') portions; talks: 'having something to eat'];
    	go: #eatingH 		to: #endF	then: [The factory judgingwedding: The machine happiness].
    	"================================================"
!!

"============================================"
! CFF methodsFor: 'creation' !
initcff
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
	(The factory task: tname) moreWorkers
!
donehelping
	taskhelp := ''
!!
