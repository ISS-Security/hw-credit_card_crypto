# Credit Card Crypto

This assignment requires you to try your hand out at a very common error checking (data integrity) algorithm, and also introduces you to very elementary cryptographic algorithms.

## Retrieving Files
1. Make sure to setup the git tool as we described in class (see online handout on 'Git Version Control'). Also, make sure to create your own RSA keypair and link your public key to Github. You can then clone any public project from Github onto your local machine.
2. Fork this project on Github (a copy is created in your Github account) using the 'Fork' button
3. Clone *your copy* of the forked project onto your local machine:
`$ git clone git@github.com:[your_username]/hw_3-credit_card_crypto.git`
4. Use the 'bundle' gem (which you should have installed earlier) to install all gems required for this assignment (listed in the `Gemfile`) onto your local machine: `$ bundle install`

## Working on Assignment
While working on this assignment, frequently save your work and push it back to your Github repo:

    $ git add .
    $ git commit -m "Enter meaningful description here"
    $ git push -u origin master

After the first time you have pushed using `-u origin master`, you can subsequently push it simply by doing:

    $ git push

Remember that all members of your team should attempt each part of the assignment and push your individual work to Github. *You may work together* and share code and ideas. However, *only one person should submit the assignment* (see details at bottom).

## Requirements

This project is in several parts (A-D). Make sure you ONLY do the part that is relevant to this week.

### A. Luhn Algorithm
You will write the algorithm used by financial institutions to check whether a credit card number is valid or not, by checking its last digit (checksum). This is done by using the [Luhn Algorithm](http://en.wikipedia.org/wiki/Luhn_algorithm). You can see this algorithm in action at any [online Luhn algorithm calculator](http://planetcalc.com/2464/).

1. Implement the file called `luhn_validator.rb`. There is one method you must fill out, called `validate_checksum()`. It must check a credit card number and return (`true`/`false`) whether the last checksum digit is correct.
2. Implement the file called `credit_card.rb` (see TODO comments):
  - mixin the LuhnValidator
  - initialize the instance variables
  - create a hash that converts the instance variables in a [JSON](http://en.wikipedia.org/wiki/JSON) string format

Make sure it passes the `luhn_spec` test that is provided:

    $ ruby spec/luhn_spec.rb

(run the spec file from the root directory of your solution)

And bench test the performance of your code by running the bench code:

    $ ruby bench/luhn_bench.rb

### B. Substitution Ciphers
Your team will implement three ciphers that we saw in class: the Caesar Cipher, Permutation Cipher and Double Transposition Cipher.

- Implement the `SubstitutionCipher` module in `substitution_cipher.rb`
  - Create encrypt and decrypt methods of both ciphers
    - all methods take plaintext `document` strings with characters are printable ASCII (ord 32-126)
    - all methods take a positive `key` integer
    - all methods return a string (encrypted or decrypted)
    - Make sure the decrypt method recreates the original document given before encryption!
  - Caesar cipher: there is not need to 'wrap' values -- just add/subtract the key to encrypt/decrypt (its ok if the resulting ordinal values are greater than 127)
  - Permutation cipher:
    - assume you can replace with any characters values from 0-127 (ord)
    - start by creating a lookup table of characters by randomly "shuffling" the numbers `(0..127)` using the key
      - See the `Array.shuffle(random: rng)` method
      - See the `Random.new(seed)` method
- Implement the DoubleTranspositionCipher in `double_trans_cipher.rb` (more hints in source file)
  - Write your own tests for the double transposition cipher `spec/crypto_spec.rb`:  Try writing these tests before coding!
  - Can you DRY out all the tests using metaprogramming as we saw in class? (DRY = Do not Repeat Yourself in code)

While coding, make sure it passes all the tests you are provided:

      $ ruby spec/crypto_spec.rb

Before submission, make sure it passes the style guide suggested by Rubocop:

      $ rubocop <your_ruby_file.rb>

### C. Advanced Crypto and Hashing
Your team must implement the AES cipher and Hashing.

#### C.1. AES Cipher:
Implement a modern cryptographic encryption method:
- `AesCipher` in `aes_cipher.rb`
- Write your own tests for the double transposition cipher `spec/crypto_spec.rb`:  Try writing these tests before coding!
- Can you DRY out all the tests using metaprogramming as we saw in class? (DRY = Do not Repeat Yourself in code)

#### C.2. Hashing
Your team must implement hashing methods for credit card objects. Recall that all objects in Ruby have a `hash` method by default. However, this method does not use the contents of their objects to produce hashes. Furthermore, this hash method cannot produce a cryptographically strong hash.

- Override the default hash: Override the default `hash` method of CreditCard to hash the serialized data of the card. Credit cards with identical information should produce identical hashes. Do not use any cryptographic hashing method here.
- Create a cryptographic hash: Implement the `secure_hash` method to produce a SHA256 hash (return a hexadecimal string). Credit cards with identical information should produce identical secure hashes.
- BUT FIRST: look at the hashing test specs in `spec/hash_spec.rb`
  - *Implement all the tests* that are shown (you are welcome to add your own as well)
  - make sure your implemented tests *all fail* before writing *any* code!
  - make sure they pass *one-by-one* while writing code :)
- We are coming to the end of this assignment -- time to do some cleanup:
  - Add references in `Gemfile` to all the gems you are using in your code and test files.
  - run the `rubocop` gem on your code to see if your code style is appropriate


## Submission
Please submit one solution for your team. You may simply submit the HTTP url of the git repository where we can find your solution.

### [Statistics on Credit Card use](http://www.creditcards.com/credit-card-news/credit-card-industry-facts-personal-debt-statistics-1276.php)
- [Total number of credit card transactions in the United States:](http://www.creditcards.com/credit-card-news/credit-card-industry-facts-personal-debt-statistics-1276.php#ixzz3VSrXbOYz)
  - 26.2 billion in 2012
  - 19 billion in 2003
