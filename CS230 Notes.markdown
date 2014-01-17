
# January 8, 2014

* [CS 230](www.cs.duke.edu/brd/Teaching/dm/)
* [Office hours](http://www.cs.duke.edu/brd/Teaching/dm/announce.shtml)

* Come early, parking is hard to find and is going to be located far away. 

People in the class:
	* Sam Slezack is in this class.
	* So, is Poo Yi Hong.

For the first 10 lectures,
	* Mechanical proof, Logic
	* λ-calculus
	* Substitution model
	* Halting Problem
	* Scheme (a programming langague)
	* Iteration, Recursion, Induction
	* Mathematics of functional programming
	* Map Reduce / Hadoop
	* Order of growth, RSA, Graph Theory, 

**Computational processes**
	* Algorithms
	* Imperative knowledge
**Mathematics**
	* Declarative knowledge

**Algorithmic or Computational Knowledge**
	* Herem of Alexandria ~ 100 AD
	* To find sqrt(x)
	1. Make a guess g >= 0
	2. Improve guess by averaging g and x/y
	3. Stop when g is good enough.
		* How? When |g^2 - x| is small

**Rules of Scheme / Grammar / Syntax**
	* "Prefix-ordered fully parenthesized"
	* Java is ambiguous `4 + 5 * 2`
	* Scheme is not `( + 4 ( x 5 2 ) )`
	* Everything in scheme is an expression
	* Every expression has a value
	* Use hyphens in lieu of underscores
	* A cycle of evaluation and application

An expression is either
	* a primitive
		* 1
		* -31
		* "a string"
		* x
		* a-long-var-name
	* a combination
		* One or more expressions 
		* Enclosed in parentheses
		* Separated by spaces
		* ( + 3 5)
		* (gcd ( + 5 1 8) 6)
		* (operator operand1 operand2 operand)

# January 12, 2014

* **REPL**
	- *read-eval-print-loop* 
* Declarative knowledge
	- What is
* Imperative knowledge
	- How to

# January 13, 2014

* Use "Full Swindle" in Racket
* The [] and () symbols are only to show *eval* and *apply* in writing. It is not done in writing.

# January 15, 2014

* Both times-1 and times-2 are syntatically recursive
* Recursive process (times-1)
	- Deferred operations
* Iterative process (times-2)
	- Iterative process
	- No deferred operations
	- Constant space
	- Tail-recursive
* NOS
	- "Need only show"





















