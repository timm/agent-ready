! Senator class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
       machine: (self new: 'senator');

	"one-tim ops"
	go: #start   to: #sellG	then:[The historian record:'s1'];
	go:#filibuster  to: #suspendedH  if:[The factory suspended=true]
					then: [The historian record:'s2'.
						The machine talks: 'suspended for a filibuster'];
	"sell"
	go: #sellG to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s3'.
						The machine talks: 'bribing a colleague'];
 	go:#sellG	to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s4'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #sellG   to: #suspendedH  	if:[The factory suspended]
					then: [The historian record:'s5'.
						The machine talks: 'suspended for a filibuster'];
	go: #sellG    to: #committeeP 	if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s6'.
						The machine talks: 'presenting to committee.'];
	go: #sellG	to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'s7'.
							The machine talks: 'calling for a committee vote.'];
	go: #sellG    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s8'.
						The machine talks: 'presenting to the floor.'];
 	go: #sellG	to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s9'.
						The machine talks: 'calling for a vote.'];
	go: #sellG	to: #presidentF if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s10'.
						The machine talks: 'sending the bill to the president.'.];
	go: #sellG	to: #failedF 	if:[The machine billProposed>1]
					then: [The historian record:'s11'.
						The machine talks:'failed to pass their bill.'];
	go:#sellG	to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s12'.
						The machine talks: 'calling for a filibuster'];
     	go:#sellG	to:#sellG	if: [The factory suspended=false]
					then: [The historian record:'s13'.];

	"Scandal"
	go: #scandalS  to: #suspendedH   if:[The factory suspended]
					then: [The historian record:'s14'.
						The machine talks: 'suspended for a filibuster'];
	go: #scandalS to: #sellG    	if:[The factory suspended=false]
					then:  [The historian record:'s15'.];
	go: #scandalS to: #investigateI	if:[The factory suspended=false]
					then:[The historian record:'s16'.
						The machine talks: 'investigating a suspicious colleague.'.];
	go: #scandalS to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s17'.
						The machine talks: 'bribing a colleague'];
	go: #scandalS    to: #committeeP if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s18'.
						The machine talks: 'presenting to committee.'];
	go: #scandalS	to: #committeeVoteV if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'s19'.
							The machine talks: 'calling for a committee vote.'];
	go: #scandalS    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s20'.
						The machine talks: 'presenting to the floor.'];
	go: #scandalS	to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s21'.
						The machine talks: 'calling for a vote.'];
	go: #scandalS	to: #presidentF if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s22'.
						The machine talks: 'sending the bill to the president.'.];
	go: #scandalS	to: #failedF 	if:[The machine billProposed>1]
					then: [The historian record:'s23'.
						The machine talks:'failed to pass their bill.'];
	go:#scandalS	to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s24'.
						The machine talks: 'calling for a filibuster'];

	"Investigation"
	go:#investigateI	to:#sellG	if:[The factory suspended=false]
						then: [The historian record:'s25'];
	go:#investigateI  	to: #suspendedH if:[The factory suspended=true]
						then: [The historian record:'s26'.
							The machine talks: 'suspended for a filibuster'];
	go: #investigateI to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s27'.
						The machine talks: 'bribing a colleague'];
	go:#investigateI to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s28'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #investigateI    to: #committeeP if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s29'.
						The machine talks: 'presenting to committee.'];
	go: #investigateI to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'s30'.
							The machine talks: 'calling for a committee vote.'];
	go: #investigateI    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s31'.
						The machine talks: 'presenting to the floor.'];
	go: #investigateI to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s32'.
						The machine talks: 'calling for a vote.'];
	go: #investigateI to: #presidentF if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s33'.
						The machine talks: 'sending the bill to the president.'.];
	go: #investigateI	to: #failedF 	if:[The machine billProposed>1]
					then: [The historian record:'s34'.
						The machine talks:'failed to pass their bill.'];
	go:#investigateI to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s35'.
						The machine talks: 'calling for a filibuster'];
	
	"Committee Presentation"

	go: #committeeP to: #sellG	if:[The factory suspended=false]
					then: [The historian record:'s36'];
	go: #committeeP to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then:[The historian record:'s37'];
	go: #committeeP  to: #suspendedH  	if:[The factory suspended]
						then: [The historian record:'s38'.
							The machine talks: 'suspended for a filibuster'];
	go: #committeeP to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s39'.
						The machine talks: 'bribing a colleague'];	
	go:#committeeP	to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s40'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #committeeP    to: #committeeP if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s41'.
						The machine talks: 'presenting to committee.'];
	go:#committeeP to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s42'.
						The machine talks: 'calling for a filibuster'];
	
	"Committee Voting"
	go: #committeeVoteV to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'s43'];	
	go: #comitteeVoteV  to: #suspendedH  	if:[The factory suspended]
						then: [The historian record:'s44'.
							The machine talks: 'suspended for a filibuster'];
	go: #committeeVoteV to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s45'.
						The machine talks: 'bribing a colleague'];
	go:#committeeVoteV to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s46'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #committeeVoteV   to: #committeeP if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s47'.
						The machine talks: 'presenting to committee.'];
	go: #committeeVoteV to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'s48'.
							The machine talks: 'calling for a committee vote.'];
	go: #committeeVoteV    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s49'.
						The machine talks: 'presenting to the floor.'];
	go: #committeeVoteV to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s50'.
						The machine talks: 'calling for a vote.'];
	go:#committeeVoteV to:#filibuster if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s51'.
						The machine talks: 'calling for a filibuster'];
	
	"Floor Presentation"
	go: #presentP to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'s52'];
	go: #presentP to: #floorV	if:[The factory suspended=false]
					then:[The historian record:'s53'];
	go: #presentP to: #suspendedH   if:[The factory suspended]
					then: [The historian record:'s54'.
						The machine talks: 'suspended for a filibuster'];
	go: #presentP to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s55'.
						The machine talks: 'bribing a colleague'];
	go:#presentP	to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s56'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #presentP    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s57'.
						The machine talks: 'presenting to the floor.'];
	go:#presentP to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s58'.
						The machine talks: 'calling for a filibuster'];

	"Floor Voting"
	go: #floorV	to: #presidentF	if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s59'.
						The machine talks: 'sending the bill to the president.'];       
	go: #floorV 	to: #sellG	if:[The factory suspended=false]
					then:[The historian record:'s60'];
	go: #floorV  	to: #suspendedH if:[The factory suspended]
					then: [The historian record:'s61'.
						The machine talks: 'suspended for a filibuster'];
	go: #floorV to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s62'.
						The machine talks: 'bribing a colleague'];
	go:#floorV	to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s63'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #floorV    to: #presentP	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s64'.
						The machine talks: 'presenting to the floor.'];
	go: #floorV	to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s65'.
						The machine talks: 'calling for a vote.'];
	go: #floorV	to: #failedF 	if:[The machine billProposed>1]
					then: [The historian record:'s66'.
						The machine talks:'failed to pass their bill.'];
	go:#floorV to:#filibuster	if: [(The factory suspended=false) and: [The historian dominance]]
					then: [The historian record:'s67'.
						The machine talks: 'calling for a filibuster'];

	"Suspended"
	go:#suspendedH	to:#sellG	if: [The factory suspended=false]
					then: [The historian record:'s68'.];
	go: #suspendedH to: #scandalS	if: [The factory suspended=false]
					then: [The historian record:'s69'.
						The machine talks: 'bribing a colleague'];
	go: #suspendedH	to:#investigateI	if:[The factory suspended=false]
						then: [The historian record:'s70'.
							The machine talks: 'investigating a suspicious colleague'];
	go: #suspendedH    to: #committeeP if: [(The factory suspended=false) and:[The machine billPassed=0]]
					then:  [The historian record:'s71'.
						The machine talks: 'presenting to committee.'];
	go: #suspendedH	to: #committeeVoteV	if:[(The factory suspended=false) and:[The machine billPassed=0]]
						then: [The historian record:'s72'.
							The machine talks: 'calling for a committee vote.'];
	go: #suspendedH    to: #presentP if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s73'.
						The machine talks: 'presenting to the floor.'];
	go: #suspendedH	to: #floorV	if: [(The factory suspended=false) and:[
						(The machine billPassed=1) and: [The machine billProposed<2]]]
					then: [The historian record:'s74'.
						The machine talks: 'calling for a vote.'];
	go: #suspendedH	to: #presidentF if:[(The factory suspended=false) and:[The machine billPassed=2]]
					then: [The historian record:'s75'.
						The machine talks: 'sending the bill to the president.'.];
	go: #suspendedH	to: #failedF 	if:[The machine billProposed>1]
					then: [The historian record:'s76'.
						The machine talks:'failed to pass their bill.'].
!!

"============================================"
! Senator methodsFor: 'creation' !
init
    scandals := 0.
    caughtLikelihood := 0.1.
    committee := ((App random next)*16) rounded. 
    billCommittee := ((App random next)*16) rounded.
    billPassed := 0.
    billSupport := 0.01.
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
    	billSupport := 0.01.
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
	(support > 0.5) ifTrue:[support:=0.5].
	openMindedness := openMindedness raisedTo:(0.5+(support)). 
	
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
    (caughtLikelihood < 0.95)
	ifTrue: [
		billSupport := (billSupport raisedTo:0.75).
		App say: 'You bribed a colleage for their vote. They are just as slimy as you.']
	ifFalse: [
		self caught].
!
caught
    scandals :=0.
    caughtLikelihood :=0.1.
    trust := (trust-0.1).
    billSupport :=0.01.
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
