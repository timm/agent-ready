!StaggerLogger class methodsFor: 'creation'!
new: aStagger
	^super new init: aStagger.
!!
!StaggerLogger methodsFor: 'creation'!
init: aStagger
	logger := Dictionary new.
	counter := Bag new.
	learner := Dictionary new.
	stagger := aStagger.
	firelist := OrderedCollection new.
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
!
log: candidate 
"Candidate here is a transition"
	counter add: candidate. 
!!
!StaggerLogger methodsFor: 'accessing'!
logger
	^logger
!
counter 
	^counter.
!
learner
	^learner.
!
firelist 
	^firelist.
!!
!StaggerLogger methodsFor: 'learning'!
analyze
	|plist|
	plist := counter sortedByCount.
	plist keysAndValuesDo: [:key |
		firelist add: key.]
!
optlist
	^firelist.	
!
optlist: aNumber
	|templist|
	templist := OrderedCollection new.
	((firelist size) > aNumber) 
		ifTrue: [
			 1 to: aNumber do:[:i | 
			templist add: (firelist at: i).].
			^templist.
			]
		ifFalse: [^firelist].
!!
!StaggerLogger methodsFor: 'reset'!
resetlogger
	logger := Dictionary new.
!
resetcounter
	counter := Bag new.
!
resetlearner
	learner := Dictionary new.
!!
