
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

# January 17, 2014

* Tyler (TA): tcn2@duke.edu
* Come early too, parking near the Gray building is hard to get
	- The classroom is small and the door is at the front
	- You want to sit at the front to get a good view of the blackboard
* Setting up DrRacket
	- DrRacket -> Other Languages -> Full Swindle
	- At top, enter
		> (require racket/base)

## Induction

**Induction steps**
1. State property to be proven and induction variable
2. Prove inductive step
3. Prove base case

Example:
For all n >= 0,
	1 + 2 + 3 + ... n = n(n + 1)/2
Assume 1 + 2 + ... k = k(k + 1)/2 for some k
	Add k + 1 to both sides
	1 + 2 + ... + k + k + 1 = k(k + 1)/2 + k + 1
	(k + 1)((k + 1) + 1)/2 = (k + 1)(k + 2)/2
If you can get from k to (k + 1), we can get to anything.

The above example is an example of weak induction. Depending on the problem, weak or strong induction may be preferable. If weak doesn't work, try strong and vice versa.

Let's examine a strong induction example:
**Fibonacci**
	F(0) = 0
	F(1) = 1
For all k > 1, F(k) = F(k - 1) + F(k - 2)

**Q: For any x, F(x) < 2^x**
Suppose for all k < x, F(k) < 2^k
	F(x - 1) < 2^(x - 1)
	F(x - 2) < 2^(x - 2)
We know F(x) = F(x-1) + F(x-2)
	F(x) < 2^(x-1) + 2^(x-2)
	F(x) < 2^(x-1) + 2^(x-1)
		 = 2(2^(x-1))
		 = 2^x
    F(x) < 2^x
Base cases:
	x = 0, 1

**Proving scheme programs with induction**
* Scheme is different from Python and Java beacuse you can prove a program

Factorial n = n! = n * (n - 1) * (n - 2) ...
(define factorial
	(lambda ((z <integer>))
		(if (zero? z))
			1
			(* z (factorial(- z 1)))))
We'll use the substitution model to prove
Inductive step:
	Given z > 0, suppose for all k < z
		(factorial k) ==> k!
	(foctorial z) ==>
		(if zero? z)
			1
			(* z (factorial(- z 1)))
		
		(zero? z) ==> #f //since z > 0

		(* z (factorial (- z 1)))
		(* z (factorial (z - 1))
		(* z (z -1)!)
		(mult z {z - 1!})

Base case:
	(factorial z) ==> (if zero? z) 1 (* (factorial(- z 1)))
		(if zero? z) ==> returns #t
			returns 1

## Tail Recursion

* If the last thing the function does is call itself recursively, it has no deferred operations

```
(define factorial-1
	(lambda ((z <integer>)))
		(if (zero? z))
			1
			(* z (factorial(- z 1)))
```
This example is not tail recursive. It will fail at large inputs

```
(define factorial-2)
	(lambda ((z <integer>)))
		(letrec loop // the name of the function
			(lambda (n <integer>) (result <integer>)))
			if (zero? n)
				result
				(loop(- n 1)) (* result n)
			(loop z 1)
```
So, iter is basically just a name of the loop.
So this is sort of what happens:
	(factorial-2 4)
	(loop 4 1)
	(loop 3 4)
	...
	(loop 0 24)

**Using let NAME instead of letrec**
	(let NAME (((v1 Exp1) ... (vn Expn) BODY)))
```
(define factorial-3
	(lambda (z <integer>))
		(let loop ((n z) (result 1)))
			(if (zero? n))
				result
				(loop (- n 1) (* result n)))
```

**Fibonacci numbers**
Standard method
```
(define fib-1
	(lambda ((n <integer>)))
		(if (< n z))
			n
			(+ (fib-1 (- n 1)))
				(fib-1 (- n 2))))
```

How many state variables do you think we need? 2. For the previous two values.

The following is quite hard (as acknowledged by Tyler)
```
(define fib-2
	(lambda ((prev) (last) (n)))
		(if (zero? n))
			// some stuff
		(fib-2 (last) (+ prev last) (- n 1)))
```

| n  |  Prev  | Last |
|----|--------|------|
| 6  |  0     |   1  |
| 5  |  1     |   1  |
| 4  |  1     |   2  |
| 3  |  2     |   3  |
| 2  |  3     |   5  |
| 1  |  5     |   8  |
| 0  |  8     |  13  |

# January 19, 2014

To get the type of an object
> (class-of x)

