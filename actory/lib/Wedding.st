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
	totalhappiness := 0.
	bp := 0.
	cff := 0.
	guests := 0.
	time := 0.
	budget := 0.
	tasksNeedHelp := OrderedCollection new.
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
totalhappiness
	^totalhappiness
!
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
tasksNeedHelp
	^tasksNeedHelp
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
someoneNeedsHelpWith: aTaskname
	tasksNeedHelp addFirst: aTaskname
!
nolongerNeedsHelpWith: aTaskname
	tasksNeedHelp remove: aTaskname ifAbsent:['did not need help' oo]
!!

"============================================"
! Wedding methodsFor: 'operations' !
finalrating
	('Total happiness is:', totalhappiness printString) noo
!
judgingwedding: j
	totalhappiness := totalhappiness + j
!
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
		(self tasksDic at: tname) workdone.
		App say: (tname,' needs ', ((self tasksDic at: tname) timetocompletion) printString, ' at wedding time ', (self time) printString)]
!!
