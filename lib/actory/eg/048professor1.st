|f m t|
App reset; asynchronousOff.
f := Building new: 'csee'.
m := Professor new: 'menzies'.
t := Professor new: 'tanner'.
m worksIn: f.
t worksIn: f.
"Professor worksIn: f."
f run.
!
