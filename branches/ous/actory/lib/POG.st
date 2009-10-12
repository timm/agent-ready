! POG class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'POG');
    	go: #start	to: #endF.
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
	super happiness: (super happiness - m).
	The factory payfrombudget: m.
	(The factory budget < 0)
		ifTrue: [happiness := happiness - m]
!!
