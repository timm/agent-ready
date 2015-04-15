![http://agent-ready.googlecode.com/svn/trunk/share/img/gangMedium.png](http://agent-ready.googlecode.com/svn/trunk/share/img/gangMedium.png)

What is an agent, and how can we reduce the cost of their construction?

Here we explore methods to rapidly produce software suitable for use in agent-oriented software.

Specifically, we are assessing the value of _CSOEL_ (pronounced "see-soul") for designing
adaptive agents. _CSOEL_ combines software engineering with data miner to generate systems that can learn and adapt from experience. The components of _CSOEL_ are:

  * C= choice: the space of options available to the program, at runtime
  * S= services: the stuff that does the work when choices are made
  * O= oracle: the thing that scores what happens when the services are performed
  * E= experience: the database of choices and the oracle scores.
  * L= learning: the thing that reflects over the experience  to bias us towards better choices in the future.

The theory, to be tested here, is that all the above is very simple to implement. We've learned enough about incremental data mining, minimal contrast set learning, etc etc such that it is not too hard to map the above into a variety of implementations. To prove that, I'm going to run a set of graduate subjects which will implement _CSOEL_ in a variety of languages:

  * Smalltalk (agent-ready objects). This is our 2009 goal.
  * Gawk (agent-ready scripting) by June'10
  * Lisp (agent-ready functions) by Dec'10
  * Prolog (agent-ready logic) by June'11

We will declare the experiment a success if _CSOUL_ is not too simple and not too complex to implement:

  * If it is too simple, then  _CSOUL_ is trite.
  * It it is too complex, then _CSOUL_ is not mature enough for prime-time usage.

Watch this space.