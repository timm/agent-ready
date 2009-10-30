!StaggerLogger class methodsFor: 'creation'!
new: aStagger
	^super new init: aStagger.
!!
!StaggerLogger methodsFor: 'creation'!
init: aStagger
	logger := Dictionary new.
	counter := Dictionary new.
	stagger := aStagger.
!
stagger: aStagger
	(stagger isNil)
		ifTrue: [stagger := aStagger.
			^true]
		ifFalse: [^false].
!!
!StaggerLogger methodsFor: 'storing'!
register: item
"item is a tranistion, logger use its id as key and itself as very and init counter "
	logger at: (item id) put: item.
	counter at: (item id) put: 0.
!
log: candidate 
"Candidate here is a transition"
	|id counterno|
	(stagger isNil)
		ifTrue: [
		id := candidate id.
		counter at: id put: ((counter at: id)+1).  
		]
!!
!StaggerLogger methodsFor: 'accessing'!
logger
	^logger
!
counter 
	^counter.
!!

