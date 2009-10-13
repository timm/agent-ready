! Wedding class methodsFor: 'creation' !
new
	self error: 'should not create Weddings without nameStrings'
!
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
	peopleNeedHelp := Orderedcollection new.
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
	tasksDic := Dictionary new.
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
tasksDic
	^tasksDic
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
!
peopleNeedHelp
	^peopleNeedHelp
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
	reception := rec.
	self addtasks: reception
!
decoration: dec
	decoration := dec.
	self addtasks: decoration.
!
food: f
	food := f.
	self addtasks: food.
!
refood: ref
	refood := ref.
	self addtasks: refood.
!
ceremony: cer
	ceremony := cer.
	self addtasks: ceremony
!
someoneNeedshelp: aPerson
	peopleNeedHelp addFirst: aPerson
!
nolongerNeedsHelp: aPerson
	peopleNeedHelp remove: aPerson ifAbsent:[]
!!

"============================================"
! Wedding methodsFor: 'operations' !
payfrombudget: b
	budget := budget - b
!
addtasks: atask
	tasksDic at: (atask name) put: atask
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
