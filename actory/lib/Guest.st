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
    	go: #waiting	to: #atceremony	if: [(The factory time > 0) & ((The factory tasks at: 'ceremony') timetocompletion = 0)]
    					then: [The machine atceremonyfor: (The factory tasks at: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecor	then: [The machine seesdecor: (The factory tasks at: 'decoration') cost];
    	
    	
!!

"============================================"
! Guest methodsFor: 'creation' !
init
	happiness := 10000
!!

"============================================"
! Guest methodsFor: 'operations' !
has: portions
	happiness := happiness*portions/
!
seesoptions: foodoptions
	happiness := happiness*options
!
seesdecor: decorcost
	happiness := happiness+ (happiness*decorcost/The factory budget)
!
atceremonyfor: time
	happiness := happiness-happiness*(time/The factory ceremonytime)
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


