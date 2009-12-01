! PresidentKEYS class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory oracle: (self new: 'president').
    App say: 'The president is on the floor.'.
    'Oracle type: KEYS' oo.
!!

"============================================"
! PresidentKEYS methodsFor: 'creation' !
init
	(App random next > 0.5) ifTrue:[party:=0] ifFalse:[party:=1].
    	dsuccess:=0.
	rsuccess:=0.
	support:=SortedCollection new.
	basesums:=Dictionary new.
	3 to:10 do:[:x|
		basesums at:(x s) put:100.
	].
!
reset
	dsuccess:=0.
	rsuccess:=0.
	support:=SortedCollection new.
!!

"============================================"
! PresidentKEYS methodsFor: 'operations' !
learn
	|sum base best rest archives sessions biases scores|
	sessions:= The historian session-1.

	best:= (0.2*sessions asFloat) rounded.
	rest:= (0.8*sessions asFloat) rounded.

	archives:= (self classify: best).	
	scores:= (self scoreAttributes: archives with: best with: rest).
	The factory biases: (self getBiases: scores with:The factory era).
	The factory bases: (self getBases).

	The historian reportStats. 
	The historian reportBiases.
	The historian learnReset.
	The factory era:The factory era+1.
!
getBases
	|bases biases temp|
	bases:=The factory bases.
	biases:=The factory biases.

	3 to: 13 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'3').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	14 to: 24 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'4').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	25 to: 35 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'5').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	36 to: 42 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'6').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	43 to: 51 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'7').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	52 to: 58 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'8').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	59 to: 67 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'9').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].
	68 to: 76 do:[:x|
		temp:=bases at:(x s).
		temp:=temp*(basesums at:'10').
		temp:=(temp/100) asFloat rounded.
		bases at:(x s) put:temp.
		(biases includesKey:(x s)) ifTrue:[bases at:(x s) put:((biases at:(x s)) asInteger)].
	].

	^bases
!
getBiases: aCache with: aNumber
	|biases bscore bkey att val blacklist howMany|
	biases:=The factory biases.
	blacklist:= The factory blacklist.
	howMany:=aNumber asInteger.
	(howMany > (76-The factory biases size)) ifTrue:[howMany:=76-The factory biases size].

	howMany timesRepeat: [ 
		bscore:=0.
		aCache associationsDo:[:entry|
			att:=(entry key) copyFrom: 2 to: ((entry key) indexOf: $,)-1.
			(biases includesKey: att) ifFalse:[
				(blacklist includes: att) ifFalse:[
					(entry value > bscore) ifTrue:[
						bscore:=(entry value).
						bkey:=(entry key).
					].
				].
			].
		].
		att:=bkey copyFrom: 2 to: (bkey indexOf: $,)-1.
		val:=bkey copyFrom: (bkey indexOf: $,)+1 to: (bkey size).
		aCache removeKey: bkey. 
		biases at: (att s) put: val.
		
		att:=(att asInteger).
		(att<14) ifTrue:[basesums at:'3' put:((basesums at:'3')-(val asInteger))]
			ifFalse:[(att<25) ifTrue:[basesums at:'4' put:((basesums at:'4')-(val asInteger))]
				ifFalse:[(att<36) ifTrue:[basesums at:'5' put:((basesums at:'5')-(val asInteger))]
					ifFalse:[(att<43) ifTrue:[basesums at:'6' put:((basesums at:'6')-(val asInteger))]
						ifFalse:[(att<52) ifTrue:[basesums at:'7' put:((basesums at:'7')-(val asInteger))]
							ifFalse:[(att<59) ifTrue:[basesums at:'8' put:((basesums at:'8')-(val asInteger))]
								ifFalse:[(att<68) ifTrue:[basesums at:'9' put:((basesums at:'9')-(val asInteger))]
									ifFalse:[basesums at:'10' put:((basesums at:'10')-(val asInteger))].].].].].].].
	].
	
	^biases
