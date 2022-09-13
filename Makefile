# Version of CMU dictionary in filename ("cmudict-0.7b")
v=-0.7b

# Create a small version of the CMU Dict based on a list of common words.
# Although both corpuses have over 130K words, their intersection is only 50K. 
cmudict${v}.small: scowl.le.70 cmudict${v}
	sort -k1b,1 cmudict${v} > tmp1 \
		&& join tmp1 scowl.le.70 > tmp2 \
		&& rm tmp1 \
		&& mv tmp2 cmudict${v}.small

# Create a wordlist of the more common words (scowl.le.70)
# common70 is a list of source files, ranked 70 or less by SCOWL.
common70=$(addprefix /usr/share/dict/scowl/english-words., 10 20 35 40 50 55 60 70)
# Source files for capitalized words, like "Dracula".
common70+=$(addprefix /usr/share/dict/scowl/english-upper., 10 35 40 50 60 70)
scowl.le.70: ${common70}
	cat ${^} | tr '[a-z]' '[A-Z]' | sort -k1b,1  > tmpfile && mv tmpfile ${@}

# Tiniest wordlist, mainly for debugging.
scowl.le.10: /usr/share/dict/scowl/english-words.10
	cat ${^} | tr '[a-z]' '[A-Z]' | sort -k1b,1  > tmpfile && mv tmpfile ${@}

# Remove words with ambiguous meter.
cmudict${v}.unambiguous: cmudict${v}
	./


.PHONY: clean
clean:
	rm scowl.le.70 cmudict-0.7b.small tmpfile tmp1 tmp2 2>/dev/null || true

