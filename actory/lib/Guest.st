! Guest class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'guest');
    	go: #start	to: #waitingI	then: [The machine talks: 'waiting for the ceremony'];
    	go: #waitingI	to: #waitingI	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony'];
    	go: #waitingI	to: #endF	if: [(The factory time < 1) & ((The factory tasksDic at: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingI	to: #atceremony	if: [(The factory time < 1) & ((The factory tasksDic at: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory tasksDic at: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecorH	then: [The machine seesdecor: (The factory tasksDic at: 'decoration') cost];
    	go: #noticesdecorH	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptionsH	then: [The machine seesoptions: (The factory tasksDic at: 'food') options; talks: 'checking options'];
    	go: #checksoptionsH	to: #eatingH		then: [The machine eats: (The factory tasksDic at: 'food') portions; talks: 'having something to eat'];
    	go: #eatingH 		to: #endF	then: ['The final happiness is :' oo. ].
!!

"============================================"
! Guest methodsFor: 'creation' !
init
	happiness := 10000.
	(self happiness) noo
!!

"============================================"
! Guest methodsFor: 'operations' !
eats: portions
	happiness := happiness*portions/The factory guests
!
seesoptions: foodoptions
	happiness := happiness*foodoptions
!
seesdecor: decorcost
	happiness := happiness+ (happiness*decorcost/The factory budget)
!
atceremonyfor: time
	happiness := happiness-time
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
	('Machine:[', id s, '] ', x s)o
!!

"============================================"
! Guest methodsFor: 'accessing' !
happiness
	^happiness
!!


