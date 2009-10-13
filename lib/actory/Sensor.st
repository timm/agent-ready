! Sensor class methodsFor: 'creation'!
new: name
      ^super new init
!!

"--------------------------------"
! Sensor methodsFor: 'creation' !

init
    range :=  2 + (App random next * 2) asInteger. 
    ('****Initial values are:   *****')oo.
    ('sensor range= ', range s)oo.
!!

"--------------------------------"
! Sensor methodsFor: 'accessing' !

range
    ^range rounded.
!!
