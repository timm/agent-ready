#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange'. 
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagWidth    isa: GraphTag.
#TagError    isa: GraphTag.

#App         isa:    Object 
             shares: 'Clock Rand Asynchronousp Trace Ids TooManyLoops' .

#Stagger     isa: App with: 'contents pointer'.
#Mill       isa: App with: 'machines name current'.
#Machine     isa: App with: 'container name current states id transitions'.
(#State      isa: App with: 'container name visits id froms tos') public.
(#Transition isa: App with: 'container state if then next') public; inits.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.

!
