|f r c|
App reset; asynchronousOff.
f := Building new: 'csee'.
r := Sensor new: 'r'.
c := Sensor new: 'c'.
c worksIn: f.
r worksIn: f.
"Professor worksIn: f."
f run.
!
