#Range       isa: Object with: 'min max'.
#Reader 	 isa: Object with: 'line array handler commentChar'.
#Graph       isa: Object with: 'label matrix height width ox oy xrange yrange'. 
#Tag         isa: Object.
#GraphTag    isa: Tag.
#TagWidth    isa: GraphTag.
#TagError    isa: GraphTag.

#App         isa:    Object 
             shares: 'Clock Rand Asynchronousp Patience Trace Ids TooManyLoops' .

#Stagger     isa: App with: 'contents pointer logger learned'.
#Factory     isa: App with: 'machines name current student flogger'.
#Machine     isa: App with: 'container name id current start states transitions ptrans'.
(#State      isa: App with: 'container name id visits froms tos') public.
(#Transition isa: App with: 'container      id state if then next stagger') public; inits.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.
#Happy       isa: NormalState.
#KillJoy     isa: Machine with: 'happiness'.


#CourseFactory isa: Factory. 
#Course        isa: Machine with: 'trans selfEvents patience prerequisite students '.
#LifeEvent     isa: App with: 'name patience ss1 id student guard sideEffect guardSideEffect transitions'.
#CourseEvent   isa: App with:  'name patience ss1 id course guard sideEffect guardSideEffect transitions'.
#Student       isa: Machine with: 'courses happiness lifeEvent patience'.
#StudentState  isa: App with: 'states'. 
#Guard         isa: App with: 'guards'.
#SideEffect    isa: App with: 'effects'.
#GuardSideEffect isa: App with: 'gsesets'.
#StaggerLogger isa: App with: 'logger counter stagger learner firelist'.
#FactoryLogger isa: App with: 'logger optlist bestDic restDic trans'.
#Learning      isa: App with: 'ptable runstable phsum transDic flogger biasedcourseTrans biasedlifeTrans'.
Smalltalk at: #The put: nil. "one global"

!
