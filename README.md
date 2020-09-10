# StringCalculator Katas TDD

This kata is one of the simplest and best ways to practice step-by-step fluent tdd, and provides an easy way to get proficient in a language.

Write a method add under an object StringCalculator that, given a delimited string, returns the sum of the numbers in the string.

- An empty string returns zero '' => 0
- A single number returns the value '1' => 1 '2' => 2
- Two numbers, comma delimited, returns the sum '1,2' => 3 '10,20' => 30
- Two numbers, newline delimited, returns the sum '1\n2' => 3
- Three numbers, delimited either way, returns the sum '1\n2,3\n4' => 10
- Negative numbers throw an exception with the message '-1,2,-3' => 'negatives not allowed: -1,-3'

**stop here if you are a beginner. Continue if you can finish the steps so far in less than 30 minutes.**

- Numbers greater than 1000 are ignored
- A single char delimiter can be defined on the first line starting with // (e.g //#\n1#2 for a ‘#’ as the delimiter)
- A multi char delimiter can be defined on the first line starting with // (e.g. //###\n1###2 for ‘###’ as the delimiter)
