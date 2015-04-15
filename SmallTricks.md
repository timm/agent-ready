#summary Lots of useful Smalltalk tricks:
#labels Smalltalk101




---


# Finding Out More About Smalltalk #
## Smalltalk101 ##
<ul>
<li>The famous <a href='http://agent-ready.googlecode.com/svn/trunk/share/pdf/st-cheatsheet.pdf'>Smalltalk cheatsheet</a></li>
<li>List of <a href='http://agent-ready.googlecode.com/svn/trunk/share/pdf/commonMethods.pdf'>commonly-used methods</a></li>
<li>A beginner's <a href='http://www.cs.oswego.edu/~odendahl/manuals/smalltalk/tutorial/'>Tutorial on GST Smalltalk</a></li>
</ul>
## Mailing Lists ##
<ul>
<li> <a href='http://groups.google.com/group/comp.lang.smalltalk/topics'>General smalltalk discussion list</a>;</li>
<li> <a href='http://smalltalk.gnu.org/'>GNU Smalltalk home page</a></li>
<li> Archive of the <a href='http://lists.gnu.org/archive/html/help-smalltalk/'>GNU Smalltalk discussion list</a></li>
</ul>
## On-line Reference Material ##
<ul>
<li> <a href='http://www.gnu.org/software/smalltalk/manual-base/html_node/Base-classes.html#Base-classes'>Base class index</a></li>
<li> <a href='http://www.gnu.org/software/smalltalk/manual-libs/html_node/Method-index.html'>Method index</a></li>
<li> <a href='http://git.savannah.gnu.org/gitweb/?p=smalltalk.git;a=tree;f=kernel;h=ac812ee0c778f3e13eb4423a962f9385b8e98c6d;hb=360283245fea7f65ca51c9df0c86f494adc4bc1b'>Read the source code</a> (on the web);</li>

<li> Read the source code (locally):<br>
<pre><code>$ locate Array.st<br>
/opt/local/share/smalltalk/kernel/Array.st<br>
/opt/local/share/smalltalk/kernel/ByteArray.st<br>
/opt/local/share/smalltalk/kernel/CharArray.st<br>
/opt/local/share/smalltalk/kernel/RunArray.st<br>
</code></pre>
Now you can browse the raw syntax of the Smalltalk system. Hint: do not edit this source code.<br>
</li>
</ul>
## Books ##
<ul>
<li>A truly great book on <a href='http://stephane.ducasse.free.fr/FreeBooks/BestSmalltalkPractices/Draft-Smalltalk%20Best%20Practice%20Patterns%20Kent%20Beck.pdf'>Smalltalk best practices</a> by<br>
one of the great Smalltalk grand masters.</li>
<li>A very advanced book on <a href='http://www.amazon.com/Object-Oriented-Implementation-Numerical-Methods-Introduction/dp/1558606793/ref=sr_11_1/182-7961430-6156935?ie=UTF8&qid=1234352470&sr=11-1'>mathematical methods in Smalltalk</a>.</li>
<li> A <a href='http://www.canol.info/smalltalk/gnu_smalltalk_book.pdf'>beginner's book on GNU Smalltalk</a> (unfinished, just the first three chapters, constantly evolving)</li>
</ul>

# GNU Smalltalk = JASL (Just Another Scripting Language) #

When Smalltalk was first developed, interactive programming environment
were not very well developed. So Smalltalk invented its own.  You
gotta say, what they came up with was pretty impressive:
  * a truly great interactive debugger;
  * the ability to save disk images of the current state of the system.

Saving disk images is a really useful trick:
  * when you start up again, you are **exactly** where you where when you quit.
  * any slow start-up tasks can be done once, saved as an image, then instantly available in the future.

Since Smalltalk was built, the UNIX tools have been continually
improving. There are now a thousand UNIX tools that let you do a
thousand important tasks like diffs, simple version control, etc
etc.  The nice thing with those tools is that the tricks you use
in UNIX to help coding in Language A can be useful for Language
B,C,D,E.....

