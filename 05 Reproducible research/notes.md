# Reproducible research
## Week 1
### Conceptes and ideas
Replication is the most important in science. Very important for regulatory stuff.
What is wrong with repication?
Stidies are 
- bigger
- opportunistic
- more expensive
- unique
#### Why we need middle ground?
(data + computational infromation). Data + code => somewhat shure that reporducible.
- high data collection speed
- multidimensional
- models, analysis and algorithms are much more comples -> every field "X" has a "Computational"

#### research pipeline
we read from text to data, but the pipeline came from measured data to the article.
to read:
1. Reproducible research in computational science (special issue)
2. 60 minutes "The duke saga"
3. Evolution of translational omics, lessons learned and path forward.

#### what we need?
- analytic data are available (data used for analysis)
- analytic code (code applied to this)
- documentation of code
- standard means of distribution

#### players
- authors
  - want reproducible 
  - need tools
- readers
  - want to reproduce
  - want tools for RR to have simpler life
  
#### challenges
- resources
- effort
- toolbox for RR are bad and fiew

#### literate (statistical) programming
* documentation language (human)
* programming language (machine readable)
Sweave (R + LaTeX) - combination
better and newer - _knitr_
LaTeX + markdown + html

### Script your analysis
Now we write down programs.

### Structure of Data Analysis
- Define qustions
- Define ideal data set
- determine what data can access
- obtain data
- clean data
- exploratory data analysis
- statistical preditction/modelling
- interpret results
- challenge results
- synthesize/write up results
- create reproducible code

#### challenges
Never good info, enough info.

#### defining a question 
the most dimension reducing thing. If can narrow down the question - less noise to deal with. Random application of statistics to dat as dangeous.

#### example:

#####  ?
start with a general ?. can i detect emails that are spam -> what quanittative metrics to determine if spam ore not?

#####  ideal data set
depends on goal.
- descriptive - all people
- exploratory - random selection
...

Ideal - all google data center contents.
In real world there are limitations.
Possible solution - some subset, uci machine learning repository.

##### obtain
get raw, reference the source, be polite, record url and time

##### clean data
- process raw
- learn how pre-processed
- understand the source
- record all preprocessing
- *determine if data are good enough - if not, quit or change data*

##### explore
do exploratory data analysis
##### statistical preditction/modelling

##### interpret results
Use the appropriate language
- describes
- correlates with/associated with
- leads to/causes
- predicts
Give an explanation
Interpret coefficients
Interpret measures of uncertainty

##### challenge results
- challenge steps
- challenge measures of uncertainty
- choice of terms to include
- think alternative analyses

##### synthesize/write-up results
- Lead with the question
- Summarize the analyses into the story
- Don't include every analysis, include it (If it is needed for the story If it is needed to address a challenge)
- Order analyses according to the story, rather than chronologically
- Include "pretty" figures that contribute to the story

### Organize data analysis
key files

- data
       
        - raw (add to git )
        - processed (need to be names. processing script - need be in readme, must be tidy)
        
- figures
        
        - explore
        - final (better, possibly multiple panesl)
        
- Rcode
        
        - raw (not many comments) and unused
        - final scripts (clearly commented, cmall comments "what, when, why,how", bigger commented blocks)
        - R mardown files
        
- texts
        
        - readme files (not necessary if using marksown, need have step-by-step insructions)
        - test of analysis/report
## useful
https://simplystatistics.org/2012/02/27/the-duke-saga-starter-set/
statistics project guidelines https://www.r-statistics.com/2010/09/managing-a-statistical-analysis-project-guidelines-and-best-practices/
project template http://projecttemplate.net/

# week 2

## code standards
1) use text
2) indent code
3) limit width
4) limit function length

## markdown
advanced linking to [reddit][1]  
add double space to next line  
official markdown [doc][2]

[1]: https://www.reddit.com/
[2]: https://daringfireball.net/projects/markdown/syntax

## r markdown
R integrated with marksown
a core tool of literate statistical programming
use _knitr_  
R markdown -> marksown -> htms work flow  
using markdown for slides - _slidify_

## using knitr

just format code and text in one r markdown file like in example, "test_r_markdown"