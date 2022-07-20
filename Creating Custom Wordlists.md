# Creating Custom Wordlists

## Table of Contents
- [Crunch](#crunch)
  + [Crunch Syntax](#crunch-syntax)
  + [Crunch-Generate Word List](#crunch-generate-word-list)
  + [Crunch-Create Word List using Pattern](#crunch-create-word-list-using-pattern)
  + [Crunch-Specified Repetition](#crunch-specified-repetition)
- [CUPP](#cupp)
- [KWPROCESSOR](#kwprocessor)
  + [Kwproccessor-Install](#kwprocessor-install)
  + [Kwprocessor-Examples](#kwprocessor-examples)
- [Princeprocessor](#princeprocessor)
  + [Princeprocessor Install](#princeprocessor-install)
  + [Find the Number of Combinations](#find-the-number-of-combinations)
  + [Forming Wordlist](#forming-wordlist)
  + [Password Length Limits](#password-length-limits)
  + [Specifying Elements](#specifying-elements)
- [CeWL](#cewl)
  + [CeWL Syntax](#cewl-syntax)
- [Previously Cracked Passwords](#previously-cracked-passwords)
- [Hashcat-utils](#hashcat-utils)
  + [Maskprocessor](#maskprocessor)

***

## Crunch
Can create wordlists based on parameters such as words of a specific length, limited character set, or a pattern. 
It can generate both permutations and combinations.

[Crunch](https://sourceforge.net/projects/crunch-wordlist/)
### Crunch-Syntax
```bash
crunch <minimum length> <maximum length> <charset> -t <pattern> -o <output file>
```
The `-t` option is used to specify the pattern for generated passwords. 

`@` - insert lower case characters

`,` - insert upper case characters

`%` - insert numbers

`^` - insert symbols

### Crunch-Generate Word List
```bash
# creates a wordlist consisting of words with a length of 4 to 8 characters, using the default character set
crunch 4 8 -o wordlist
```
### Crunch-Create Word List using Pattern
Example:
- "PASSWORDYYYYXXXX" where "XXXX" is the employee ID containing letters, and "YYYY" is the year

```bash
crunch 16 16 -t PASSWORD201%@@@@ -o wordlist
```
### Crunch-Specified Repetition
`-d` is used to specify the amount of repetition
```bash
crunch 12 12 -t 10031998@@@@ -d 1 -o wordlist
```

***

## CUPP
**Common User Password Profiler**

[CUPP](https://github.com/Mebus/cupp)

Used to created highly targeted and customized wordlists based on information gained from social engineering and OSINT.
The `-i` option is used to run in interactive mode.
```bash
python3 cupp.py -i

[+] Insert the information about the victim to make a dictionary
[+] If you don't know all the info, just hit enter when asked! ;)

> First Name: roger
> Surname: penrose
> Nickname:      
> Birthdate (DDMMYYYY): 11051972

> Partners) name: beth
> Partners) nickname:
> Partners) birthdate (DDMMYYYY):

> Child's name: john
> Child's nickname: johnny
> Child's birthdate (DDMMYYYY):

> Pet's name: tommy
> Company name: INLANE FREIGHT

> Do you want to add some key words about the victim? Y/[N]: Y
> Please enter the words, separated by comma. [i.e. hacker,juice,black], spaces will be removed: sysadmin,linux,86391512
> Do you want to add special chars at the end of words? Y/[N]:
> Do you want to add some random numbers at the end of words? Y/[N]:
> Leet mode? (i.e. leet = 1337) Y/[N]:

[+] Now making a dictionary...
[+] Sorting list and removing duplicates...
[+] Saving dictionary to roger.txt, counting 2419 words.
[+] Now load your pistolero with roger.txt and shoot! Good luck!
```
- Also supports appending random characters and a "leet" mode, which uses combinationn of letters and numbers in common words
- CUPP can also fetch common names from various online databases using the `-l` option

***

## KWPROCESSOR
A tool that creates wordlists with keyboard walks: follows patterns on the keyboard. Kwprocessor uses algorithms to guess patterns such as these.

Example:
> `qwertyasdfg`

[KWPROCESSOR](https://github.com/hashcat/kwprocessor)
### Kwprocessor-Install
```bash
git clone https://github.com/hashcat/kwprocessor
```
```bash
cd kwprocessor
```
```bash
make
```
### Kwprocessor-Examples
[Kwprocessor README](https://github.com/hashcat/kwprocessor#routes)

`--keywalk-west` option is used to specify movement towards the west form the base character. The program takes in base characters as a parameter, which is the character set the pattern will start with.
Next, needs a keymap, which maps the locations of keys on language-specific keyboard layouts.
Final option is to specify the route to be used. A route is a pattern to be followed by passwords.
It defines how passwords will be formed, starting from base characters.
```bash
# This command generates words with characters reachable while holding shift (-s), using the full base,
# the standard en-us keymap, and 3 direction changes route
kwp -s 1 basechars/full.base keymaps/en-us.keymap  routes/2-to-10-max-3-direction-changes.route
```

***

## Princeprocessor
**PRobability INfinite Chained Elements**

An efficient password guessing algorithm to improve password cracking rates.
[Princeprocessor](https://github.com/hashcat/princeprocessor) is a tool that generates passwords using the PRINCE algorithm.
The program takes a wordlist and creates chains of words taken from this wordlist.
* Wordlist
```bash
dog
cat
ball
```
* Generated Wordlist
```bash
dog
cat
ball
dogdog
catdog
dogcat
catcat
dogball
catball
balldog
ballcat
ballball
dogdogdog
catdogdog
dogcatdog
catcatdog
dogdogcat
<SNIP>
```
### Princeprocessor Install
[Releases](https://github.com/hashcat/princeprocessor/releases)

```bash
wget https://github.com/hashcat/princeprocessor/releases/download/v0.22/princeprocessor-0.22.7z
```
```bash
7z x princeprocessor-0.22.7z
```
```bash
cd princeprocessor-0.22
```
```bash
./pp64.bin -h
```
### Find the Number of Combinations
```bash
./pp64.bin --keyspace < words
```
Outputs unique words that can be formed from wordlist provided
### Forming Wordlist
```bash
./pp64.bin -o wordlist.txt < words
```
Writes the output words to a file named `wordlist.txt`. By default, princeprocessor only outputs words up to 16 in length.
Can be controlled using the `--pw-min` and `--pw-max` arguments.
### Password Length Limits
```bash
./pp64.bin --pw-min=10 --pw-max=25 -o wordlist.txt < words
```
### Specifying Elements
```bash
./pp64.bin --elem-cnt-min=3 -o wordlist.txt < words
```
The command above will output words with three elements or more, i.e.," dogdogdog."

***

## CeWL

Tool used to create custom wordlists. It spiders and scrapes a website and creates a list of words that are present.

[CeWL](https://github.com/digininja/CeWL)

### CeWL Syntax
```bash
cewl -d <depth to spider> -m <minimum word length> -w <output wordlist> <url of website>
```
Can spider multiple pages present on a given website. Also supports extraction of emails form websites with the `-e` option.
```bash
cewl -d 5 -m 8 -e http://inlanefreight.com/blog -w wordlist.txt
```

***

## Previously Cracked Passwords
Stored in the `hashcat.potfile`. Can be used to create new wordlists of previously cracked passwords:
```bash
cut -d: -f 2- ~/hashcat.potfile
```

***

## Hashcat-utils
[Hashcat-utils](https://github.com/hashcat/hashcat-utils)

Many utilities that can be useful for advanced password cracking.

### Maskprocessor
[Maskprocessor](https://github.com/hashcat/maskprocessor)

[Usage](https://hashcat.net/wiki/doku.php?id=maskprocessor)

Can be used to create wordlists using a given mask.
```bash
/mp64.bin Welcome?s
```



 
