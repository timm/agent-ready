# An introduction to agents #

## About the author ##

<em>Todd Sundsted has been writing programs since computers became available in convenient desktop models. Though originally interested in building distributed object applications in C++, Todd moved on to the Java programming language when it became the obvious choice for that sort of thing. In addition to writing, Todd is president of Etcee, which offers Java-centric training, mentoring, consulting, and development.</em>




## Introduction ##

The word agent has found its way into a number of technologies. It has been applied to aspects of artificial intelligence research and to constructs developed for improving the experience provided by collaborative online social environments (MUDS, MOOs, and the like). It is a branch on the tree of distributed computing. There are agent development toolkits and agent programming languages.

Hucksters claim that agents can sort your mail, buy you a car, and solve your distributed computing woes -- in one fell swoop. Agents have tremendous potential to be sure, but this claim is a little far fetched -- at least today.
What is an agent?

It's difficult to find a succinct definition for agent that includes all of the things that most researchers and developers consider agents to be, and excludes all of the things they aren't. I recommend you read [Is it an Agent, or just a Program? A Taxonomy for Autonomous Agents](IsItAnAgent.md) by Stan Franklin and Art Graesser for a thorough, well-thought-out classification scheme.

In this article, I'll limit myself to illustrating rather than defining.

Agents typically possess several (or all) of the following characteristics; they are:

  * Autonomous
  * Adaptive/learning
  * Mobile
  * Persistent
  * Goal oriented
  * Communicative/collaborative
  * Flexible
  * Active/pro-active



Agents also tend to be small in size. They do not, by themselves, constitute a complete application. Instead, they form one by working in conjunction with an agent host and other agents. In many ways, agents are of the same scope as applets. Small and of limited functionality on their own.

## Why study agents? ##

Agents make an interesting topic of study because they draw on and integrate so many diverse disciplines of computer science, including objects and distributed object architectures, adaptive learning systems, artificial intelligence, expert systems, genetic algorithms, distributed processing, distributed algorithms, collaborative online social environments, and security -- just to name a few.

Agent technology is significant because of the sustained commercial interest surrounding it. You've most likely heard of General Magic and Telescript, and maybe even IBM's Aglets Workbench (now called IBM Aglets SDK) and Mitsubishi's Concordia. Agent technology may not have hit prime time quite yet, but it does seem to be gathering its share of investment money. Take a gander at the Resources section for a host of other companies engaged in agent technology development.

Agent technology is also interesting for its potential to solve some nagging productivity problems that pester almost all modern computer users. Many agents are meant to be used as intelligent electronic gophers -- automated errand boys. Tell them what you want them to do -- search the Internet for information on a topic, or assemble and order a computer according to your desired specifications -- and they'll do it and let you know when they've finished.

## What problems do agents solve? ##

Agent technology solves, or promises to solve, several problems on different fronts.

Mobile agents solve the nagging client/server network bandwidth problem. Network bandwidth in a distributed application is a valuable (and sometimes scarce) resource. A transaction or query between a client and the server may require many round trips over the wire to complete. Each trip creates network traffic and consumes bandwidth. In a system with many clients and/or many transactions, the total bandwidth requirements may exceed available bandwidth, resulting in poor performance for the application as a whole. By creating an agent to handle the query or transaction, and sending the agent from the client to the server, network bandwidth consumption is reduced. So instead of intermediate results and information passing over the wire, only the agent need be sent.

Here's a related situation. In the design of a traditional client/server architecture, the architect spells out the roles of the client and server pieces very precisely -- up front, at design time. The architect makes decisions about where a particular piece of functionality will reside based on network bandwidth constraints (remember the previous problem), network traffic, transaction volume, number of clients and servers, and many other factors. If these estimates are wrong, or the architect makes bad decisions, the performance of the application will suffer. Unfortunately, once the system has been built and the performance measured, it's often difficult or impossible to change the design and fix the problems. Architectures based on mobile agents are potentially much less susceptible to this problem. Fewer decisions must be made at design time, and the system is much more easily modified after it is built. Agent architectures that support adaptive network load balancing could do much of the redesign automatically.

Agent architectures also solve the problems created by intermittent or unreliable network connections. In most network applications today, the network connection must be alive and healthy the entire time a transaction or query is taking place. If the connection goes down, the client often must start the transaction or query from the beginning, if it can restart it at all. Agent technology allows a client to dispatch an agent handling a transaction or query into the network when the network connection is alive. The client can then go offline. The agent will handle the transaction or query on its own, and present the result back to the client when it re-establishes the connection.

Agent technology also attempts to solve (via adaptation, learning, and automation) the age-old (not to mention annoying) problem of getting a computer to do real thinking for us. It's a difficult problem. The artificial intelligence community has been battling these issues for two decades or more. The potential payoff, however, is immense.
An agent architecture

In this column and in the next few down the road, I'm going to show you how to design and build an agent architecture. I'll concentrate on designing and implementing support for several of the agent characteristics mentioned earlier. Specifically, I'll consider the tactile characteristics of mobility and persistence, the social characteristics of communication and collaboration, and the cognitive characteristics of adaptation, learning, and goal orientation.

## Requirements ##

Before we explore these three areas in detail, we need to build the foundation. Let's take a look at the key requirements our agent architecture must satisfy:

  * An agent must have its own unique identity
  * An agent host must allow multiple agents to co-exist and execute simultaneously
  * Agents must be able to determine what other agents are executing in the agent host
  * Agents must be able to determine what messages other agents accept and send
  * An agent host must allow agents to communicate with each other and the agent host
  * An agent host must be able to negotiate the exchange of agents
  * An agent host must be able to freeze an executing agent and transfer it to another host
  * An agent host must be able to thaw an agent transferred from another and allow it to resume execution
  * The agent host must prevent agents from directly interfering with each other



These architectural requirements provide support for the tactile and social characteristics of supported agents. Explicit support is not provided for the cognitive characteristics.

## Conclusion ##

With the foundation in place, we're ready to erect the walls. In coming months, I'll explore each of the three groups of characteristics mentioned above -- the tactile, the social, and the cognitive. I'll begin with the tactile characteristics, so expect a demonstration of how to weave agent mobility into the framework as we develop it next month.

Before I finish, I thought I'd leave you with some guidelines that should help you determine where agent technology might find a home in your projects.

The most robust and well-developed areas of agent technology are those revolving around autonomy and mobility. Applications built around unreliable or intermittent network connections will almost certainly find benefit, as will applications that must perform offline processing.

Oddly enough, the weakest areas of agent technology (though not for lack of trying) are those that seem to receive the most hype -- the aspects related to intelligence. If your application requires intelligent agents, you'll probably need to wait a while longer to get them. The artificial intelligence community has been working diligently for over two decades on this single problem. Remember, a computer has to do a better, more accurate job at a given task than we're capable of, or we won't use it.