!
scoreAttributes: aCollection with: best with: rest
	|scores att key value score sessions fBest fRest class|
	scores:= Dictionary new.
	sessions:=The historian session-1. 

	1 to: sessions do:[:row|
		1 to: 76 do:[:col|
			fBest:=0.
			fRest:=0.
			att:=('s',col s).
			value:=(aCollection at: row) at: att. 
			key:=(att s,',',value s).
			"Is the score already cached?"
			(scores includesKey: key) ifFalse:[
				1 to: sessions do:[:x|
					"Is the value the same?"
					(((aCollection at: x) at: att) = value) ifTrue:[
						class:=(aCollection at: x) at: 'class'.
						"Get frequency counts"
						(class='best') 
							ifTrue:[fBest:=fBest+1.]
							ifFalse:[fRest:=fRest+1.].
					].
				].

				fBest:=fBest/best asFloat. 
				fRest:=fRest/rest asFloat.
				fBest:=fBest*0.2.
				fRest:=fRest*0.8.
				score:=(fBest raisedTo: 2)/(fBest+fRest) asFloat.

				"cache the sucker"
				scores at: key put: score.
			].
		].
	].
		
	^scores
!

classify: aNumber
	|clog sessions bscore bsession archives|
	archives:=The historian archives.
	sessions:= The historian session.
	
	1 to: aNumber do: [:b| 
		bscore:=0.
		bsession:=0.

		1 to: sessions-1 do: [:c|
			clog:=archives at:c.
			(clog includesKey: 'class') ifFalse:[
				((clog at: 'score') > bscore) ifTrue:[
					bscore:=(clog at:'score').
					bsession:=c.
				].		
			].
		].
		(archives at: bsession) at: 'class' put: 'best'.
	].

	1 to: sessions-1 do:[:d|
		((archives at: d) includesKey: 'class') 
			ifFalse:[ (archives at: d) at: 'class' put: 'rest'].

	].

	^archives
!
polled: aPoller
	|openMindedness vote|
	openMindedness:=0.75.
	"Taking away power to veto to help learning"
	vote:=true.
	support add:(aPoller billSupport).
	"Are they in the same political party?"
	"(party=(aPoller party))
		ifTrue: [
			openMindedness := openMindedness sqrt]
		ifFalse: [
			openMindedness := openMindedness raisedTo:2].
	"
	"Trust factor"
"	openMindedness := openMindedness raisedTo:(0.76+(1-aPoller trust)).
"
	"Factor in current level of support"
"	openMindedness := openMindedness raisedTo:(0.76+(1-aPoller billSupport)). 
	
	(App random next < openMindedness)
		ifTrue: [
			self talks:'says yes'.
			support:=support+(aPoller billSupport).
			vote:=true.]
		ifFalse: [
			self talks:'says no'.
			vote:=false.].
"
	^vote.

!
score
	|senators|
	senators:= The factory machines contents size.
	
	^((dsuccess+rsuccess)/senators) asFloat
!
scoreSupport
	|sup|
	sup:= support at:(((dsuccess+rsuccess)/2) asFloat rounded).

	^sup
!
score: mode
	|d r|
	(rsuccess+dsuccess=0) ifTrue:[d:=0.r:=0.]
		ifFalse:[d:=(dsuccess/(rsuccess+dsuccess)) asFloat. r:=(rsuccess/(rsuccess+dsuccess)) asFloat].
	(mode=0)
		ifTrue:[^d]
		ifFalse:[^r].
!!
"============================================"
! PresidentKEYS methodsFor: 'accessing'!
party
	^party
!
dsuccess: s
	dsuccess:=s.
!
dsuccess
	^dsuccess
!
rsuccess: s
	rsuccess:=s.
!
rsuccess
	^rsuccess
!
support: s
	support:=s.
!
support
	^support
!
basesums
	^basesums
!
basesums: b
	basesums:=b.
!!
"============================================"
! PresidentKEYS methodsFor: 'printing' !
talks: x
    App say: ('President:[', id s, '] ', x s).
!!
