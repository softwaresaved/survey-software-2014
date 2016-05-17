library('knitr')
library('ggplot2')
library('plyr')
library('RColorBrewer')
library('car')


# Function to create own colour palette to use when there is a need to keep the same
# colour between plot (otherwise they are changed according to the ordering)
myColor <-  function(vectorToColour=vector(), palette='Set3'){
	print(vectorToColour)
	size  <- length(vectorToColour)
	myColors <- brewer.pal(size, palette)
	names(myColors) <- vectorToColour
	return(myColors)
	}


# Function that output a data frame containing the variable, the Frequency and 
# rounded percent
# Optional order is to output the table ordered in Frequency (useful for output with
# kable
singleTabFreq <- function(vectorToFreq, name, order=TRUE){
	# Transform the vector into a table of frequency 
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
		QSummary[,1] <- factor(QSummary[,1], levels=QSummary[,1][order(QSummary[,2])], ordered=order)
	}
	# Write the result into a csv file
	#write.csv(QSummary, paste('./results/',name,'.csv'), row.names=FALSE)
	#dev.off()
	# Output a table of the variable
	return (QSummary)
}


plotSingleFreq <- function(dataframe, name, column='Total Respondents', order=TRUE, xText=TRUE, ownColour=NA){
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
	else {
		p <- p + aes(x=dataframe[,1],
						y=dataframe[,index_column],
						fill=dataframe[,1])
	}
	p <- p + geom_bar(stat='identity')
	# p <- p + theme_minimal()
	p <- p + ylab('')
	p <- p + xlab('')
	p <- p + ggtitle(name)
	p <- p + theme(plot.title = element_text(size=30, face='bold'))
	p <- p + theme(legend.text=element_text(size=20))
	p <- p + theme(legend.title=element_blank())
	if (is.vector(ownColour)){

		p  <- p + scale_fill_manual(values=ownColour)
	}
	if (xText == FALSE) {
		p  <- p + theme(axis.text.x=element_blank())
	}
	p <- p + geom_text(aes(label=dataframe[,index_column]), vjust=-0.2, size=8)
	return (p)
}

crossTabFreq <- function(df, var1, var2, propNum=1){
	freqTable <- table(df[[var1]], df[[var2]])
	dfTable  <- cbind(as.data.frame(freqTable),
						as.data.frame(prop.table(freqTable, propNum))[,3])
	colnames(dfTable) <- c(var1, var2, 'Freq', 'Prop')
	return(dfTable)
}

facetPlot <- function(df, xVar, facetVar, yVar='Prop', removeNA=FALSE, FREQ=TRUE, xText=TRUE){
	df$Percent  <- df[[yVar]]*100
	if (removeNA==TRUE) {
		df <- na.omit(df)
	}
	p <- ggplot(df, environment=environment())
	p <- p + aes_string(x=xVar, y='Percent', fill=xVar)
	p <- p + geom_bar(stat='identity', position='dodge')
	p <- p + ylab('')
	p <- p + xlab('')
	p <- p + theme(plot.title = element_text(size=30, face='bold'))
	p <- p + theme(legend.text=element_text(size=20))
	p <- p + theme(legend.title=element_blank())
	if (xText == FALSE) {
		p  <- p + theme(axis.text.x=element_blank())
	}
	if (FREQ==TRUE){
		p <- p + geom_text(aes(label=paste(round(Percent), '%', ' (n=', Freq, ')')), vjust=-0, size=4)
	}
	else {
		p <- p + geom_text(aes(label=paste(round(Percent))), vjust=0, size=4)
	}
	p <- p + theme(plot.title = element_text(size=20, face="bold", vjust=-1))
	p <- p + facet_wrap(as.formula(paste('~', facetVar)), ncol=2)
	return(p)
}

chiSquareSummary <- function (df, var1, var2) {
	table_  <- xtabs(Freq ~ df[[var1]]+df[[var2]], data=df)
	chiValue <- chisq.test(table_)
	return (chiValue)
}


writeToCSV <- function(df) {
	write.csv(dfTable, paste("./results/cross_table", var1, var2, '.csv', sep=''), 
			  row.names=FALSE)

	dev.off()
}
