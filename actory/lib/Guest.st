! Guest class methodsFor: 'creation' !
new: name
	^(super new: name) initguest
!
worksIn: factory
    factory 
    	machine: (self new: 'guest');
    	"===============Guest Transitions==============="
    	go: #start	to: #waitingI	then: [The machine talks: 'waiting for the ceremony'];
    	go: #waitingI	to: #waitingI	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony'];
    	go: #waitingI	to: #endF	if: [(The factory time < 1) & ((The factory tasksDic at: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingI	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion < 1)]
    					then: [The machine atceremonyfor: (The factory tasksDic at: 'ceremony') length;
    						talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecorH	if: [(The factory task: 'decoration') timetocompletion < 1]
    						then: [The machine seesdecor: (The factory task: 'decoration') cost];
    	go: #noticesdecorH	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atceremony	to: #atreception	if: [(The factory task: 'decoration') timetocompletion > 0]
    						then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptionsH	then: [The machine seesoptions: (The factory task: 'food') options; talks: 'checking options'];
    	go: #checksoptionsH	to: #eatingH		then: [The machine eats: (The factory task: 'food') portions; talks: 'having something to eat'];
    	go: #eatingH 		to: #endF	then: [The factory judgingwedding: The machine happiness].
    	"================================================"
!!

"============================================"
! Guest methodsFor: 'creation' !
initguest
	happiness := 10000
!!

"============================================"
! Guest methodsFor: 'operations' !
eats: portions
	happiness := happiness * portions / The factory guests
!
seesoptions: foodoptions
	happiness := happiness * foodoptions
!
seesdecor: decorcost
	happiness := happiness + (happiness * decorcost / The factory budget)
!
atceremonyfor: time
	happiness := happiness - time
!
notHappy
	happiness := 0
!
happiness: h
	happiness := h
!!

"============================================"
! Guest methodsFor: 'printing' !
talks: x
	App say: ('Machine:[', id s, '] ', x s)
!!

"============================================"
! Guest methodsFor: 'accessing' !
happiness
	^happiness
!!


