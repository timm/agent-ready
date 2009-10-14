! POB class methodsFor: 'creation' !
new: name
	^(super new: name) initpob
!
worksIn: factory
    factory 
    	machine: (self new: 'POB');
    	go: #start	to: #endF.
!!

"============================================"
! POB methodsFor: 'creation' !
initpob
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
	super happiness: (super happiness - m).
	The factory payfrombudget: m.
	(The factory budget < 0)
		ifTrue: [happiness := happiness - m]
!!
