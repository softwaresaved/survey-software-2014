## External R script for the cross-tabulation.Rmd Knitr file
## Use the header with the following formating ## ---- name to import in Knitr



# Setting up the directory
# (WD <- getwd())
# if (!is.null(WD)) setwd(WD)

## Load the external functions for analysis
source('../analysis/categorical_func.R')

## Load the file

## ---- prepare_df

	df <-read.csv("../data/mergedDfCleaned.csv", stringsAsFactors=TRUE, na.strings="")


	# Subsetting the dataset to contain only software users, meaning people who answered yes at the Q6
	dfYES <- df[which(df$Q.6.Use.Software=='Yes'),]
	dfYES <- droplevels(dfYES)

## ---- recode_last_var
	## RecodeQ3
		library('car')
		library('plyr')
		# Recode the factors
		DesArHu <- c("Design, creative & performing arts", "Architecture & planning", "Humanities & language based studies & archaeology")
		AdmSoEd <- c('Administrative & business studies', 'Social studies', 'Education')
		MedAgri <- c('Medicine, dentistry & health', 'Agriculture, forestry & veterinary science')
		dfYES$Q.3.Discipline.mod <- dfYES$Q.3.Discipline
		dfYES$Q.3.Discipline.mod <- recode(dfYES$Q.3.Discipline.mod, "DesArHu='Design+Art+Hum'")
		dfYES$Q.3.Discipline.mod <- recode(dfYES$Q.3.Discipline.mod, "AdmSoEd='Admin+Social+Edu'")
		dfYES$Q.3.Discipline.mod <- recode(dfYES$Q.3.Discipline.mod, "MedAgri='Medicine+Agri'")


	## RecodeQ4

		dfYES$Q.4.Fund.mod <- dfYES$Q.4.Fund

		levels(dfYES$Q.4.Fund.mod)[c(3, 8, 13, 17)] <- 'None'
		levels(dfYES$Q.4.Fund.mod)[c(8, 13, 17)] <- 'Charity/Trust'
		levels(dfYES$Q.4.Fund.mod)[c(1, 2, 4, 5, 9, 11, 14)] <- 'Research Council'
		levels(dfYES$Q.4.Fund.mod)[c(6, 8)] <- 'Other UK'
		levels(dfYES$Q.4.Fund.mod)[c(3, 7)] <- 'Other Non-UK'


	## RecodeQ7

		levels(dfYES$Q.7.Importance.Software)[1] <- "No Difference"
		levels(dfYES$Q.7.Importance.Software)[2] <- "Not be Practical"
		levels(dfYES$Q.7.Importance.Software)[3] <- "More effort"
		#Recoding into a binary variable
		dfYES$Q.7.Essential.software <- revalue(dfYES$Q.7.Importance.Software, c('No Difference'='No-Essential', 'More effort'='No-Essential', 'Not be Practical'='Essential'))

## ---- Q3aUni

    sumQ <- singleTabFreq(dfYES$Q.3.Discipline, 'Discipline')
    kable(sumQ, digits=2)
	plotSingleFreq(sumQ, 'Discipline', xText=FALSE)

## ---- Q3bUni

    modifiedQ3 <- singleTabFreq(dfYES$Q.3.Discipline.mod, 'Modified Disciplines')
    kable(modifiedQ3, digits=2, row.names = FALSE)
    plotSingleFreq(modifiedQ3, 'Modified Disciplines')


## ---- Q4aUni

    sumQ <- singleTabFreq(dfYES$Q.4.Fund.clean, 'Funds')
    kable(sumQ, digits=2, row.names = FALSE)
    plotSingleFreq(sumQ, 'Funds', xText=FALSE)


## ---- Q4bUni

    sumQ <- singleTabFreq(dfYES$Q.4.Fund.mod,'Modified Funds')
    kable(sumQ, digits=2, row.names = FALSE)
    plotSingleFreq(sumQ, 'Modified Funds')

## ---- Q5Uni

    sumQ <- singleTabFreq(dfYES$Q.5.Seniority, 'Seniority', order=FALSE)
    kable(sumQ, digits=2)
    plotSingleFreq(sumQ, 'Seniority', order=FALSE)


## ---- Q7aUni
	
	sumQ  <-  singleTabFreq(dfYES$Q.7.Importance.Software, 'Importance of Software')
	kable(sumQ, digits=2)
	plotSingleFreq(sumQ, 'Importance of Software')


## ---- Q7bUni

	sumQ  <-  singleTabFreq(dfYES$Q.7.Essential.software, 'Software Essential for research')
	kable(sumQ, digits=2)
	plotSingleFreq(sumQ, 'Software Essential for research')


## ---- Q8Uni
	
	sumQ  <-  singleTabFreq(dfYES$Q.8.Developing.Software, 'Developing Software')
	kable(sumQ, digits=2)
	plotSingleFreq(sumQ, 'Developing Software')


## ---- Q9Uni
	
	sumQ  <-  singleTabFreq(dfYES$Q.9.Training.Software.clean, 'Training in Software development')
	kable(sumQ, digits=2)
	color_Developing <- myColor(sumQ[,1])
	plotSingleFreq(sumQ, 'Training in Software development', ownColour=color_Developing)
## ---- E1Uni
	
    sumQ <- singleTabFreq(dfYES$E.1.Job.Title.clean, 'Job Title')
    kable(sumQ, digits=2)
    plotSingleFreq(sumQ, 'Job Title')

## ---- E2Uni

    sumQ <- singleTabFreq(dfYES$E.2.Gender.clean, 'Gender')
    kable(sumQ, digits=2)
    plotSingleFreq(sumQ, 'Gender')


