! Food class methodsFor: 'creation' !
new: foodoption
	^(super new: foodoption) initfood 
!!

"============================================"
! Food  methodsFor: 'creation' !
initfood
	options := 0.
	portions := 0.
!!

"============================================"
! Food  methodsFor: 'accessing' !
options
	^options
!
portions
	^portions
!!

"============================================"
! Food  methodsFor: 'setting' !
options: o
	options := o.
!
portions: p
	portions := p.
!!

