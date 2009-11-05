p1 := StudentState new.
bag1 := Bag new.
bag2 := Bag new.
100 timesRepeat:[
bag1 add: (p1 RandState: 'Course') ].
bag1 oo.

100timesRepeat:[
bag2 add: (p1 RandState: 'Life')].
bag2 oo.
