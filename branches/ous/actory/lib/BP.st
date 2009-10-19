! BP class methodsFor: 'creation' !
new: name
	^(super new: name) initbp
!
worksIn: factory
    factory 
    	machine: (self new: 'BP');
    	"================Guest Transitions=============="
    	go: #start	to: #waitingI	then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	go: #waitingI	to: #waitingI	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I can help though'];
    	"================Close Friends/Family Transitions==============="
    	go: #waitingB	to: #waitingB	if: [The factory time > 0]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingI	to: #waitingB	if: [(The factory time > 0) & (App random next > 0.5) ]
    					then: [The machine talks: 'waiting for the ceremony, I am busy though'];
    	go: #waitingB	to: #waitingI	if: [(The factory time > 0) & (App random next < 0.5) ]
    					then: [The machine talks: 'waiting for the ceremony, I can help now'];
    	go: #waitingI	to: #endF	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	go: #waitingB	to: #endF	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion > 0)]
    					then: [The machine notHappy; talks: 'what a letdown'];
    	"================Bridal Party Transitions=============="
    	go: #waitingI	to: #doceremonyB	if: [((The factory task: 'ceremony') peopleNum = 0) & ((The factory task: 'ceremony') timestart < (The factory time+1))]
    						then: [The machine isinchargeof: 'ceremony'; talks: 'Working on the ceremony'];
    	go: #waitingI	to: #doreceptionB	if: [((The factory task: 'reception') peopleNum = 0) & ((The factory task: 'reception') timestart < (The factory time+1))]
    						then: [The machine isinchargeof: 'reception'; talks: 'Working on the reception'];
    	go: #waitingI	to: #dodecorationB	if: [((The factory task: 'decoration') peopleNum = 0) & ((The factory task: 'decoration') timestart < (The factory time+1))]
    						then: [The machine isinchargeof: 'decoration'; talks: 'Working on the decoration'];
    	go: #waitingI	to: #dofoodB	if: [((The factory task: 'food') peopleNum = 0) & ((The factory task: 'food') timestart < (The factory time+1))]
    						then: [The machine isinchargeof: 'food'; talks: 'Working on the food'];
    	go: #waitingI	to: #dorefoodB	if: [((The factory task: 'refood') peopleNum = 0) & ((The factory task: 'refood') timestart < (The factory time+1))]
    						then: [The machine isinchargeof: 'refood'; talks: 'Working on the rehersal food'];
    	"==============Ask for help transitions================="					
    	go: #doceremonyB	to: #doceremonyBH	if: [(The factory task: 'ceremony') timetocompletion > (The factory time - (The factory task: 'ceremony') timeneeded)]
    						then: [The machine talks: 'need help with the ceremony'; pleasehelp];
    	go: #doreceptionB	to: #doreceptionBH	if: [(The factory task: 'reception') timetocompletion > (The factory time - (The factory task: 'reception') timeneeded)]
    						then: [The machine talks: 'need help with the reception'; pleasehelp];
    	go: #dodecorationB	to: #dodecorationBH	if: [(The factory task: 'decoration') timetocompletion > (The factory time - (The factory task: 'decoration') timeneeded)]
    						then: [The machine talks: 'need help with the decoration'; pleasehelp];
    	go: #dofoodB	to: #dofoodBH	if: [(The factory task: 'food') timetocompletion > (The factory time - (The factory task: 'food') timeneeded)]
    						then: [The machine talks: 'need help with the food'; pleasehelp];
    	go: #dorefoodB	to: #dorefoodBH	if: [(The factory task: 'refood') timetocompletion > (The factory time - (The factory task: 'refood') timeneeded)]
    						then: [The machine talks: 'need help with the rehersal food'; pleasehelp];
    	go: #doceremonyBH	to: #doceremonyB	if: [(The factory task: 'ceremony') timetocompletion < (The factory time - (The factory task: 'ceremony') timeneeded)]
    						then: [The machine talks: 'thanks for help with the ceremony'; thanks4help];
    	go: #doreceptionBH	to: #doreceptionB	if: [(The factory task: 'reception') timetocompletion < (The factory time - (The factory task: 'reception') timeneeded)]
    						then: [The machine talks: 'thanks for help with the reception'; thanks4help];
    	go: #dodecorationBH	to: #dodecorationB	if: [(The factory task: 'decoration') timetocompletion < (The factory time - (The factory task: 'decoration') timeneeded)]
    						then: [The machine talks: 'thanks for help with the decoration'; thanks4help];
    	go: #dofoodBH	to: #dofoodB	if: [(The factory task: 'food') timetocompletion < (The factory time - (The factory task: 'food') timeneeded)]
    						then: [The machine talks: 'thanks for help with the food'; thanks4help];
    	go: #dorefoodBH	to: #dorefoodB	if: [(The factory task: 'refood') timetocompletion < (The factory time - (The factory task: 'refood') timeneeded)]
    						then: [The machine talks: 'thanks for help with the rehersal food'; thanks4help];
    	"================================================"					
    	go: #doceremonyB	to: #waitingI	if: [(The factory task: 'ceremony') timetocompletion < 1]
    						then: [The machine talks: 'done with the ceremony'; isdone];
    	go: #doreceptionB	to: #waitingI	if: [(The factory task: 'reception') timetocompletion < 1]
    						then: [The machine talks: 'done with the reception'; isdone];
    	go: #dodecorationB	to: #waitingI	if: [(The factory task: 'decoration') timetocompletion < 1]
    						then: [The machine talks: 'done with the decoration'; isdone];
    	go: #dofoodB	to: #waitingI	if: [(The factory task: 'food') timetocompletion < 1]
    						then: [The machine talks: 'done with the food'; isdone];
    	go: #dorefoodB	to: #waitingI	if: [(The factory task: 'refood') timetocompletion < 1]
    						then: [The machine talks: 'done with the rehersal food'; isdone];
    	"===============Close Friends/Family Transitions==============="
    	go: #waitingI	to: #helpingB	if: [(The factory peopleNeedHelp size) > 0]
    					then: [The machine helps: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp addFirst: The factory peopleNeedHelp last.
    						The factory peopleNeedHelp removeLast.
    						The machine talks: 'helping out with'+(The machine taskhelp).];
    	go: #helpingB	to: #waitingI 	if: [(The factory task: (The machine taskhelp)) peopleNum = 1]
    					then: [The machine donehelping; talks: 'Back to waiting'];
    	go: #waitingB	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion < 1)]
    					then: [The machine atceremonyfor: (The factory task: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	"===============Guest Transitions============="
    	go: #waitingI	to: #atceremony	if: [(The factory time < 1) & ((The factory task: 'ceremony') timetocompletion < 1)]
    					then: [The machine atceremonyfor: (The factory task: 'ceremony') length.
    						The machine talks: 'at the ceremony'];
    	go: #atceremony	to: #noticesdecorH	if: [(The factory task: 'decoration') timetocompletion < 1]
    						then: [The machine seesdecor: (The factory task: 'decoration') cost];
    	go: #atceremony	to: #atreception	if: [(The factory task: 'decoration') timetocompletion > 0]
    						then: [The machine talks: 'at the reception'];
    	go: #noticesdecorH	to: #atreception	then: [The machine talks: 'at the reception'];
    	go: #atreception	to: #checksoptionsH	then: [The machine seesoptions: (The factory task: 'food') options; talks: 'checking options'];
    	go: #checksoptionsH	to: #eatingH		then: [The machine eats: (The factory task: 'food') portions; talks: 'having something to eat'];
    	go: #eatingH 		to: #endF	then: [The factory judgingwedding: The machine happiness].
    	"================================================"
!!

"============================================"
! BP methodsFor: 'creation' !
initbp
	taskname := ''.
	needhelp := false
!!

"============================================"
! BP methodsFor: 'accessing' !
taskname
	^taskname
!
needhelp
	^needhelp
!!

"============================================"
! BP methodsFor: 'setting' !
isinchargeof: tname
	taskname := tname.
	(The factory task:tname) moreWorkers
!
pleasehelp
	needhelp := true.
	The factory peopleNeedHelp addFirst: self.
	((The factory peopleNeedHelp size) printString, ' people need help') oo
!
nomorehelp
	needhelp := false.
	The factory nolongerNeedsHelp: self
!
thanks4help
	|tname|
	tname := self taskname.
	(The factory task: tname) releaseWorkers.
	self nomorehelp
!
isdone
	self thanks4help.
	taskname := ''
!!
