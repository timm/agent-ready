!FactoryLogger class methodsFor: 'creation'!
new
	^super new init.
!!
!FactoryLogger methodsFor: 'creation'!
init
	logger := OrderedCollection new.
	optlist := OrderedCollection new.
	bestDic := OrderedCollection new.
	restDic := OrderedCollection new.
	trans   := OrderedCollection new.
!!
!FactoryLogger methodsFor: 'storing'!
log: aKey value: aValue
	|pvalue|
	pvalue := OrderedCollection new.
	pvalue add: aKey.
	pvalue add: aValue.
	logger add: pvalue.
!
sort
	|tempCollection|
	tempCollection := logger asSortedCollection sortBlock:[:a :b| (a at: 1) < (b at: 1)].
	^tempCollection.
!
rest 
	self rest: 0.8.
!
best  
	self best: 0.8.
!
rest: alpha
	|psc restsize|
	restsize := (alpha * (logger size)) floor.
	psc := self sort.
	1 to: restsize do: [:i|
		restDic add: (psc at: i)].
!
best: alpha
	|psc restsize|
	(restDic isEmpty) ifTrue: [self rest: alpha].
	psc := self sort.
	restsize := ((alpha * (logger size)) floor)+1.	
	restsize to: (psc size) do:[:i|
		bestDic add: (psc at: i)].
!
settrans: atrans
	atrans do: [:each | trans add: each].
!!

!FactoryLogger methodsFor: 'accessing'!
logger
	^logger.  
!
bestDic
	^bestDic.
!
restDic 
	^restDic.
!
trans
	^trans.
!!

