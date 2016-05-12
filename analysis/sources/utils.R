rbindAllCol  <-  function(...){
	list_df  <-  list(...)
	x  <- as.data.frame(list_df[1])
	for (e in list_df[-1]){
		xDiff <- setdiff(colnames(x), colnames(e))
		eDiff <- setdiff(colnames(e), colnames(x)) 
		if (!is.null(eDiff)){
			x[, c(as.character(eDiff))]  <- NA
		}
		if (!is.null(xDiff)){
			e[, c(as.character(xDiff))]  <- NA
		}
		x  <- rbind(x, e)
		}
	return(x)
}