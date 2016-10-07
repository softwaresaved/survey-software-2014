# Exploring data-set: Categorical Analysis
Olivier PHILIPPE  
26 June 2015  






















# Introduction
This survey aims to give a broad picture of research software use and practice within the Research communities in United-Kingdom. 

## Data Collection

The survey contacted 1,000 randomly selected researchers at each of 15 Russell Group universities by email. From this 15,000 invitations to complete the survey, we received 417 responses – a rate of 3% which is a little bit low for a blind survey but can still gives us an idea. 

We asked people specifically about “research software” which we defined as:

>Software that is used to generate, process or analyse results that you intend to appear in a publication (either in a journal, conference paper, monograph, book or thesis). Research software can be anything from a few lines of code written by yourself, to a professionally developed software package. Software that does not generate, process or analyse results - such as word processing software, or the use of a web search - does not count as ‘research software’ for the purposes of this survey.

The responses were collected with Google Forms. 
The data collected during this survey is available for download from Zenodo, as well as the entire code source of the data cleansing and data analysis. It is licensed under a Creative Commons by Attribution licence (attribution to The University of Edinburgh on behalf of the Software Sustainability Institute).



```
##     dataOrigin 
##  petition:143  
##  phd     :138  
##  survey  :417
```
However, the question 6 asked if the participant uses, or not, a software for his research. Considering that people who are not using any software fall out of our category of interest, 
we removed them from the dataset and only perform analysis on the filtered data. 



# Exploring the variables. 

Before seeing the repartition of the variable across categories, it is important to have an overview of each variable at once. It helps to spot possible errors, problems, or over-representativeness. 
The main interest of this research is the understanding of the research community in their use of software and their habit concerning the use, the development and the training of software. 
Therefore, the first variables we are going to visualise are these three variables: 
* The importance of software in research
* The development of software for research
* The corresponding training 


## Habits concerning software in research 

The first interest is to know if people use software for their research. Over our sample of 406 respondents (after data cleaning), 372 of them use a software for their research (92%). 


|Use of Software | Total Respondents| Percent|
|:---------------|-----------------:|-------:|
|No              |                34|       8|
|Yes             |               383|      92|

![](analysis-Survey_files/figure-html/unnamed-chunk-10-1.png)<!-- -->

Knowing that only 8% do not use software for research, and as the main point is about people how does use software, we decided to filter these 34 respondents for all further analysis, putting our sample to 372 respondents. 



## Importance of software

The question on the importance of software is a categorical variable with 3 levels.
The possible answers were as follow
* It would make no significant difference to my work
* My work would require more effort, but it would still be possible
* It would not be practical to conduct my work without software 





|   |Importance of Software | Total Respondents| Percent|
|:--|:----------------------|-----------------:|-------:|
|1  |No Difference          |                43|      10|
|3  |More effort            |                88|      21|
|2  |Not be Practical       |               286|      69|

![](analysis-Survey_files/figure-html/unnamed-chunk-13-1.png)<!-- -->

First, it seems that the "No Difference" category is really marginal. We decide to recode this variable into a binary one, representing if the use of software is essential or not. 
The 'Essential' category will include the "Non-Essential" and the "No" category will include the marginal  "No Difference" and the "More effort" 
into two categories "Essential", including the category "No practical" and the other category being "No Essential", including the marginal "No difference" and the "More effort"




|Software Essential for research | Total Respondents| Percent|
|:-------------------------------|-----------------:|-------:|
|No-Essential                    |               131|      31|
|Essential                       |               286|      69|

![](analysis-Survey_files/figure-html/unnamed-chunk-15-1.png)<!-- -->

## Developing its own research software.

It’s not just proprietary software, many researchers are developing their own code: 56% of them. This is great news, because the real power of software lies in developing it to allow you to do more in less time and make new research possible.



|Developing Software | Total Respondents| Percent|
|:-------------------|-----------------:|-------:|
|No                  |               184|      44|
|Yes                 |               233|      56|

![](analysis-Survey_files/figure-html/unnamed-chunk-16-1.png)<!-- -->

### Training to develop software



|   |Training in Software development | Total Respondents| Percent|
|:--|:--------------------------------|-----------------:|-------:|
|4  |Taught                           |                61|      15|
|3  |Self-taugh+Taught                |                64|      15|
|2  |Self-Taught                      |               104|      25|
|1  |No                               |               188|      45|

```
## [1] Taught            Self-taugh+Taught Self-Taught       No               
## Levels: Taught < Self-taugh+Taught < Self-Taught < No
```

```
## Warning in if (is.na(ownColour) == FALSE) {: the condition has length > 1
## and only the first element will be used
```

![](analysis-Survey_files/figure-html/unnamed-chunk-17-1.png)<!-- -->


### Training versus developing



