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
(#Transition isa: App with: 'container id state if then next') public; inits.
#ErrorState  isa: State.
#LoopState   isa: State.
#EndState    isa: State.
#NormalState isa: State.
#Happy       isa: NormalState.
#KillJoy     isa: Machine with: 'happiness'.

#Wedding     isa: Factory with: 'bp guests budget time receptionOP decorationOP ceremonyOP foodOP refoodOP reception decoration ceremony food refood tasksDic peopleNeedHelp'.
#Guest       isa: Machine with: 'happiness'.
#CFF         isa: Guest with: 'taskhelp'. "Close Friends and Family"
#BP          isa: CFF with: 'taskname needhelp'. "Bridal Party"
#POB         isa: BP with: 'money'. "Parents Of Bride"
#POG         isa: BP with: 'money'. "Parents Of Bride"
#Bride       isa: BP.
#Groom       isa: BP.


#Busy        isa: NormalState.
#BusyNeedHelp isa: NormalState.
#Idle        isa: NormalState.

#Task        isa: Object with: 'name timeneeded timestart timetocompletion cost peopleNum'.
#Reception    isa: Task.
#Decoration    isa: Task.
#Ceremony    isa: Task with: 'length '.
#Food        isa: Task with: 'options portions'.
#RehersalDin isa: Food.

Smalltalk at: #The put: nil. "one global"

!
