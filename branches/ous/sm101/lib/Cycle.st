! Cycle class methods !
new: list
	^super new init: list on: self randomNumberGenerator.
!
randomNumberGenerator
	^Random the
!
new: list on: rand
	^super new init: list on: rand
!!
! Cycle methods !
add: item
	list add: item
!
init: aList on: r
	rand := r.
	list := aList.
	list shuffle: r.
 	pointer := 1	
!
do: aBlock
	list size timesRepeat: [ 
		aBlock value: self next ].
!
once: aBlock
	aBlock value: self next.
!
next
	|tmp|
	(pointer >= self size) ifTrue: [
		pointer := 1.
		list shuffle: rand.
	].
	tmp := list at: pointer.
	pointer := pointer + 1.
	^tmp
!!