|   |Training in Software development | Total Respondents| Percent|
|:--|:--------------------------------|-----------------:|-------:|
|4  |Taught                           |                47|      20|
|1  |No                               |                49|      21|
|3  |Self-taugh+Taught                |                55|      24|
|2  |Self-Taught                      |                82|      35|

```
## Warning in if (is.na(ownColour) == FALSE) {: the condition has length > 1
## and only the first element will be used
```

![](analysis-Survey_files/figure-html/unnamed-chunk-18-1.png)<!-- -->


## Additional informations


### Disciplines

If we output the frequency of distribution we obtain the following table.


|   |Discipline                                        | Total Respondents| Percent|
|:--|:-------------------------------------------------|-----------------:|-------:|
|5  |Design, creative & performing arts                |                 2|       0|
|3  |Architecture & planning                           |                 6|       1|
|2  |Agriculture, forestry & veterinary science        |                 7|       2|
|6  |Education                                         |                 7|       2|
|1  |Administrative & business studies                 |                 8|       2|
|8  |Humanities & language based studies & archaeology |                38|       9|
|10 |Social studies                                    |                44|      11|
|9  |Medicine, dentistry & health                      |                57|      14|
|7  |Engineering & technology                          |                81|      19|
|4  |Biological, mathematical & physical sciences      |               167|      40|

![](analysis-Survey_files/figure-html/unnamed-chunk-19-1.png)<!-- -->

As we can see, several categories has a really low number of members. The decision to bring different disciplines together is always a difficult decision and will never satisfy all academics on the same time. From this first, an already controversial, aggregate, we decided to sum several of these categories together to avoid almost empty groups for the futures cross-tabulations analysis. 
We decided to merge the following categories based on the low level of each and an attempt to group them on a common sense:

* Design, creative & performing arts + Architecture & planning + Humanities & language based studies & archaeology
* Administrative & business studies + Social studies + Education
* Medicine, dentistry & health + Agriculture, forestry & veterinary science



Then the distribution table seems more usable even if we probably make more academics angry at this point. 


|Modified Disciplines                         | Total Respondents| Percent|
|:--------------------------------------------|-----------------:|-------:|
|Design+Art+Hum                               |                46|      11|
|Admin+Social+Edu                             |                59|      14|
|Medicine+Agri                                |                64|      15|
|Engineering & technology                     |                81|      19|
|Biological, mathematical & physical sciences |               167|      40|

![](analysis-Survey_files/figure-html/unnamed-chunk-21-1.png)<!-- -->


### Importance of software per disciplines

![](analysis-Survey_files/figure-html/unnamed-chunk-22-1.png)<!-- -->

### Developing software per disciplines

![](analysis-Survey_files/figure-html/unnamed-chunk-23-1.png)<!-- -->

### Developing software per disciplines

![](analysis-Survey_files/figure-html/unnamed-chunk-24-1.png)<!-- -->

## Funding Origins

The questions 4 about the funds already been cleaned up during the previous process, some data entered in the free text zone have been recoded in a reduced numbers of factors. At the end we obtain 20 categories. 

The frequencies distribution is showed on the following table and plot. We can see that there is a high representation of people from EPSRC in the sample (23%).


|Funds                                                          | Total Respondents| Percent|
|:--------------------------------------------------------------|-----------------:|-------:|
|DEL                                                            |                 1|       0|
|Iraq Ministry of Higher Education                              |                 1|       0|
|Me                                                             |                 1|       0|
|School                                                         |                 1|       0|
|No funding                                                     |                 2|       0|
|Self funded                                                    |                 2|       0|
|Non-UK Gov                                                     |                 5|       1|
|Leverhulme Trust                                               |                 6|       1|
|Insufficient information                                       |                10|       2|
|Other UK Gov                                                   |                10|       2|
|AHRC - Arts and Humanities Research Council                    |                11|       3|
|National Institute for Health Research                         |                13|       3|
|Wellcome Trust                                                 |                13|       3|
|BBSRC - Biotechnology and Biological Sciences Research Council |                14|       3|
|STFC - Science and Technology Facilities Council               |                15|       4|
|Industry                                                       |                16|       4|
|NERC - Natural Environment Research Council                    |                20|       5|
|MRC - Medical Research Council                                 |                21|       5|
|Other charity or fundation                                     |                23|       6|
|Don't know                                                     |                26|       6|
|ESRC - Economic and Social Research Council                    |                31|       7|
|Europe                                                         |                32|       8|
|University central funds                                       |                54|      13|
|EPSRC - Engineering and Physical Sciences Research Council     |                89|      21|

The number of categories for this variable is too big to apply a pertinent comparison between them. We decide to recode the 20 categories into 7. 

