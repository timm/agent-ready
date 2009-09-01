! Machines class methods !
all
	All ifNil: [All := Stagger new].
	^All
!
id
	Ids ifNil: [Ids := 0].
	^Ids := Ids + 1.
!
! Machines methods !
time
	^time
!
add: machine
	self class all add: machine
!
do: aBlock
	self class all contents size oo.
	self class all do: [:machine| aBlock value: machine]
!
walks
	| steps |
	steps := 0.
	self do: [:machine| machine current onEntry].
	self do: [:machine|
		machine steps 
			ifTrue: [steps := steps + 1.
					 Asynchronousp 
					  	ifTrue: [^true]]
	].
	^steps > 0
!
runs
	time := 1.
	[self walks] whileTrue: [time := time + 1].
!!
