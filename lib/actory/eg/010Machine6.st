App reset; asynchronousOff.
m1 := Machine new: 'testmachine'.
m1 inspect.
m1 reset.
m1 start.
f1 := Factory new: 'testfactory'.
m1 step.
m1 factory: f1.
f1 run.
