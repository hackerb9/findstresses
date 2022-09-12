# findstresses
Look for words with the right pattern of syllabic stresses

## Example usage

A dash (`-`) represents a stressed syllable.
A period (`.`), unstressed. 

* Show words that begin with the letter B and have the same stress pattern as the morse code for 
  the letter 'B' (dah-dit-dit-dit).
  ```
   ./stress2words b-...
   BENEFITING B EH1 N AH0 F IH0 T IH0 NG
   BENEVENTO B EH1 N AH0 V EY0 N T OW0
   BROKERAGE'S B R OW1 K ER0 IH0 JH IH0 Z
   BROKERAGES B R OW1 K ER0 IH0 JH IH0 Z
   ```
 
 * Show the rhythm of stresses in the word Dracula:
   ```
     ./word2stresses dracula
     DRACULA -..
   ```
   
## Data sources
The fundamental source used is the 
[CMU Pronouncing Dictionary](http://www.speech.cs.cmu.edu/cgi-bin/cmudict) which
lists which syllables are normally stressed in a word. However, the cmudict corpus
includes tons of what appear to be last names: BETTENHAUSEN, BONEBERGER, BUDDENHAGEN, etc. 
So, I reduced it it by keeping only the most common words, as reported by the 
[SCOWL](http://wordlist.aspell.net/) word lists. To search the full corpus, use
the -f flag, as in `stress2words -f b-...`.

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

## BUGS

### Ought to avoid or flag words with multiple stress patterns. 

For example:

    YOURSELF  Y ER0 S EH1 L F
    YOURSELF(1)  Y UH0 R S EH1 L F
    YOURSELF(2)  Y AO1 R S EH0 L F
    
### Perhaps not suitable for Morse Code mnemonics

Hackerb9 wrote this program to create mnemonic words for each letter in the Morse Code alphabet.
That works fine for small codes, like dit-DAH (letter 'A' is "a-WAY"). However, a longer code like
DAH-dit-dit-dit (letter 'B') has a list of words which aren't very memorable. How is one to remember
that the word is "BENIFITING", and not "BENEFIT"? Or, "BROKERAGES" and not "BROKERAGE"?

