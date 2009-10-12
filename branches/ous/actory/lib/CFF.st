! CFF class methodsFor: 'creation'
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
    	machine: (self new: 'CFF');
    	go: #start	to: #
!!

"============================================"
! CFF methodsFor: 'creation' !
init
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
	(The factory tasks at:tname) moreWorkers
!
donehelping
	taskhelp := '';
!!
