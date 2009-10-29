! Senator class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
       machine: (self new: 'senator');

	go: #start   to: #sellG	then:[The historian record:'s1'];

	"Scandal"
	go: #sellG to: #scandalS	if: [(The factory suspended=false) and:[App random next > 0.65]]
					then: [The historian record:'s2'.
						The machine talks: 'bribing a colleague'];
       	go: #scandalS  to: #suspendedH   if:[The factory suspended]
					then: [The historian record:'s3'.
						The machine talks: 'suspended for a filibuster'];
	go: #scandalS to: #sellG    	if:[The factory suspended=false]
					then:  [The historian record:'s4'.
						((App random next > 0.75) or: [The machine caughtLikelihood > 0.95])
						ifTrue:[The machine talks:'phone tapped by the FBI'.
							The machine caught.]];

	"Investigation"
	go:#sellG	to:#investigateI	if:[(The factory suspended=false) and: [App random next > 0.75]]
						then: [The historian record:'s6'.
							The machine talks: 'investigating a suspicious colleague'];
	go:#investigateI	to:#sellG	if:[The factory suspended=false]
						then: [The historian record:'s7'];
	go:#investigateI  	to: #suspendedH if:[The factory suspended=true]
						then: [The historian record:'s8'.
							The machine talks: 'suspended for a filibuster'];

	"Committee Phase"
	go: #sellG   to: #suspendedH  	if:[The factory suspended]
					then: [The historian record:'s9'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG    to: #committeeP 	if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s10'.
						The machine talks: 'presenting to committee.'];
	go: #sellG	to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'s11'.
							The machine talks: 'calling for a committee vote.'];
	go: #committeeP to: #sellG	if:[The factory suspended=false]
					then: [The historian record:'s12'];
	go: #committeeP to: #committeeVoteV	if:[The factory suspended=false]
						then:[The historian record:'s13'];
	go: #committeeP  to: #suspendedH  	if:[The factory suspended]
						then: [The historian record:'s14'.
							The machine talks: 'suspended for a filibuster'];
	go: #committeeVoteV to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'s15'];	
      
	go: #comitteeVoteV  to: #suspendedH  	if:[The factory suspended]
						then: [The historian record:'s16'.
							The machine talks: 'suspended for a filibuster'];

	"Floor phase"
	go: #sellG    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s17'.
						The machine talks: 'presenting to the floor.'];
	go: #presentP to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'s18'];
	go: #presentP to: #floorV	if:[The factory suspended=false]
					then:[The historian record:'s19'];
	go: #presentP to: #suspendedH   if:[The factory suspended]
					then: [The historian record:'s20'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG	to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s21'.
						The machine talks: 'calling for a vote.'];
	go: #floorV	to: #presidentF	if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s22'.
						The machine talks: 'sending the bill to the president.'];       
	go: #floorV 	to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'s23'];
	go: #floorV  	to: #suspendedH if:[The factory suspended]
					then: [The historian record:'s24'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG	to: #presidentF if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s25'.
						The machine talks: 'sending the bill to the president.'.];
	go: #sellG	to: #failedF 	if:[The machine billProposed>1]
					then: [The historian record:'s26'.
						The machine talks:'failed to pass their bill.'];
	"Filibuster"
	go:#sellG	to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s27'.
						The machine talks: 'calling for a filibuster'];
	go:#filibuster  to: #suspendedH  if:[The factory suspended=true]
					then: [The historian record:'s28'.
						The machine talks: 'suspended for a filibuster'];
	go:#suspendedH	to:#sellG	if: [The factory suspended=false]
					then: [The historian record:'s29'.].
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
!
reset
	super.
    	scandals := 0.
  	caughtLikelihood := 0.1.
   	 billPassed := 0.
    	billSupport := 0.
   	billProposed :=0.
    	trust :=1.
    	cloture:=0.
!!

"============================================"
! Senator methodsFor: 'operations' !
polled: aPoller
	|openMindedness vote support|
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
			openMindedness := openMindedness raisedTo:0.75].

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
	support:=1-aPoller billSupport.
	(support > 0.25) ifTrue:[support:=0.25].
	openMindedness := openMindedness raisedTo:(0.75+(support)). 
	
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
    scandals := scandals+1.
    caughtLikelihood := caughtLikelihood sqrt.
    (App random next > caughtLikelihood)
	ifTrue: [
		billSupport := billSupport sqrt.
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
