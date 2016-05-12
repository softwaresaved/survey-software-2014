## External R script for the cross-tabulation.Rmd Knitr file
## Use the header with the following formating ## ---- name to import in Knitr

## ----  singleTabFreq

	singleTabFreq <- function(vectorToFreq, name, order=TRUE){
		table_factor <- table(vectorToFreq)
		# Cbind is to combine two different sets into one data.frame
		# the conversion of data.frame within the cbind is to avoid having
		# the factor in data_row for the frequency
		# And being able to index only the value for the percentage
		QSummary <- cbind(as.data.frame(table_factor),
						as.data.frame(round(prop.table(table_factor)*100))[,2])

		#rename the column names
		colnames(QSummary) <- c(name, 'Total Respondents', 'Percent')
		if (order==TRUE){
			# Order the table by Total Respondents
			QSummary <- QSummary[order(QSummary[,2]),]
			# Reorder the level of the factors for using in legend (to match the order of the plot)
			QSummary[,1] = factor(QSummary[,1], levels=QSummary[,1][order(QSummary[,2])], ordered=order)
		}
		# Output a table of the variable

		write.csv(QSummary, paste('./results/',name,'.csv'), row.names=FALSE)
		dev.off()
		return (QSummary)
	}

## ----  plotSummary 

    library('ggplot2')
    library('plyr')
	plotSummary <- function(dataframe, column, name, order=TRUE){
		index_column <- match(column, names(dataframe))
		# To reorganise the factor level to show on the legend according to the 
		# frequencies
		p <- ggplot(data=dataframe, environment=environment())
		# environment=environment() is a workaround for ggplot2 to get access to the
		# namespace defined within the function.
		if (order==TRUE){
			p <- p + aes(x=reorder(dataframe[,1], dataframe[, index_column]),
				 		 y=dataframe[,index_column],
						 fill=dataframe[,1])
		}
		else{
			p <- p + aes(x=dataframe[,1],
				     y=dataframe[,index_column],
					 fill=dataframe[,1])
		}
		p <- p + geom_bar(stat='identity')
		p <- p + theme_minimal()
		#p <- p + theme(axis.text.x= element_blank())
		p <- p + ylab('')
		p <- p + xlab('')
		p <- p + ggtitle(name)
		p <- p + theme(plot.title = element_text(size=30, face='bold'))
		p <- p + theme(legend.text=element_text(size=20))
		p <- p + theme(legend.title=element_blank())
		p <- p + geom_text(aes(label=dataframe[,index_column]), vjust=-0.2, size=8)
		return (p)
	}

	
## ----  printSummary
	printSummary <- function(df, name, order=TRUE){
		tableFactor <- table(df[[name]])
		# Cbind is to combine two different sets into one data.frame
		# the conversion of data.frame within the cbind is to avoid having
		# the factor in data_row for the frequency
		# And being able to index only the value for the percentage
		QSummary <- cbind(as.data.frame(tableFactor),
						as.data.frame(round(prop.table(tableFactor)*100))[,2])

		#rename the column names
		colnames(QSummary) <- c(name, 'Total Respondant', 'Percent')
		if (order==TRUE){
			# Order the table by Total Respondents
			QSummary <- QSummary[order(QSummary[,2]),]
			# Reorder the level of the factors for using in legend 
			# (to match the order of the plot)
			QSummary[,1] = factor(QSummary[,1], levels=QSummary[,1][order(QSummary[,2])], ordered=order)
		}
		# Output a table of the variable

		write.csv(QSummary,paste('./results/', name, '.csv'), row.names=FALSE)
		return (QSummary)
	}



## ---- crossTabFreq 

	crossTabFreq <- function(df, var1, var2, propNum=1, summaryTable=TRUE){
		freqTable <- table(df[[var1]], df[[var2]])
		if(summaryTable==TRUE){
			kable(freqTable, digits=2)
		}
		#print(freq_table)
		dfTable  <- cbind(as.data.frame(freqTable),
						as.data.frame(prop.table(freqTable, propNum))[,3])
		colnames(dfTable) <- c(var1, var2, 'Freq', 'Prop')

		write.csv(dfTable, paste("./results/cross_table_", var1,'_', var2, '.csv'), row.names=FALSE)

		dev.off()
		return(dfTable)
	}


## ---- facetPlot
	facetPlot <- function(df, xVar, yVar, facetVar, removeNA=TRUE, FREQ=TRUE){
		df$Percent  <- df[[yVar]]*100
		if (removeNA==TRUE) {
			df <- na.omit(df)
		}
		p <- ggplot(df, environment=environment())
		p <- p + aes_string(x=xVar, y='Percent', fill=xVar)
		p <- p + geom_bar(stat='identity', position='dodge')
		#p <- p + theme_minimal()
		p <- p + ylab('')
		#p <- p + scale_y_continuous(labels = percent_format())
		p <- p + xlab('')
		p <- p + theme(plot.title = element_text(size=30, face='bold'))
		p <- p + theme(legend.text=element_text(size=20))
		p <- p + theme(legend.title=element_blank())
		#p <- p + scale_fill_brewer()
		if (FREQ==TRUE){
			p <- p + geom_text(aes(label=paste(round(Percent), '%', ' (n=', Freq, ')')), vjust=-0.2, size=4)
		}
		else {
			p <- p + geom_text(aes(label=paste(round(Percent))), vjust=-0.2, size=4)
		}
		p <- p + theme(plot.title = element_text(size=20, face="bold", vjust=2))
		p <- p + facet_wrap(as.formula(paste('~', facetVar)), ncol=2)
		return(p)
	}


## ---- chiSquareSummary
	chiSquareSummary <- function (table_, var1, var2) {
		chiValue <- chisq.test(table_)
		#fisher_value <- fisher.test(table_)
		if (chiValue$p.value <= .5){
			write.csv(chiValue$residuals, paste("./results/chi_test_res_", var1,'_', var2, '.csv'), row.names=FALSE)
		}
		return (chi_value)
	}

## ---- processCrossTab

	processCrossTabulation <- function(df, nameVar1, nameVar2, univariate=FALSE,
									   summaryTable=TRUE, propNum=1, saveFile=TRUE){
		if(univariate==TRUE){
			sumQ <- printSummary(df, nameVar2)
			#Printing table
			kable(sumQ, digits=2)
			# Printing Plot
			plotSummary(sum_Q, 'Total Respondents', nameVar2)
		}
		table_ <- crossTabFreq(df, nameVar1, nameVar2, propNum=propNum)
		plot <- facetPlot(table_, nameVar2, 'Prop', nameVar1)
		return(plot)
	}
