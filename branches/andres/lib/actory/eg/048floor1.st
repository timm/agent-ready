|f r|
App reset; asynchronousOff.
f := Building new: 'csee'.
r := Floor new: 'ground'.
r room: 1 isa: 'restroom'.
r room: 2 isa: 'classroom'.
r room: 5 isa: 'cafeteria'.
r rooms oo.
r worksIn: f.
"Professor worksIn: f."
f run.
!
