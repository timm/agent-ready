! Senator class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
       machine: (self new: 'senator');

	"Committee Phase"
	go: #start   to: #sellG;
	go: #sellG    to: #committeeV 	if: [(The machine billPassed)=0]
					then:  [The machine talks: 'presenting to committee'];
	go: #committeeV to: #sellG;
      
	"Floor phase"
	go: #sellG    to: #present	if: [(The machine billPassed)=1]
					then: [The machine talks: 'presenting to the floor'];
	go: #present to: #sellG;
       
	"Scandal"
	go: #sellG to: #scandalS	if: [App random next > 0.75]
					then: [The machine talks: 'bribing a colleague'];
       	go: #scandalS to: #sellG    then:  [((App random next > 0.9) or: [The machine caughtLikelihood > 0.95])
						ifTrue:[The machine talks:'phone tapped by the FBI'.
							The machine caught.]];
	"Other"     
  	go: #sellG     to: #endF   if:    [App random next > 0.9] 
                                 then:  [The machine 
                                            talks: 'that is all folks'.
                                         The yourself oo.
					 The machine party oo.
					 The machine committee oo.
					The machine trust oo.
                                         The machine scandals oo.
                                         The machine caughtLikelihood oo.
					The machine billCommittee oo.
					The machine billSupport oo].
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
    trust :=1.
    party := ((App random next)*2) rounded.
!!

"============================================"
! Senator methodsFor: 'operations' !
polled: aPoller
	|openMindedness vote|
	openMindedness:=0.5.

	"Are they in the same political party?"
	(party=(aPoller party))
		ifTrue: [
			openMindedness := openMindedness + 0.33.]
		ifFalse: [
			openMindedness := openMindedness - 0.33.].
	"Are they on the same committee?"
	(committee=(aPoller committee))
		ifTrue: [
			openMindedness := openMindedness + 0.15.].

	"Is the bill relevant to their committee?"
	(committee=(aPoller billCommittee))
		ifTrue: [
			(party=(aPoller party))
				ifTrue: [
					openMindedness:= openMindedness +0.15.]
				ifFalse: [
					openMindedness:= openMindedness -0.15.].
		].
	"Trust factor"
	openMindedness := openMindedness + ((aPoller trust)*0.15).

	"Factor in current level of support"
	openMindedness := openMindedness + ((aPoller billSupport)*0.15).
	
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
    caughtLikelihood := caughtLikelihood+(caughtLikelihood sqrt).
    prob1 := (App random next).
    (prob1>caughtLikelihood)
	ifTrue: [
		prob2:= (App random next).
		billSupport := billSupport+prob2.
		'You bribed a colleage for their vote. They are just as slimy as you.' oo]
	ifFalse: [
		self caught].
!
caught
    scandals :=0.
    caughtLikelihood :=0.1.
    trust := (trust-0.1).
    billSupport :=0.
    'You got too greedy and were caught.' oo.
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
!!
"============================================"
! Senator methodsFor: 'printing' !
talks: x
    ('Machine:[', id s, '] ', x s)oo
!!