* **Charity/Trust**: "Leverhulme Trust" - "Other charity or foundation" - "Wellcome Trust"
* **Research Councils**: "AHRC - Arts and Humanities Research Council" - "BBSRC - Biotechnology and Biological Sciences Research Council" - "EPSRC - Engineering and Physical Sciences Research Council" - "ESRC - Economic and Social Research Council" - "NERC - Natural Environment Research Council" - "STFC - Science and Technology Facilities Council"
* **Industry**: "Industry"
* **Other UK**: "Other UK Gov" - "University central funds" - "National Institute for Health Research"
* **Others Non-UK**: "Non-UK Gov" - "Europe"
* **None**: "Don't know" - "Insufficient information" - "No funding" - "Self funded"

These categories represents a meta-categories of units. They were build under a common sense logic to help further analysis. As soon as a global picture is obtained, we will do within-categories cross-tabulation analysis. Here following the creation of these categories





|Modified Funds                                   | Total Respondents| Percent|
|:------------------------------------------------|-----------------:|-------:|
|Self funded                                      |                 2|       0|
|Other UK                                         |                 8|       2|
|Other UK Gov                                     |                10|       2|
|Wellcome Trust                                   |                13|       3|
|STFC - Science and Technology Facilities Council |                15|       4|
|Charity/Trust                                    |                31|       7|
|Europe                                           |                32|       8|
|None                                             |                43|      10|
|Other Non-UK                                     |                44|      11|
|University central funds                         |                54|      13|
|Research Council                                 |               165|      40|

![](analysis-Survey_files/figure-html/unnamed-chunk-27-1.png)<!-- -->

We have two types of researcher funding in our sample, one type that is funded by a Research council (52%) and one half with other type of funding. We keep or current categorisation for further analysis. 

### Importance of software per funding origin

![](analysis-Survey_files/figure-html/unnamed-chunk-28-1.png)<!-- -->

### Developing software per funding origin 
![](analysis-Survey_files/figure-html/unnamed-chunk-29-1.png)<!-- -->

### Training software per funding origin 
![](analysis-Survey_files/figure-html/unnamed-chunk-30-1.png)<!-- -->

### Seniority


First, we take a look at the variable Seniority. This is an ordinal variable with 6 levels:
* Less than a year
* 1-5 years
* 6-10 years
* 11-15 years
* 15-20 years
* More than 20 years
We need to recode the levels of the factor for later graphics



And now to visualise the repartition of our sample within the Seniority variable.


|Seniority          | Total Respondents| Percent|
|:------------------|-----------------:|-------:|
|Less than a year   |                12|       3|
|1-5 years          |               142|      34|
|6-10 years         |                99|      24|
|11-15 years        |                54|      13|
|15-20 years        |                37|       9|
|More than 20 years |                73|      18|

![](analysis-Survey_files/figure-html/unnamed-chunk-32-1.png)<!-- -->

### Importance of software per Seniority

![](analysis-Survey_files/figure-html/unnamed-chunk-33-1.png)<!-- -->

### Developing software per Seniority 
![](analysis-Survey_files/figure-html/unnamed-chunk-34-1.png)<!-- -->

### Training software per Seniority 
![](analysis-Survey_files/figure-html/unnamed-chunk-35-1.png)<!-- -->

## Gender


|   |Gender | Total Respondents| Percent|
|:--|:------|-----------------:|-------:|
|4  |Other  |                 2|       0|
|3  |NA     |                 7|       2|
|1  |Female |               148|      36|
|2  |Male   |               257|      62|

![](analysis-Survey_files/figure-html/unnamed-chunk-36-1.png)<!-- -->

### Importance of software per Gender

![](analysis-Survey_files/figure-html/unnamed-chunk-37-1.png)<!-- -->

### Developing software per Gender

![](analysis-Survey_files/figure-html/unnamed-chunk-38-1.png)<!-- -->

### Training software per Gender

![](analysis-Survey_files/figure-html/unnamed-chunk-39-1.png)<!-- -->

## Operating System



|   |Operating System        | Total Respondents| Percent|
|:--|:-----------------------|-----------------:|-------:|
|5  |NA                      |                 6|       1|
|1  |Don't have a preference |                41|      10|
|2  |GNU/Linux               |                82|      20|
|3  |Mac OS X                |                99|      24|
|4  |Microsoft Windows       |               189|      45|

![](analysis-Survey_files/figure-html/unnamed-chunk-40-1.png)<!-- -->
### Importance of software per Operating System

![](analysis-Survey_files/figure-html/unnamed-chunk-41-1.png)<!-- -->

### Developing software per Operating System

![](analysis-Survey_files/figure-html/unnamed-chunk-42-1.png)<!-- -->

### Training software per Operating System

![](analysis-Survey_files/figure-html/unnamed-chunk-43-1.png)<!-- -->
