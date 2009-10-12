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
	taskhelp := 0
!!

"============================================"
! CFF methodsFor: 'accessing' !
taskhelp
	^taskhelp
!!

"============================================"
! CFF methodsFor: 'setting' !
needhelp
	taskhelp := 1;
!
thanks4help
	taskhelp := 0;
!!
