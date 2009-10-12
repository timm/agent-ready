! POB class methodsFor: 'creation'
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'POB');
    	go: #start	to: #s
!!

"============================================"
! POB methodsFor: 'creation' !
init
	money := 0
!!

"============================================"
! POB methodsFor: 'accessing' !
money
	^money
!!

"============================================"
! POB methodsFor: 'setting' !
givemoney: m
	money := money - m.
	happiness := happiness - m.
	The factory payfrombudget: m.
	if: [The factory budget < 0]
	then: [happiness := happiness - m]
!!
