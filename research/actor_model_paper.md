title: "A Universal Modular Actor formalism for Artificial Intelligence"
subtitle: Notes, discussion questions, and reflections
tags: papersWeLove, cs, actorModel, CarlHewitt, PeterBishop, RichardSteiger
section: research
---

# Summary

This paper introduces the actor model to the world. It introduces the concept of the "actor." It explores the potential of actors in computing. It defines formally what actors are, and then int gives an example on how to apply it to PLANNER, the artificial intelligence research that Carl Hewitt's team was conducting at a time.

# The Actor Model

The actor model is a computing architecture that relies on a single object: the actor. This is an abstraction; as long as actors behave according to the rules, the implementation doesn't matter. The key behavior are sending messages between actors and that actors will behave the same way with every message.


The actor metaphor is used to emphasize the inseperability of control and data flow. [238]

Examples of special cases of  actors are data structures, functions, semaphores, ports, numbers, identifiers, databases, etc. Any programming concept can be abstracted into an actor. 

A more detailed definition of the behavior of actors happens in page 238 under the Hierarchies heading. It says that every actor has the following behaviors

  * Scheduler, that determines when the actor acts after a message has been sent
  * Intentions, confirming preconditions are satisfied
  * Monitoring, actors can have monitors that looks over each message sent to it
  * Binding, looking up values of names that occur within
  * Resource management, actors have a banker that gives them space and time

# Benefits of using the Actor Model

The paper has a series of lists that share many of the benefits from the actor model. They could roughly be categorized in conceptual and practical benefits. The main conceptual benefit is that by reducing computation to a single object with a well defined behavior you can formally derive the rest of computation. This should lead to easier ways for creating programs and understanding how they work via mathematical thinking.

They list a great number of practical benefits. Perhaps the most influential is how it simplified concurrent programming. But they don't stop there. They go on talking about how the model leads to natural structured programming, how it should be easier to teach, how it should improve the correctness of programs, and how it can improve privacy.


# Structure

The paper can be roughly divided in four parts. We have the informal definition of actors, followed by a more formal definition with notation examples. The paper then explains how to build logic and databases. This then leads to a discussion on how actors can be used in AI.

You can sense the exciting that the authors had for stumbling upon actors. At times the paper feels like the transcription of a group of friends listing all of the repercutions and possibilities that the actor model has. The paper can feel a bit disorganized because of this enthusiasm.

The paper feels whimsical for the number of quotes it uses to introduce different ideas. I counted 22 quotes. The quotes are from computer manuals, fellow computer scientists, Shakespeare, and Lewis Carroll. 

The paper more or less follows a pattern where a concept is defined followed by bullet lists. 

## Historical context

The actor model is born as part of artificial intelligence research at MIT. PLANNER was a computer language meant for proving theorems and manipulating models. It looks somewhat similar to Prolog.   

At the time "concurrent" and "parallel" programming seems to be used interchangably. They are mostly talking about what we call "concurrency," which is a single computer switching from process to process and executing a little bit of the code at a time. Yet there may have been some research or even some computers that were what we would call today "parallel." The paper talks about hardward possiblities of the actor model in this sense.

# Outline

Abstract

I. Defining Actors and exploring their potential
II. Formal and syntax definitions of actors
III. Fundamental Actors
  1. Logic
  2. Databases
IV. AI applications
  1. World invocations
  2. Relation with PLANNER and CONNIVER
  3. Substitution, reduction and meta-evaluation
V. Acknowledgements
VI. Bibliography


# Discussion questions

* How does it change your view of the actor model knowing that it is an abstraction?

* For those who know Erlang/Elixir or used an actor library like Akka, how is this definition different? How is it the same? 

* What benefits from the list have happened since the paper was published in the 70s? What didn't work?  

## Further questions

* How can Erlang be so close to the definition without the Erlang team being aware of it? 

* How big was the influence of smalltalk? Is it an abstraction of smalltalk? How is it different? 

* How is this different from OOP? Are OOP languages more or less cases of the actor model?


* Functional programming is often presented as an alternative, even the opposite of OOOP. Yet this paper seems to hint that OOP was also born from a mathematical context.
How did we get to believe that?

