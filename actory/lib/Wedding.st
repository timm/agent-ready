! Wedding class methodsFor: 'creation' !
new: nameString
	^(super new: nameString) init
!!

"============================================"
! Wedding  methodsFor: 'creation' !
init
	bp := 0.
	guests := 0.
	time := 0.
	budget := 0.
	receptionOP := Orderedcollection new.
	decorationOP := Orderedcollection new.
	ceremonyOP := Orderedcollection new.
	foodOP := Orderedcollection new.
	refoodOP := Orderedcollection new.
	reception := Task new: 'reception'.
	decoration := Task new: 'decoration'.
	ceremony := Task new: 'ceremony'.
	food := Food new: 'food'.
	refood := Food new: 'rehersalfood'.
	tasks := Dictionary new.
!!

"============================================"
! Wedding methodsFor: 'accessing' !
bp
	^bp
!
guests
	^guests
!
time
	^time
!
budget
	^budget
!
tasks
	^tasks
!
receptionOP
	^receptionOP
!
decorationOP
	^decorationOP
!
ceremonyOP
	^ceremonyOP
!
foodOP
	^foodOP
!
refoodOP
	^refoodOP
!
reception
	^reception
!
decoration
	^decoration
!
food
	^food
!
refood
	^refood
!
ceremony
	^ceremony
!!

"============================================"
! Wedding methodsFor: 'setting' !
bp: s
	bp:= s
!
guests: g
	guests := g
!
time: t
	time := t
!
budget: b
	budget := b
!
reception: rec
	reception := rec
!
decoration: dec
	decoration := dec
!
food: f
	food := f
!
refood: ref
	refood := ref
!
ceremony: cer
	ceremony := cer
!!

"============================================"
! Wedding methodsFor: 'operations' !
payfrombudget: b
	budget := budget - b
!
addtasks: atask
	tasks at: (atask name) put: atask
!
addreceptionOP: option
	receptionOP addLast: option
!
adddecorationOP: option
	decorationOP addLast: option
!
addceremonyOP: option
	ceremonyOP addLast: option
!
addfoodOP: option
	foodOP addLast: option
!
addrefoodOP: option
	refoodOP addLast: option
!
tick
	super tick.
	time := time - 1
!!
