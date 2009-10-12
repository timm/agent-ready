! Guest class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'guest');
    	go: #start	to: #waiting	then: [The machine talks: 'waiting for the ceremony'];
    	go: #waiting	to: #waiting	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony'];
    	go: #waiting	to: #endF	if: [(The factory time < 1) & ((The factory tasks at: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waiting	to: #atceremony	if: [(The factory time < 1) & ((The factory tasks at: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory tasks at: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecor	then: [The machine seesdecor: (The factory tasks at: 'decoration') cost];
    	go: #noticesdecor	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptions	then: [The machine seesoptions: (The factory tasks at: 'food') options; talks: 'checking options'];
    	go: #checksoptions	to: #eating		then: [The machine eats: (The factory tasks at: 'food') portions; talks: 'having something to eat'];
    	go: #eating 		to: #endF.
!!

"============================================"
! Guest methodsFor: 'creation' !
init
	happiness := 10000
!!

"============================================"
! Guest methodsFor: 'operations' !
eats: portions
	happiness := happiness*portions/The factory guests
!
seesoptions: foodoptions
	happiness := happiness*options
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


