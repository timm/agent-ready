|g r| 
g := Graph new.
r := Reader new lines: 'eg/graph/5' for: g.
g frame.
g writeticks.
g writedata.
g writelabel.
g draw.
!
