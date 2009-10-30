ss1 := StudentState new.
ss1 add: #start.
se1 := SideEffect new.
guard := Guard new.
t1 := Transition new
                                state:ss1  startState;
                                if: (guard Rand);
                                then: (se1 Rand);
                                next: (ss1 RandState).
t1 inspect.
m1 := Machine new: 'haha'.
m1 add: t1.
