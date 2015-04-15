


---



# Say "hello" to GRAPH #

"GRAPH", a tiny ascii GRAPH utility written by
by Alfred V. Aho, Brian W. Kernighan, and Peter J. Weinberger.
It is an example "domain-specific language" (DSL) where a new syntax shorthand is invented,
just for processing data for a particular example. [DSLs are very useful](http://en.wikipedia.org/wiki/Domain-specific_language).

Graph  inputs files that look like this:
```
label here's some stuff
bottom ticks 1 2 5 10
left ticks 1 2 10 20
range 1 1 10 20
height 10
width 30
1 2 *
2 4 * 
3 6 *
4 8 *
```

And outputs stuff that looks like this:
```
20    -----------------------|
      |                      |
      |                      |
      |                      |
10    -       *              |
      |    *                 |
      |  *                   |
2     *--|------|------------|
     1  2      5            10
         here's some stuff    
```
A sample implementation is supplied at
http://unbox.org/wisp/var/timm/09/310/lib/proj1/graph.awk .

Sample input files can be found at
http://unbox.org/wisp/var/timm/09/310/lib/proj1/eg .
For example
the above input file is actually
http://unbox.org/wisp/var/timm/09/310/lib/proj1/eg/1

To generate a graph, using GRAPH,
run
```
cd  trunk/lib/eg/graph
gawk -f graph.awk 1
```

Graphs can contain multiple lines, so you can generate bar
graphs as follows. This input:
```
label mean IQ
left ticks  0 10 20 30 40
height 20
width  30
3 1 *
3 2 * 
3 3 *
3 4 *
3 5 *
3 6 *
3 7 *
7 1 +
7 2 +
7 3 +
7 4 +
7 5 +
7 6 +
7 7 +
7 8 +
7 9 +
7 10 +
7 11 +
7 12 +
7 13 +
range 0 0 10 20
tags  3 boys 7 girls  
```
Generates this output (note the error message on line 1 saying that
"tags" is not found
```
?? line 26: [tags  3 boys 7 girls  ]
20    -----------------------|
      |                      |
      |                      |
      |                      |
      |                      |
      |                      |
      |               +      |
      |               +      |
10    -               +      |
      |               +      |
      |               +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
0     -----------------------|
                              
              mean IQ         
```

## Annoyances (which need to be fixed) ##
### Tags not supported ###

The current implementation does not add tags to bar
graphs. The above output should have been:
```
20    -----------------------|
      |                      |
      |                      |
      |                      |
      |                      |
      |                      |
      |               +      |
      |               +      |
10    -               +      |
      |               +      |
      |               +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
      |      *        +      |
0     -------|--------|------|
             boys     girls   
              mean IQ         
```
This desired output can be found at
http://unbox.org/wisp/var/timm/09/310/lib/proj1a/eg/6.want .

### Tedious specifications ###

Another tedious feature of the current implementation is that
the bar graphs have to be hard-coded using lines and lines of numbers.
Ideally, we should be able to write bar graphs using the following
shorthand:
```
label mean IQ
left ticks  0 10 20 30 40
height 20
width  30
range 0 0 10 20
tag 3 boys 7 *
tag 7 girls 13 +
```
## Quirks (that you should accept) ##

Your OO/functional/logical
versions of this this system should all produce the
same output as the reference system.
Except for the annoyances listed above,
the reference implementation should be treated
as "the" implementation.
This means that you must understand the reference system,
warts and all, in order to reproduce it in other languages.

## The Problem ##

The current version of GRAPH is broken, as revealed by the following
test engine:
```
cd proj1
make score
?? line 12: [tags  2 things]
?? line 26: [tags  3 boys 7 girls  ]
?? line 6: [tags  3 apples 10 oranges 16 pears]
?? line 5: [tag 2 things 7 *]
?? line 6: [tag 3 boys 7 *]
?? line 7: [tag 7 girls 13 +]
?? line 3: [tag 3 apple 7 *]
?? line 4: [tag 10 oranges 24 +]
?? line 5: [tag 16 pears 16 $]
   6 FAILED
   4 PASSED
```
That is, the current system fails 6 of its current tests. You need
to fix that. To do that, you'll need to:

  1. Understand the GRAPH system
  1. Set up the files
  1. Understand the test engine
  1. Understand what is causing the above failures
  1. Fix the implementation.

# An Object-Oriented Graph Reader #

Here is a partial description of an object-oriented
processor for Graph. This description is incomplete; e.g. the instance
variables shown below missing important concepts.  The challenge to
the reader is to fully emulate the
[Awk version of Graph](http://unbox.org/wisp/var/timm/09/310/lib/proj1/graph.awk).

## Tag ##
This OO-Grapher reads spec files like these:
```
label here's some stuff
bottom ticks 1 2 5 10
left ticks 1 2 10 20
range 1 1 10 20
height 10
width 30
1 2 *
2 4 * 
3 6 *
4 8 *
```
Each class in the  _Tag_ hierarchy process each different type of lines.
The root
of this hierarchy has a method that accepts a string and then asks its subclasses for
who should handle this string.
```
handlerOf: line
	   self allSubclasses do: [:class|	
	   		line ~ class handles ifTrue: [^class]].
        ^nil 
```
Each subclass of _Tag_ supports two methods _handles_ and
_line:for:at:_. The _handles_ class method returns a regular expression which
detects which lines it should handle.  If handler returns true, then
the
_line:for:at:_ instance method is called.

For example, this method recognizes lines like _width 30_:
```
! TagWidth class methods !
handles
	 ^'^\s*width\s+(\d+)\s*$'
!!
```
If this method recognizes a line, the following method parses the line
and passes the result to _graph_ (specifically, it sets the width of the
_graph_
```
! TagWidth methods !line: string for: graph at: line
	graph width: string asWords second asInteger.
!!
```
## Reader ##
The _Tag_  class processing is controlled by the _Reader_ class.
This class opens a spec file each line is passed to  _Tag_. To extend the reader
functionality, we should define _Tag_ subclasses, not _Reader_.

This class can be called like this:
```
|g r| 
g := Graph new.
r := Reader new lines: 'eg/graph/0' for: g.
g width oo.
```
The file _eg/graph/0_ looks like this:

After this method,  _aGraph_ will have been updated with the information read
from _specFile_.

## Graph ##

This class stores information about a graph, and formats it for the screen.
The graph holds a matrix of symbols. The graph is laid out that matrix, then
the matrix is dumped to the screen.

That is, that's what would happen if this was fully implemented.
## Range ##

This is a simple helper class that accepts a set of numbers and maintains
the maximum and minimum seen so far.