|f r m|
App reset; asynchronousOff.
f := Building new: 'csee'.
r := Floor new: 'ground'.
r room: 1  isa: 'offc'.
r room: 2  isa: 'conf'.
r room: 3  isa: 'conf'.
r room: 4  isa: 'conf'.
r room: 5  isa: 'clss'.
r room: 6  isa: 'clss'.
r room: 7  isa: 'offc'.
r room: 8  isa: 'hall'.
r room: 9  isa: 'hall'.
r room: 10 isa: 'hall'.
r room: 11 isa: 'hall'.
r room: 12 isa: 'clss'.
r room: 13 isa: 'offc'.
r room: 14 isa: 'hall'.
r room: 15 isa: 'strs'.
r room: 16 isa: 'rest'.
r room: 17 isa: 'hall'.
r room: 18 isa: 'clss'.
r room: 19 isa: 'offc'.
r room: 20 isa: 'hall'.
r room: 21 isa: 'elev'.
r room: 22 isa: 'rest'.
r room: 23 isa: 'hall'.
r room: 24 isa: 'clss'.
r room: 25 isa: 'offc'.
r room: 26 isa: 'hall'.
r room: 27 isa: 'hall'.
r room: 28 isa: 'hall'.
r room: 29 isa: 'hall'.
r room: 30 isa: 'clss'.
r room: 31 isa: 'snak'.
r room: 32 isa: 'snak'.
r room: 33 isa: 'clss'.
r room: 34 isa: 'clss'.
r room: 35 isa: 'clss'.
r room: 36 isa: 'clss'.
r rooms oo.
r worksIn: f.
m := Professor new: 'menzies'.
m worksIn: f.
"Professor worksIn: f."
f run.
!