(For an example of such a trick, see the
[test suite system described below](#Test-Driven_Development.md).)

On the other hand, if you descend into the Smalltalk
interactive environment, the tricks you'll use are good for Smalltalk,
and nothing else.  And, speaking from years of experience, it is
not clear that what you win with the Smalltalk environment is really
worth the loss of the UNIX tools.

The final nail on the coffin (at least for me) is that if you enter
the Smalltalk environment, you tend to write everything in Smalltalk- even
if Smalltalk is not the best tool for the job. On the other hand,
if you stay at the UNIX level, you can mix and match Smalltalk code
with anything else written in any other language.

So my advice is to lever the GNU Smalltalk advantage: use Smalltalk like just any
other scripting language.

# Keep It Portable #

Try to keep things portable. GNU Smalltalk has many wonderful trucks
for defining methods and if you use them, you lose portability.
Define methods with

```
! Something class methods !

define Class Methods
!!
```
and
```
! Something methods !

define Methods
!!
```

# Directory structures #

I store my GNU Smalltalk source code in ".st" files.  For each file
`X.st`, there can be an example script `eg/X.st` that shows off how
to use that code.  And each `eg/X.st` file has a `eg/X.st.want`
showing the expected output. For example:

```
st
Makefile
0lib.st
1classes.st
ThisClass.st
ThatClass.st
eg/
	0lib.st
	0lib.st.want
	1classes.st
	1classes.st.want
	ThisClass.st
	ThisClass.st.want
	ThatClass.st
	ThatClass.st.want
```

As [describe below](#Test-Driven_Development.md), the `Makefile` shown above
implements a simple test suite system.
For know we ignore it and focus on the other files such as:
`0,1,2*.st`:
  * `0lib.st` stores general Smalltalk tricks (see [below](#0lib.md));
  * `1classes.st` defines news classes for this application;

All the above code is loaded by the `st` script:
```
gst *.st $*
```

Note that this loads the Smalltalk code in alphabetical order (so
`0lib.st` gets loaded before `1classes.st` before everything else).
This is why all the classes have to be defined in `1classes.st` before
the rest of the classes are defined.

# st #

The code `st` deserves a little more attention. If
called like this

```
./st
```

the system quits after the last `.st` file is loaded. On the other
hand, if called like this:

```
./st -
```

then the last _file_ loaded is standard input. This drops you into
an interactive read-eval-print loop where all your `*.st` files are
loaded:

```
./st -
GNU Smalltalk ready

st> 
```

Here, you run debug scripts and explore your code base.

# Test-Driven Development #

It is impossible to understate the impact of
[test-driven development](http://www.agiledata.org/essays/tdd.html), or
TDD, on model software development
methods.  In TDD, the test is king. Nothing happens without a test.
Tests are written before the code. Every part of the code has a
test.  Progress is scored by the number of passed tests. When adding
new code, it is possible to check if the new code plays well with
the existing code by re-running all the tests.

Not to be overly dramatic, but this little test system has changed
my life. Now, I no longer tackle large and complex programming tasks.
Instead, I build
things by working on the next simplest test. In this way, I sneak
up on complexity and eat away at it, one little test at a time.

But how does it work?  In order to judge if a test is passed, some
expectation is required. In my code, if the test is in `eg/X.st`
then that expectation is stored in `eg/X.st.want`.

There are some standard tasks associated with running multiple tests:

<dl>
<dt><tt>make tests</tt></dt>
<dd>Run all tests, printing PASSED/FAILED</dd>
<dt><tt>make score</tt></dt>
<dd>Run all tests, the return a score of PASSED / FAILED tests.</dd>
</dl>

For `tests` and `score` to work, we first need to  work on individual
tests. To build a test, first write some Smalltalk code into (say)
`eg/abc.st`. Then:

<dl>
<dt><tt>make X=abc.st run</tt></dt>
<dd>Run the test <code>eg/abc.st</code> and compare the output to <code>eg/abc.st.want</code>.</dd>
<dt><tt>make run</tt></dt>
<dd>Run the default test (for <code>0lib.st</code>).</dd>
<dt><tt>make X=abc.st cache</tt></dt>
<dd>Create an expectation for test <code>eg/abc.st</code>. This code is shorthand for<br>
<code>make X=abc.st run &gt; eg/abc.st.want</code>. </dd>
<dt><tt>make X=abc.st test</tt></dt>
<dd>Run one test, printing PASSED/FAILED. Note that <code>test</code> fails if you<br>
have not first <code>cache</code>d an expectation for a test.</dd>
<dt><tt>make test</tt></dt>
<dd>Run the default test (<code>X=abc.st</code>). Note that <code>tests</code> fails if any test<br>
lacks a <code>cache</code>d expectation. </dd>
</dl>

# Initialization #

Write an instance method that sets up whatever you like.

```
! SomeThing methods !
init
	maxErrors := 20.
	rand := Random new.
!
```

Then change the class constructor such that a side-effect of
`Something new` is a call to `init`.

```
! SomeThing class methods !
	^super new init 
!!
```

# Re-Initialization (and `Managers`) #

The above initialization code creates a random number generator. How
can we write expectations for test suites  that generate random
numbers? Won't _every_ output be different cause it comes from a
Random number generator?

One way to handle this is to store the Random number `seed` used
to initialize the Random number generator. Then, before running a
test, reset the random number back to that initial seed.

This code is handled by a little class I call a `Manager`. This
class stores a set of workers (who all know their `Manager`) and a
random number generator.  Note that the `Manager` stores the random
number seed used at Manager creation time.

```
#Manager isa: Object with: 'seed workers rand'!

! Manager methods !
init: seed0
    seed    := seed0.
    workers := OrderedCollection new.
    rand    := Random seed: seed
!
worker: aWorker
    "Tell this manager/worker that they work together."
    workers add: aWorker.
    aWorker manager: self.
!
reset       self init: seed.  !
rand        ^rand next !
workers     ^workers !!

! Manager class methods !
new: seed       ^super new init: seed  !
new             ^self new: Random next !!
```

The following test case (in `eg/Manager.st`)  creates a manager,
generates  a random number, resets the random number generator, then
generates another random number.  Note that anything that is _managed_
also needs to have a `manager:` method:

```
#Worker isa: Object with: 'manager'
! Worker methods !
manager: m           
    manager := m !!  

|m|
(m := Manager new: 1)
  worker: Worker new;
  worker: Worker new.
m rand oo. 
m reset.
m rand oo. 
```

The output from all this is two identical random numbers (one before
and one after the reset).

```

---| Manager.st |-----------------------------------------

0.9171308690958568
0.9171308690958568
```

In summary, the `Manager` class is a useful top-level driver of a
community of workers in a simulation that all share the same random
number scheme.

# From Short-cuts to Domain-Specific Languages #

There are no pre-defined keywords in Smalltalk- if you application
repeatedly uses some arcane looping algorithm, you can code it up
as a new keyword. This means that, after that, that complexity can
be buried inside a one-line method call.

For example, suppose that processing a list of items is different
for the _first_ item than for the _rest_. Easy to code:

```
! SequenceableCollection methods !
first: first then: then
         | atFirst |
         atFirst := true .
         self do: [:elm |
               atFirst ifFalse: [then  value: elm]
                       ifTrue:  [first value: elm].
               atFirst := false] !!
```

For another example, consider all the tasks associated with processing a
file. First you have to open it. Second, you have to loop over all lines.
Finally, you must take care to close the file after you are done. Why
not batch all that up into one method?

```
! String methods !
fileLinesDo: aBlock
    |f last|
    f := File name: self.
    f readStream linesDo: [:line|
        last := aBlock value: line].
    f readStream close.
    ^last !!
```

The following code calls `filesLinesDo:` to print each line number
and each line:

```
|i|
i := 0.
'eg/0lib.st' fileLinesDo: [:line| 
   i := i + 1.
   (i s, ':', Character tab s, line ) oo].
```

To say the least, Smalltalk is very open to this kind of modification
to the language.  For example, `0lib.st` contains code that simplifies
class and method creation:

```
#Fred isa: Object with: 'name age '
```

To see why this is interesting, just review the standard Class creation method:

```
Object subclass: #Fred
          instanceVariableNames: 'name age'
          classVariableNames: ''
          poolDictionaries: ''
          category: nil !
```

Tedious, isn't it?
For an even larger reduction in what-you-have-to-code, the `getSets` method
auto-generates methods for making all the instance variables
of a class publically setable and accessible:

```
Fred isPublic
```

Without `isPublic`, the programmer would have to type:

```
! Fred methods !
name
    "Answer the receiver's name."
	^name
!
name: aValue
  	"Set the receiver's name." 
	name := aValue
!
age
    "Answer the receiver's age."
	^age
!
age: aValue
  	"Set the receiver's age." 
	age := aValue
!!
```
As before, my comment is that this is incredibly tedious and I never want to have to manually type this nonsense ever again.

If you keep looking for common patterns in your work, and replacing them
patterns with the short-cuts, then
you'll find your design notations and your
methods starting to merge. This leads to a style of development
called either
[domain-specific languages](http://courses.ece.ubc.ca/571f/lectures.html) or
[language-oriented programming](http://en.wikipedia.org/wiki/Language_Oriented_Programming).
  * Old school: solve problems in general-purpose programming languages;
  * New school: the programmer creates one or more domain-specific programming languages for the problem first, and solves the problem in those languages.

# 0lib #

Many of the tricks in `0lib.st` were described above. Here are the ones we have not meet yet:

## Silent Garbage Collection ##
```
ObjectMemory gcMessage: false  !
```

## Convenient Debugging ##

This code simplifies printing data onto the screen.
The following methods are described for all objects:
<dl>
<dt><tt>X o</tt></dt><dd>Print <code>X</code> on the screen. Returns <code>X</code>;</dd>
<dt><tt>X oo</tt></dt><dd>Like <code>X o</code>, but the print is followed by a new line;</dd>
<dt><tt>X s</tt></dt><dd>returns <code>X</code> as a string.</dd>
</dl>

```
! Object methods ! 
o       ^self s display   !   
oo      ^self s displayNl !
s       ^self displayString !!
```

## Handling Nils ##
`ifNil` is false for most objects, but true for undefined objects.
And `notNil` has the reverse meaning.

```
! UndefinedObject methods !
ifNil:  aBlock          ^aBlock value !
notNil: aBlock          ^self !!

! Object methods !
ifNil:  aBlock          ^self !
notNil: aBlock          ^aBlock value !!
```

## Fast Method Creation ##
Discussed above.
```
! Class methods !
isPublic
    |getter setter|
    self instanceVariableString asWords do: [:what |
        getter := '%1 [
            "Answer the receiver''s %1."
            ^%1 ]' % {what} .
        setter := '%1: aValue [
            "Set the receiver''s %1."
            %1 := aValue ]' % {what} .
        self compile: getter; 
             compile: setter.
    ]   
!!
```
## Fast Class Creation ##
Discussed above.
```
! Symbol methods !
isa:  dad 
     ^dad subclass: self       instanceVariableNames: ''
          classVariableNames: '' poolDictionaries: ''
          category: nil !
isa: dad with: vars
     ^dad subclass: self       instanceVariableNames: vars
          classVariableNames: '' poolDictionaries: ''
          category: nil !
isa: dad with: vars shares: classVars
     ^dad subclass: self
          instanceVariableNames: vars classVariableNames: classVars
          poolDictionaries: ''        category: nil 
!
asObject
    ^Smalltalk at: self !!
```

# Just Enough Objects #

Smalltalk seems like a big system. But for 90% of your work, you'll only
need the following classes.

```
Object                                     | one ring to rule them all
    Behavior
        ClassDescription
            Class                          | Class is an instance of MetaClass
            Metaclass                      | MetaClass is an instance of itself
    BlockContext                           | eg. [ 30 > 3 ]
    Boolean
        False                              | has one instance: false
        True                               | has one instance: true
    Iterable
        Collection
            Bag                            | like a dictionary, keeps counts
            HashedCollection
                Dictionary                 | hash tables of key,value pairs
                    ...
                       SystemDictionary    | has one instance: Smalltalk
                Set                        | no ordering, no repeats
            SequenceableCollection
                ArrayedCollection
                    Array                  | fixed size, can not grow
                    CharacterArray         | collections of characters
                        String
                            Symbol         | a memory efficient string
                    Interval               | start to stop by step
                LinkedList                 | an old friend
                OrderedCollection          | can grow
                    SortedCollection       | always keeps itself sorted
        Stream                             | pointers into a collection
            FileDescriptor
                FileStream
            PositionableStream
                ReadStream
                WriteStream
                    ReadWriteStream        | the great coin-toss 
            Random                         | Random Number generation
    FilePath
        File
    Magnitude                              | anything that supports "<"
        Character
        Date
        LookupKey
            Association	                   | key-value pairs
        Number
            Float
            Fraction
            Integer
                SmallInteger
        Time
            Duration
    UndefinedObject                        | has one instance: nil
```