! Senator class methodsFor: 'creation' !
new: name
	^(super new: name) init
!
worksIn: factory
    factory 
       machine: (self new: 'senator');

	"Comittee Phase"
	go: #start   to: #sellG    then:  [The machine talks: 'gathering support'];
	go: #sellG    to: #comittee 	if: [(The machine billPassed)=0]
					then:  [The machine talks: 'presenting to comittee'];
	go: #comittee to: #sellG	then: [The machine talks: 'gathering support'];
      
	"Floor phase"
	go: #sellG    to: #present	if: [(The machine billPassed)=1]
					then: [The machine talks: 'presenting to the floor'];
	go: #present to: #sellG then: [The machine talks: 'gathering support'];
       
	"Scandal"
	go: #sellG to: #scandalS	then:  [The machine naughty];
       	go: #scandalS to: #sellG    then:  [((App random next > 0.9) or: [The machine caughtLikelihood > 0.95])
						ifTrue:[The machine caught.]];
	"Other"     
  	go: #sellG     to: #endF   if:    [App random next > 0.9] 
                                 then:  [The machine 
                                            talks: 'that is all folks'.
                                         The yourself oo.
					 The machine party oo.
					 The machine comittee oo.
					The machine trust oo.
                                         The machine scandals oo.
                                         The machine caughtLikelihood oo.
					The machine billComittee.
					The machine billSupport].
!!

"============================================"
! Senator methodsFor: 'creation' !
init
    scandals := 0.
    caughtLikelihood := 0.1.
    comittee := ((App random next)*16) rounded. 
    billComittee := ((App random next)*16) rounded.
    billPassed := 0.
    billSupport := 0.
    trust :=1.
    party := ((App random next)*2) rounded.
!!

"============================================"
! Senator methodsFor: 'operations' !
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
    caughtLikelihood :=0.
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
comittee
    ^comittee
!
billComittee
    ^billComittee
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
