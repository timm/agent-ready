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
#Factory     isa: App with: 'machines name current'.
#Machine     isa: App with: 'container name id current start states transitions'.
(#State      isa: App with: 'container name id visits froms tos') public.
(#Transition isa: App with: 'container      id state if then next') public; inits.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.
#Happy       isa: NormalState.
#KillJoy     isa: Machine with: 'happiness'.


#CourseFactory isa: Factory. 
#Course        isa: Machine with: 'trans selfEvents patience prerequisite students'.
#LifeEvent     isa: App with: 'name patience ss1 id student guard sideEffect guardSideEffect '.
#CourseEvent   isa: App with:  'name patience ss1 id course guard sideEffect guardSideEffect'.
#Student       isa: Machine with: 'courses happiness lifeEvent'.
#StudentState  isa: App with: 'states'. 
#Guard         isa: App with: 'guards'.
#SideEffect    isa: App with: 'effects'.
#GuardSideEffect isa: App with: 'gsesets'.
Smalltalk at: #The put: nil. "one global"

!
