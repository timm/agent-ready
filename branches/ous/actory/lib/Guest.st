! Guest class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'guest');
    	go: #start	to: #run	then: [The machine talks: 'waiting for the ceremony'];
    	go: #run	to: #atceremony	if: [(The factory tasks at: 'ceremony') timestart < (The factory time)+1 ]
    					then: [The machine atceremonyfor: 
!!

"============================================"
! Guest methodsFor: 'creation' !
init
	happiness := 10000
!!

"============================================"
! Guest methodsFor: 'operations' !
has: portions
	happiness := happiness*portions
!
seesoptions: foodoptions
	happiness := happiness*options
!
seedecor: decorcost
	happiness := happiness*decorcost
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


