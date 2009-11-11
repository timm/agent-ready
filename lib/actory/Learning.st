!Learning class methodsFor: 'creation'!
new: aflogger 
	^super new init:aflogger.
!!
!Learning methodsFor: 'creation'!
init: aflogger
	ptable := Dictionary new.
	runstable := Dictionary new.
	phsum :=0.
	transDic := Dictionary new.
	flogger :=aflogger.
	biasedcourseTrans := OrderedCollection new.
	biasedlifeTrans   := OrderedCollection new.

!
reset
	self init: flogger.
!
constransdic
	flogger trans do: [:each|transDic at: (each id) put: each.].
!
resultmatrix
	runstable keysAndValuesDo: [:key :value|
        |pvalue|
        'runs: ' o. key o. ' ' o.
        pvalue := value.
        (pvalue values ) asOrderedCollection o.
        ' with happiness '  o.
        (ptable at: key )oo.
        phsum := phsum+ (ptable at:key).
        ].
!
average
	^((phsum/(runstable size)) floor) .
!
findbestTrans
	self findbestTrans: 0.8.
!
findbestTrans: alpha
	|brvector pfre bestfre bestfreDict restfreDict itemno|
	pfre := Dictionary new.
	1 to: ((flogger trans) size) do:[:i|
        |id counts|
        id:= (flogger trans at: i) id.
        counts := 0.
        (runstable values) do: [:value|
        ((value at: id ) = 0 )
                ifFalse: [counts := counts + 1].
        ].
        pfre at: id put: counts.
        ].

	bestfre := Dictionary new.
	itemno := 0.
	flogger bestDic do:[:item|
                |itembag|
                itemno := itemno +1.
                itembag := Bag new.
                'happiness is ' o.
                (item at:1) oo.
                (item at: 2) do: [:pitem|
                pitem contents keys do:[:key|
                (transDic includesKey: (key id))
                ifTrue: [
                (key id) o.
                itembag add: (key id).
                ' ' o.
                ].].].
                bestfre at: itemno put: (itembag asSortedCollection).
                ' ' oo.].
	
	bestfreDict := Dictionary new.
	1 to: ((flogger trans) size) do:[:i|
        	|id counts|
        	id:= ((flogger trans) at: i) id.
        	counts := 0.
        	bestfre values do: [:value|
        	(value includes: id)
        	ifTrue: [
                	counts:= counts+1.
                	].
        	].
        bestfreDict at: id put: counts.
        ]. 
	restfreDict := Dictionary new.

	pfre keysAndValuesDo: [:key :value|
        restfreDict at: key put: ((pfre at: key)- (bestfreDict at:key))].
	brvector := Dictionary new.
	pfre keysAndValuesDo: [:key :value|
        |likeB likeR|
        likeB := ((bestfreDict at: key)/(flogger bestDic size)) * (1-alpha).
        likeR := ((restfreDict at: key)/(flogger restDic size)) * alpha.
        brvector at: key put: (likeB* likeB)/(likeB + likeR).
        ((likeB = 0) & (likeR = 0))
        ifTrue: [brvector at: key put: 0]. ].
	brvector oo.

	brvector keysAndValuesDo: [:key :value|
        |tran|
        (value > 0)
        ifTrue: [
        tran := (transDic at: key).
        ((tran state name) ~ 'Course' )
                ifTrue: [ biasedcourseTrans add: tran.].
        ((tran state name ) ~ 'Life' )
                ifTrue: [ biasedlifeTrans add: tran. ].
        ].
        ].
!!
!Learning methodsFor: 'accessing'!
biasedcourseTrans
	^biasedcourseTrans.
!
biasedlifeTrans
	^biasedlifeTrans.
!
ptable
	^ptable.
!
runstable 
	^runstable.
!
transDic
	^transDic.
!
ptable: aPtable
	ptable:= aPtable.
!
runstable: aRunstable
	runstable := aRunstable.
!!



