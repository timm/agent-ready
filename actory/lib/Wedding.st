! Wedding class methodsFor: 'creation' !
new
	self error: 'should not create Weddings without nameStrings'
!
new: nameString
	^(super new: nameString) initwedding
!!

"============================================"
! Wedding  methodsFor: 'creation' !
initwedding
	bp := 0.
	cff := 0.
	guests := 0.
	time := 0.
	budget := 0.
	peopleNeedHelp := OrderedCollection new.
	receptionOP := OrderedCollection new.
	decorationOP := OrderedCollection new.
	ceremonyOP := OrderedCollection new.
	foodOP := OrderedCollection new.
	refoodOP := OrderedCollection new.
	reception := Task new: 'reception'.
	decoration := Task new: 'decoration'.
	ceremony := Ceremony new: 'ceremony'.
	food := Food new: 'food'.
	refood := Food new: 'refood'.
	tasksDic := Dictionary new.
	self addtasks: reception.
	self addtasks: decoration.
	self addtasks: ceremony.
	self addtasks: food.
	self addtasks: refood.
!!

"============================================"
! Wedding methodsFor: 'accessing' !
bp
	^bp
!
cff
	^cff
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
task: taskname
	^tasksDic at: taskname
!
bp: s
	bp:= s
!
cff: c
	cff := c
!
guests: g
	guests := g
!
gettasks: atask
	^tasksDic at: (atask name)
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
step
	| more |
	App tick.
	self tock.
	more := false.
	self do: [:machine|
	  machine step 
		ifTrue: [
			more := true.
            Asynchronousp 
		   	   ifTrue: [^true]]].
	^more
!
tock
	time := time - 1.
	tasksDic keysDo: [:tname|
		(self tasksDic at: tname) workdone]
!!
