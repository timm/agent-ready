! BP class methodsFor: 'creation'
new: name
	^(super new: name)
!
worksIn: factory
    factory 
    	machine: (self new: 'BP');
    	go: #start	to: #s
!!

"============================================"
! BP methodsFor: 'creation' !
init
	taskname := ''.
	needhelp := false
!!

"============================================"
! BP methodsFor: 'accessing' !
taskname
	^taskname
!
needhelp
	^needhelp
!!

"============================================"
! BP methodsFor: 'setting' !
pleasehelp
	needhelp := true;
!
nomorehelp
	needhelp := false;
!
thanks4help
	|tname|
	tname = self taskname.
	(The factory tasks at:tname) releaseWorkers
!!