## --- E4Uni

    sumQ <- singleTabFreq(dfYES$E.4.OS.clean, 'Operating System')
    kable(sumQ, digits=2)
    plotSingleFreq(sumQ, 'Operating System')


## ---- Q8onQ9

	# Sample only the developing software on Q9 to know the associate training
	sumQ  <-  singleTabFreq(dfYES[which(dfYES$Q.8.Developing.Software == 'Yes'),]$Q.9.Training.Software.clean, 'Training in Software development')
	kable(sumQ, digits=2)
	plotSingleFreq(sumQ, 'Training in Software development', ownColour=color_Developing)


## ---- Q3vsQ7
	
	sumQ  <- crossTabFreq(dfYES, 'Q.3.Discipline.mod', 'Q.7.Essential.software') 
	facetPlot(sumQ, facetVar='Q.3.Discipline.mod', xVar='Q.7.Essential.software')


## ---- Q3vsQ8

	sumQ  <- crossTabFreq(dfYES, 'Q.3.Discipline.mod', 'Q.8.Developing.Software') 
	facetPlot(sumQ, facetVar='Q.3.Discipline.mod', xVar='Q.8.Developing.Software')


## ---- Q3vsQ9

	sumQ  <- crossTabFreq(dfYES, 'Q.3.Discipline.mod', 'Q.9.Training.Software.clean') 
	facetPlot(sumQ, facetVar='Q.3.Discipline.mod', xVar='Q.9.Training.Software.clean')


## ---- Q4vsQ7

	sumQ  <- crossTabFreq(dfYES, 'Q.4.Fund.mod', 'Q.7.Essential.software') 
	facetPlot(sumQ, facetVar='Q.4.Fund.mod', xVar='Q.7.Essential.software')


## ---- Q4vsQ8

	sumQ  <- crossTabFreq(dfYES, 'Q.4.Fund.mod', 'Q.8.Developing.Software') 
	facetPlot(sumQ, facetVar='Q.4.Fund.mod', xVar='Q.8.Developing.Software')
	

## ---- Q4vsQ9

	sumQ  <- crossTabFreq(dfYES, 'Q.4.Fund.mod', 'Q.9.Training.Software.clean') 
	facetPlot(sumQ, facetVar='Q.4.Fund.mod', xVar='Q.9.Training.Software.clean')


## ---- Q5vsQ7

	sumQ  <- crossTabFreq(dfYES, 'Q.5.Seniority', 'Q.7.Essential.software') 
	facetPlot(sumQ, facetVar='Q.5.Seniority', xVar='Q.7.Essential.software')


## ---- Q5vsQ8

	sumQ  <- crossTabFreq(dfYES, 'Q.5.Seniority', 'Q.8.Developing.Software') 
	facetPlot(sumQ, facetVar='Q.5.Seniority', xVar='Q.8.Developing.Software')


## ---- Q5vsQ9

	sumQ  <- crossTabFreq(dfYES, 'Q.5.Seniority', 'Q.9.Training.Software.clean') 
	facetPlot(sumQ, facetVar='Q.5.Seniority', xVar='Q.9.Training.Software.clean')


## ---- E1vsQ7

	sumQ  <- crossTabFreq(dfYES, 'E.1.Job.Title.clean', 'Q.7.Essential.software') 
	facetPlot(sumQ, facetVar='E.1.Job.Title.clean', xVar='Q.7.Essential.software')


## ---- E1vsQ8
	
	sumQ  <- crossTabFreq(dfYES, 'E.1.Job.Title.clean', 'Q.8.Developing.Software') 
	facetPlot(sumQ, facetVar='E.1.Job.Title.clean', xVar='Q.8.Developing.Software')


## ---- E1vsQ9
	
	sumQ  <- crossTabFreq(dfYES, 'E.1.Job.Title.clean', 'Q.9.Training.Software.clean') 
	facetPlot(sumQ, facetVar='E.1.Job.Title.clean', xVar='Q.9.Training.Software.clean')

## ---- E2vsQ7

	sumQ  <- crossTabFreq(dfYES, 'E.2.Gender.clean', 'Q.7.Essential.software') 
	facetPlot(sumQ, facetVar='E.2.Gender.clean', xVar='Q.7.Essential.software')


## ---- E2vsQ8

	sumQ  <- crossTabFreq(dfYES, 'E.2.Gender.clean', 'Q.8.Developing.Software') 
	facetPlot(sumQ, facetVar='E.2.Gender.clean', xVar='Q.8.Developing.Software')
	chiValue  <- chiSquareSummary(sumQ, 'E.2.Gender.clean', 'Q.8.Developing.Software') 


## ---- E2vsQ9

	sumQ  <- crossTabFreq(dfYES, 'E.2.Gender.clean', 'Q.9.Training.Software.clean') 
	facetPlot(sumQ, facetVar='E.2.Gender.clean', xVar='Q.9.Training.Software.clean')


## ---- E4vsQ7

	sumQ  <- crossTabFreq(dfYES, 'E.4.OS.clean', 'Q.7.Essential.software') 
	facetPlot(sumQ, facetVar='E.4.OS.clean', xVar='Q.7.Essential.software')


## ---- E4vsQ8

	sumQ  <- crossTabFreq(dfYES, 'E.4.OS.clean', 'Q.8.Developing.Software') 
	facetPlot(sumQ, facetVar='E.4.OS.clean', xVar='Q.8.Developing.Software')

## ---- E4vsQ9

	sumQ  <- crossTabFreq(dfYES, 'E.4.OS.clean', 'Q.9.Training.Software.clean') 
	facetPlot(sumQ, facetVar='E.4.OS.clean', xVar='Q.9.Training.Software.clean')
