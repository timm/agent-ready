! Food class methodsFor: 'creation" !
new: foodoption
	^(super new: foodoption) init 
!!

"============================================"
! Food  methodsFor: 'creation' !
init
	options := 0.
!!

"============================================"
! Food  methodsFor: 'accessing' !
options
	^options
!!

"============================================"
! Food  methodsFor: 'setting' !
options: o
	options := o.
!!

