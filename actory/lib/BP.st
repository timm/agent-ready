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
! BP methodsFor: 'accessing' !
taskhelp
	^taskhelp
!!
