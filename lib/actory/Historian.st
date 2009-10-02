! Historian class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory historian: (self new: 'historian').
    'This session is being recorded.' oo.
!!

"============================================"
! Historian methodsFor: 'creation' !
init
	log:=Dictionary new.
!!

"============================================"
! Historian methodsFor: 'operations' !
record: what
    ^true
!!

"============================================"
! Historian methodsFor: 'accessing'!
log
	^log
!!
"============================================"
! Historian methodsFor: 'printing' !
talks: x
    ('Historian:[', id s, '] ', x s)o
!!
