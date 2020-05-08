# Programming Languages: A Language-Agnostic Approach

## Target Area 

The book will cover the principles of programming languages. This course is still a required course in the majority of universities. 

## Target Audience

The book is targeted at undergraduate students in their third or
fourth year. An instructor could also use it for the introductory part
of a graduate course in this area. ~~ Off-campus individuals will also
be able to use the book for self-study.  These individuals will get to
know a prevalent approach to the study of semantics in contemporary
papers, just like *Types and Programming Languages* is used to study
the principles of types. 

## How the Book Differs From Any Other Book in the Same Area 

### The book will develop a series of abstract state machines to explain the meaning of ideas.

**Rationale** The existing books push interpreters, which are
highly recursive functions, something that most undergraduates
are afraid of, even in their junior or senior year. Alternatively, 
existing books use highly recursive mathematical relations, which 
students are equally resistant to us. 

While the book will rely on some recursion, the amount will be drastically
reduced---without taking away anything. Instead the book will use the 
familiar notions of plain loops, covered well in all existing 
undergraduate programs. 

For students who go on to graduate schools, they are as likely to
encounter in contemporary papers as they will see "interpreters"
or the above-mentioned relations. The book will help them grow into this niche
anyway.

**Technical** The course starts from what students know as a
"calculation language" in grade school (arithmetic) and move to
an "advanced calculation language" (algebra). The state machines
for these "programming languages" are what they know from their
homework: step-by-step calculations, reducing an expression to a
final answer. From there, the book will gradually move to functional and
object-oriented programming concepts---generalizng what students know from K-12.

**Background** The material exists. It is Part I of the *Semantics 
Engineering* book.  To create the text, I will rewrite the existing 
words to language that is suitable for undergraduates. 


### The book will be language-agnostic.

**Rationale 1** For years, students in
upper-level courses have expressed a strong
preference to use the languages that they think they know best. I have collected statistic on this wish, and
it has been steady for years.

In many courses, students exhibit a stronger desire to learn when
given the chance to use their favorite language than when forced
to use the instructor's favorite language.

In a course on programming languages, the instructor can use this
diversity of language choices to illustrates points during lecture
and in homework assignments.

**Technical 1** 

1. The book will use a simple notation for presenting machine states and tables for representing transitions from one state to another. This approach is similar to the one used in books on hardware and is somewhat familiar to many students from such courses. What we will not tell students is that this notation is rooted in mathematics. They will likely think that it is just a langauge for representing data. 

2. The problem sets will use the JSON data language, which burst on the scene about a decade ago and has become the de facto language of data exchange in all modern software systems. Every "favorite" language of students will also support this data language, and it is thus easy to stay language agnostic.

**Rationale 2** JSON is a suitable compromise. Students wish to see a notation that has something "real" about it. JSON isn't as real as proper syntax but to students it "feels" more real than S-expressions as they are used in, for example, Essentials of Programming Languages and its many on-line derivatives. It isn't as real as actual language syntax, but for that, the use of JSON greatly reduces the complexity of parsing --- an old and non-principled topic. The time save from using simple parsing will be spent on important principles. 

Again, I have surveyed students for years. Students love to work with JSON, simply because they think it is realistic. 

**Technical 2** To get across the "irrelevance" of surface syntax to the study of principles, the book will include an exercise set on parsing from S-expressions to the same internal representation of programming languages. 

## Similarities to Other Books 

Naturally the book will cover principles like those covered in other books. 

The emphasis in topics will differ, which is also natural because different authors see different topics in a different light. 

The emphasis in examples though will be on the kinds of languages that young students love (JavaScript, Python, Rust) rather than those that are prominent at PL conferences. 


## Support Material 

The accompanying material, hosted at a web site, will assist instructors with
implementing the course:

- sample code in at least four different styles, written in Racket: 

  - functional, typed and untyped
  - object-oriented, typed and untyped

  which covers 99% of the spectrum of styles students choose. 
  
  Ambitious instructors can then easily add versions written in their own favorite languages. 

- sample projects that are easy to vary over time

- software for running and evaluating student solutions
