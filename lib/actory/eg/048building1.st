|b f m c k t|
App reset; asynchronousOn.
b := Building new: 'csee'.
f := Floor new: 'ground'.
f room: 1  isa: 'offc'.
f room: 2  isa: 'conf'.
f room: 3  isa: 'conf'.
f room: 4  isa: 'conf'.
f room: 5  isa: 'clss'.
f room: 6  isa: 'clss'.
f room: 7  isa: 'offc'.
f room: 8  isa: 'hall'.
f room: 9  isa: 'hall'.
f room: 10 isa: 'hall'.
f room: 11 isa: 'hall'.
f room: 12 isa: 'clss'.
f room: 13 isa: 'offc'.
f room: 14 isa: 'hall'.
f room: 15 isa: 'strs'.
f room: 16 isa: 'rest'.
f room: 17 isa: 'hall'.
f room: 18 isa: 'clss'.
f room: 19 isa: 'offc'.
f room: 20 isa: 'hall'.
f room: 21 isa: 'elev'.
f room: 22 isa: 'rest'.
f room: 23 isa: 'hall'.
f room: 24 isa: 'clss'.
f room: 25 isa: 'offc'.
f room: 26 isa: 'hall'.
f room: 27 isa: 'hall'.
f room: 28 isa: 'hall'.
f room: 29 isa: 'hall'.
f room: 30 isa: 'clss'.
f room: 31 isa: 'snak'.
f room: 32 isa: 'snak'.
f room: 33 isa: 'clss'.
f room: 34 isa: 'clss'.
f room: 35 isa: 'clss'.
f room: 36 isa: 'clss'.
f worksIn: b.
m := Professor new: 'menzies'.
c := Professor new: 'cukic'.
k := Professor new: 'katerina'.
t := Professor new: 'tanner'.
m worksIn: b.
c worksIn: b.
k worksIn: b.
t worksIn: b.
b run.
!
