! POG class methodsFor: 'creation'
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'POG');
    	go: #start	to: #s
!!

"============================================"
! POG methodsFor: 'creation' !
init
	money := 0
!!

"============================================"
! POG methodsFor: 'accessing' !
money
	^money
!!

"============================================"
! POG methodsFor: 'setting' !
givemoney: m
	money := money - m.
	happiness := happiness - m.
	The factory payfrombudget: m.
	if: [The factory budget < 0]
	then: [happiness := happiness - m]
!!
