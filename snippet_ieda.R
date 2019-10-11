# copy the below code into the file ~/.R/snippets/r.snippets
snippet ieda
	# Cleaning up column names
	${1:data} = ${1:data} %>% as_tibble %>% janitor::clean_names()

	# Data Description
	${1:data} %>% skimr::skim()

	# Data validity - missing values at the data set level
	${1:data} %>% na.exclude() %>% skimr::skim()

	${1:data} %>% .[!complete.cases(.), ]

	# Univariate data validity - 0s, outliers, invalid values
	${1:data} %>% dataMaid::check()

	${1:data} %>% dataMaid::visualize()

	dev.off()

	# Bivariate data validity

	${1:data} %>% GGally::ggpairs() # increase cardinality_threshold = 15 parameter

	# Multivariate outliers 
	# ${1:data}Q = ${1:data} %>% fastDummies::dummy_cols(remove_first_dummy = T) 

	dfMVoutlier = ${1:data} %>% 
		select_if(is.numeric) %>% 
		MASS::cov.mcd(., quantile.used = nrow(.)*.75)

	dfMVoutlier = ${1:data} %>% 
		select_if(is.numeric) %>%  
		mahalanobis(., dfMVoutlier$center, dfMVoutlier$cov)

	vcMVoutlier = which(dfMVoutlier > 
		(qchisq(p = 1 - 0.001, 
						df = ncol(select_if(${1:data}, is.numeric)))))
	# adjust 0.001 up/down to make the detection more/less sensitive

	${1:data}[-vcMVoutlier, ] # w/o multivariate outliers

	${1:data}[vcMVoutlier, ] # only multivariate outliers

	# one way to plot the multivariate outliers, correlation biplot
	${1:data} %>% 
		select_if(is.numeric) %>% 
		prcomp(center = T, scale. = T) %>% 
		ggbiplot::ggbiplot(circle = T, 
			groups = rownames(${1:data}) %in% as.character(vcMVoutlier)) + 
		scale_colour_viridis(discrete = T)


