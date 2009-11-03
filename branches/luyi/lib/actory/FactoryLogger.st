!FactoryLogger class methodsFor: 'creation'!
new
	^super new init.
!!
!FactoryLogger methodsFor: 'creation'!
init
	logger := Dictionary new.
	optlist := OrderedCollection new.
	bestDic := Dictionary new.
	restDic := Dictionary new.
	trans   := OrderedCollection new.
!!
!FactoryLogger methodsFor: 'storing'!
log: aKey value: aValue
	|pvalue|
	logger at: aKey 
		ifAbsent: [ logger at: aKey put: (OrderedCollection new).].
	pvalue := logger at: aKey.
	pvalue add: aValue.
	logger at: aKey put: pvalue.
!
rest
	|psc restsize|
	restsize := (0.8 * (logger size)) rounded.
	psc := logger keys asSortedCollection.
	1 to: restsize do: [:i|
		restDic at: (psc at:i) put: (logger at: (psc at: i))].
	restDic.
!
best
	|psc|
	(restDic isEmpty) ifTrue: [self rest].
	psc := logger.
	bestDic := psc removeAllKeys: (restDic keys).
	bestDic.
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

