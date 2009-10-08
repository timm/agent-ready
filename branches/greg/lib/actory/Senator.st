! Senator class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
       machine: (self new: 'senator');

	go: #start   to: #sellG	then:[The historian record:'one'];

	"Scandal"
	go: #sellG to: #scandalS	if: [(The factory suspended=false) and:[App random next > 0.75]]
					then: [The historian record:'six'.
						The machine talks: 'bribing a colleague'];
       	go: #scandalS  to: #suspendedH   if:[The factory suspended]
					then: [The historian record:'eight'.
						The machine talks: 'suspended for a filibuster'];
	go: #scandalS to: #sellG    	if:[The factory suspended=false]
					then:  [The historian record:'one'.
						((App random next > 0.9) or: [The machine caughtLikelihood > 0.95])
						ifTrue:[The machine talks:'phone tapped by the FBI'.
							The machine caught.]];

	"Investigation"
	go:#sellG	to:#investigateI	if:[(The factory suspended=false) and: [App random next > 0.75]]
						then: [The historian record:'nine'.
							The machine talks: 'investigating a suspicious colleague'];
	go:#investigateI	to:#sellG	if:[The factory suspended=false]
						then: [The historian record:'one'];
	go:#investigateI  	to: #suspendedH if:[The factory suspended=true]
						then: [The historian record:'eight'.
							The machine talks: 'suspended for a filibuster'];

	"Committee Phase"
	go: #sellG   to: #suspendedH  	if:[The factory suspended]
					then: [The historian record:'eight'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG    to: #committeeP 	if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'two'.
						The machine talks: 'presenting to committee.'];
	go: #sellG	to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'three'.
							The machine talks: 'calling for a committee vote.'];
	go: #committeeP to: #sellG	if:[The factory suspended=false]
					then: [The historian record:'one'];
	go: #committeeP to: #committeeVoteV	if:[The factory suspended=false]
						then:[The historian record:'three'];
	go: #committeeP  to: #suspendedH  	if:[The factory suspended]
						then: [The historian record:'eight'.
							The machine talks: 'suspended for a filibuster'];
	go: #committeeVoteV to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'one'];	
      
	go: #comitteeVoteV  to: #suspendedH  	if:[The factory suspended]
						then: [The historian record:'eight'.
							The machine talks: 'suspended for a filibuster'];

	"Floor phase"
	go: #sellG    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'four'.
						The machine talks: 'presenting to the floor.'];
	go: #presentP to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'one'];
	go: #presentP to: #floorV	if:[The factory suspended=false]
					then:[The historian record:'five'];
	go: #presentP to: #suspendedH   if:[The factory suspended]
					then: [The historian record:'eight'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG	to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'five'.
						The machine talks: 'calling for a vote.'];
	go: #floorV	to: #presidentF	if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'ten'.
						The machine talks: 'sending the bill to the president.'];       
	go: #floorV 	to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'one'];
	go: #floorV  	to: #suspendedH if:[The factory suspended]
					then: [The historian record:'eight'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG	to: #presidentF if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'ten'.
						The machine talks: 'sending the bill to the president.'.];
	"Filibuster"
	go:#sellG	to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'seven'.
						The machine talks: 'calling for a filibuster'];
	go:#filibuster  to: #suspendedH  if:[The factory suspended=true]
					then: [The historian record:'eight'.
						The machine talks: 'suspended for a filibuster'];
	go:#suspendedH	to:#sellG	if: [The factory suspended=false]
					then: [The historian record:'one'.].
!!

"============================================"
! Senator methodsFor: 'creation' !
init
    scandals := 0.
    caughtLikelihood := 0.1.
    committee := ((App random next)*16) rounded. 
    billCommittee := ((App random next)*16) rounded.
    billPassed := 0.
    billSupport := 0.
    billProposed :=0.
    trust :=1.
	(App random next > 0.5) ifTrue:[party:=0] ifFalse:[party:=1].
    cloture:=0.
!!

"============================================"
! Senator methodsFor: 'operations' !
polled: aPoller
	|openMindedness vote|
	openMindedness:=0.5.

	"Are they in the same political party?"
	(party=(aPoller party))
		ifTrue: [
			openMindedness := openMindedness sqrt]
		ifFalse: [
			openMindedness := openMindedness raisedTo:2].
	"Are they on the same committee?"
	(committee=(aPoller committee))
		ifTrue: [
			openMindedness := openMindedness raisedTo:1.5].

	"Is the bill relevant to their committee?"
	(committee=(aPoller billCommittee))
		ifTrue: [
			(party=(aPoller party))
				ifTrue: [
					openMindedness:= openMindedness raisedTo:0.75]
				ifFalse: [
					openMindedness:= openMindedness raisedTo:1.5].
		].
	"Trust factor"
	openMindedness := openMindedness raisedTo:(0.75+(1-aPoller trust)).

	"Factor in current level of support"
	openMindedness := openMindedness raisedTo:(0.75+(1-aPoller billSupport)). 
	
	(App random next < openMindedness)
		ifTrue: [
			self talks:'says yes'.
			vote:=true.]
		ifFalse: [
			self talks:'says no'.
			vote:=false.].
	^vote.
!
naughty
    |prob1 prob2|
    scandals := scandals+1.
    caughtLikelihood := caughtLikelihood sqrt.
    prob1 := (App random next).
    (prob1>caughtLikelihood)
	ifTrue: [
		prob2:= (App random next).
		billSupport := billSupport+prob2.
		App say: 'You bribed a colleage for their vote. They are just as slimy as you.']
	ifFalse: [
		self caught].
!
caught
    scandals :=0.
    caughtLikelihood :=0.1.
    trust := (trust-0.1).
    billSupport :=0.
    App say:'You got too greedy and were caught.'.
!!
"============================================"
!Senator methodsFor: 'accessing' !
scandals
    ^scandals
!
scandals: s
    scandals := s
!
caughtLikelihood
    ^caughtLikelihood
!
caughtLikelihood: c
    caughtLikelihood := c
!
committee
    ^committee
!
billCommittee
    ^billCommittee
!
billSupport: s
	billSupport := s
!
billSupport
    ^billSupport
!
party
    ^party
!
billPassed: p
	billPassed := p.
!
billPassed
	^billPassed
!
trust
	^trust
!
trust: t
	trust:= t.
!
billProposed: p
	billProposed := p
!
billProposed
	^billProposed
!
cloture: c
	cloture:=c.
!
cloture
	^cloture
!!
"============================================"
! Senator methodsFor: 'printing' !
talks: x
    App say: ('Senator:[', id s, '] ', x s).
!!
