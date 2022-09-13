# findstresses
Look for words with the right pattern of syllabic stresses

## stress2words usage

A dash (`-`) represents a stressed syllable.
A period (`.`), unstressed. 

* Show words that begin with the letter B and have the same stress
  pattern as the morse code for the letter 'B' (dah-dit-dit-dit).

  ```
   $ ./stress2words b-...
   BENEFITING B EH1 N AH0 F IH0 T IH0 NG
   BENEVENTO B EH1 N AH0 V EY0 N T OW0
   BROKERAGE'S B R OW1 K ER0 IH0 JH IH0 Z
   BROKERAGES B R OW1 K ER0 IH0 JH IH0 Z
   ```
 
## word2stresses usage

 * Show the rhythm of stresses in the word Dracula:
   ```
     $ ./word2stresses dracula
     DRACULA -..
   ```

## Data sources
The fundamental source used is the [CMU Pronouncing
Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) which lists
which syllables are normally stressed in a word. However, the cmudict
corpus includes tons of what appear to be last names: BETTENHAUSEN,
BONEBERGER, BUDDENHAGEN, etc. So, I reduced it it by keeping only the
most common words, as reported by the
[SCOWL](http://wordlist.aspell.net/) word lists. To search the full
corpus, use the -f flag, as in `stress2words -f b-...`.

## Secondary stresses
The CMU dict embeds numbers representing stress for each syllable. 
0 means unstressed; 1, primary stress; 2, secondary stress. For example:

    BEYONCE  B IH0 Y AO2 N S EY1

Currently words with secondary stress (Aardvark, Beyonce, Zulu) are not returned
for normal `stress2words` searches with a dash (`-`). However, the user can request
that either primary or secondary stress be allowed by using a tilde (`~`) instead of a dash.
Although I am not sure why you would want to, one can force only secondary stress to match by
using an equals sign (`=`). And, again, I don't know why this would be desired, but one
could also search for either a secondary stress or unstressed syllable by using underscore (`_`).

## One word can have multiple rhythmic meters

<!-- for word in $(grep '(1)' cmudict-0.7b | awk '{print $1}' | grep -o "[A-Z']*"); do ./word2stresses "$word"; done | sort | uniq -c | awk '{print $2}' | sort | uniq -c | sort -n | awk '{print $1}' | uniq -c -->

The word2stresses program will usually output only a single line, but
it can output multiple lines if there are different ways a word can be
stressed. For example, 

    $ ./word2stresses rocard
    ROCARD -.
    ROCARD -~
    ROCARD ~-
    ROCARD .-

97% of the 134,429 words in the CMU dictionary have only one stress
pattern.

| Number of unique patterns | Count of words |
|:-------------------------:|---------------:|
| 1 pattern                 |        131,546 |
| 2 patterns                |          2,856 |
| 3 patterns                |             26 |
| 4 patterns                |              1 |
|:-------------------------:|---------------:|
| Total                     |        134,429 |

## BUGS

### Ought to omit or flag words with multiple stress patterns. 

For example: "yourself" is not useful for a Morse mnemonic as it can
be stressed in two different ways.

	$ ./word2stresses yourself
	YOURSELF .-
	YOURSELF -.
    
## Should not output redundant stresses.

On rare occasions, word2stresses will print out repetitive stress
patterns. For example, the word "whitening":

     $ ./word2stresses whitening
     WHITENING -..
     WHITENING -.
     WHITENING -..
     WHITENING -.
 
### Perhaps not suitable for Morse Code mnemonics at all.

Hackerb9 wrote this program to create mnemonic words for each letter
in the Morse Code alphabet. That works fine for small codes, like
dit-DAH (letter 'A' is "a-WAY"). However, a longer code like
DAH-dit-dit-dit (letter 'B') has a list of words which aren't very
memorable. How is one to remember that the key word is "BENIFITING",
and not "BENEFIT"? Or, "BROKERAGES" and not "BROKERAGE"?

What we need is a poet. 

## See also

* [morsemnemonics.md](morsemnemonics.md) contains a list of possible
  mnemonics for Morse Code created using the words suggested by these
  programs.

* `morse` from BSD games package for encoding and decoding morse code.
  * `morse -s <<<"Hello World!"`
  * `morse -d <<<".... . .-.. .-.. ---"`


* `cw` command for learning morse code by beeping the speaker. 
  
  Note that the default speed is a little too low to learn the rhythm
  of the beeping. Also, the default volume is 100%, so you'll want the
  `-v` option. I suggest learners use 18wpm speed of each letter, but
  with a Farnsworth gap so that each letter is distinct.

  * `cw -v 20% --wpm=18 --gap 5 <<<"Hello World!"`
 
