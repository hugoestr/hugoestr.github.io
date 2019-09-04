Testing and how we do it. 

We all claim that we do testing.
And then we don't.

TDD and Cucumber == Not having to hire QA

QA is a different mentality than a dev
the way a dev is different from info sec

They are different perspective. We are standing in different geographical 
places and doing different things


Dev are builders. The focus is to build and create.
For many, speed and delivery is also part of their mentality.

The big question is: Can we do it? How fast? 

Weakness: willing to be sloppy in quality and security in exchange for proof of concept and fast delivery. Creates a culture of speed and carelessness. 


Info sec are security. The focus is to protect. prevent attacks.

Their big question is: Can they hurt via traspassing? How much?

Weakness: the walls they create and make it impossible to get anything done. Creates a culture of suspicion instead of trust. 

QA is yet another perspective.

QA are safety inspectors. The focus is to verify. If infosec protects from others,
QA protects the company of themselves. 

Their big question is: Does it work? Can we break it?

Weakness: Too much caution can slow down introducing new features. Creates an overcautious and perfectionistic culture. 


For most people this is an idea situation. Many managers, either for lack of money or lack of knowledge, think that a dev can do all of these roles if they careful enough. This is unreasonable due to basic human psychology and the the greatest contraint of all: time. 

We don't like being wrong. So we may unconsciously not test in places where they might break. Or we may have so much tunnel vision due to trying to get the feature working in the first place that we can't simply see the other stuff.

But the greatest problem is time. We cannot be a developer and a QA or infosec person at the same time. It would be like asking an actor to be Romeo, Juliet, and another actor at the same time. The best they can do is to take turn with the different roles.

Keep in mind that you are not saving money by not hiring a QA or infosec pro. You are instead losing a dev when your engineers switch to doing QA or infosec. In fact, you have a very expensive QA analyst now.

And the time. Your developer can be working as such.

Dev developing: ---------- Feature B -----> ---- Feature A --> Feature B ----> Feature C
QA  testing:    -------- Feature A -------> Feature B -------> --- Feature A -[approved] ---- Feature B  - [approved]

Instead you get this:

-------- test Feature A -------> -------- dev Feature A ------->  --- Feature A -[hand over to supervisor or other dev to quickly test happy path. Pray nothing breaks horribly] --- Feature B dev ------>Feature B test-----> 


----

Axiom of business: management is always responsible for quality (even when they pretend that it is not)



--- 

Testing

We all claim we do. Most of us don't do it.

--> The rails way makes it hard to write fast test.

For fast unit tests you need dependency injection so that you can inject mocks to avoid calling the database. Rails is one of the rare mvc frameworks that hasn't moved towards DI adoption.

You are given the option of writing your own idiosyncratic rails app. Other devs won't be able to open the hood and start working right away. And it it will be weird because the new style is only enforced via "discipline."  

--> Integration tests are slow

Rails has a bias towards integration tests. That is fine. All integration tests are slow, though. So it makes it very hard to do TDD. If we need to deliver quickly, this goes away.

--> Cucumber tests are fragile

The last often cited tests that we have are cucumber tests. And these can be very fragile if we are changing the design of the UI. And again, they are very slow.

So what do you actually do?

The basic idea is the testing, any kind of testing, is better than no testing.

1. Create manual test plans

we can never escape some kind of manual testing. But if you are changing a lot of things, then we need to have plans ready so that you can share the checklist to others and have several people testing. Especially if you need to run regression tests to make sure that nothing broke.

This is a very cheap option in terms of development time. It is a very expensive option in terms of employee time. Since humans get tired and bored, the quality of the testing is suspect, so ideally need to put other humans to do the tests too to confirm that nothing has broken.

2. Transform key manual test into cucumber tests.


3. Start writing integration tests (Railsy tests)

Since the rails way is to test using a database, and we need integration tests in any case, you might as well break down and write these kinds of tests. 

So far I haven't been able to successfully add mocks to a rails 
