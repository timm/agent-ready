#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange'. 
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagWidth    isa: GraphTag.
#TagError    isa: GraphTag.

#App         isa:    Object 
             shares: 'Clock Rand Asynchronousp Patience Trace Ids TooManyLoops' .

#Stagger     isa: App with: 'contents pointer'.
#Factory     isa: App with: 'biases era machines name current oracle historian suspended suspendee pressure'.
#Machine     isa: App with: 'tcounter container name id current start states transitions'.
#Senator    isa: Machine with: 'billCommittee billSupport billPassed billProposed cloture committee party trust scandals caughtLikelihood'.
#President	isa: Machine with:'party dsuccess rsuccess'.
#PresidentKEYS	isa: Machine with:'party dsuccess rsuccess'.
#Historian	isa: Machine with:'log score session archives'.
(#State      isa: App with: 'container name id visits froms tos') public.
(#Transition isa: App with: 'container tid id state if then next') public; inits.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.
#Happy       isa: NormalState.
#Voting	     isa: NormalState.
#Scandal     isa: NormalState.
#Selling     isa: NormalState.
#Presenting  isa: NormalState.
#Suspended   isa: NormalState.
#Investigating isa:NormalState.
#KillJoy     isa: Machine with: 'happiness'.

Smalltalk at: #The put: nil. "one global"

!
