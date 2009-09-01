! Stagger class methods !
new
	^super new init: OrderedCollection new.
!
new: list
	^super new init: list 
!!
! Stagger methods !
contents
	^contents
!
add: item
	contents add: item
!
init: aList 
	contents := aList asOrderedCollection.
	contents shuffle.
 	pointer := 1	
!
do: aBlock
	contents size timesRepeat: [ 
		aBlock value: self next ].
!
once: aBlock
	aBlock value: self next.
!
next
	|tmp|
	(pointer >= contents size) 
		ifTrue: [ self reset ].
	tmp := contents at: pointer.
	pointer := pointer + 1.
	^tmp
!
reset
	pointer := 1.
	contents shuffle.
!!
