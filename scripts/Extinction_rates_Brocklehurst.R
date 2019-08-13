#############################################################################
###
### Function for calculating extinction rates using the gap fillers method 
### (Alroy 2014), with the option of the 2 for 3 correction (Alroy 2015).
### For calculating origination rates, the input data matrix may be mirrord,
### and then the output reversed (effectively origination is treated as 
### extinction in reverse; see Alroy [2014])
###
### Arguments required:
### data: a presence/absence matrix with taxa in rows and stratigraphic levels
###       in columns.
###
### method: two options - "gap fillers" represents the basic gap filler method
###         of Alroy (2014). "2 for 3" represents the modification suggested 
###         in Alroy (2015)
###
### samp.stand: logical, whether or not to standardise the sample size in each
###             time bin by rarefaction
###
### samp.stand.iter: number of rarefaction trials to be carried out
###
### samp.stand.size: number of samples to be drawn from each time bin in each
###                  rarefaction trial
###
#############################################################################


## See paper here: https://peerj.com/articles/4767/ for an example of this application



alroy.ext.rates<-function(data,method=c("gap fillers","2 for 3"),samp.stand=TRUE,samp.stand.iter=100,samp.stand.size=5)
{
		
	if(samp.stand==T)
	{
		no.trials<-samp.stand.iter
	}
	else(no.trials<-1)

	trial.results<-matrix(nrow=no.trials,ncol=ncol(data),data=NA)
	
	for(w in 1:no.trials)
	{
		if(samp.stand==F)
		{
			test.data<-data
		}
		else
		{
			test.data<-matrix(nrow=nrow(data),ncol=ncol(data),data=0)
			for(i in 1:ncol(test.data))
			{
				if(sum(data[,i])>=samp.stand.size)
				{
					test.data[sample(which(data[,i]==1),samp.stand.size,replace=F),i]<-1
				}
			}
		}
				

		for(i in 2:(ncol(data)-2))
		{
				

			i1.tax<-which(test.data[,i]==1)
			i0.tax<-which(test.data[,i-1]==1)
			i2.tax<-which(test.data[,i+1]==1)
			i3.tax<-which(test.data[,i+2]==1)

			two.timers<-length(intersect(i1.tax,i0.tax))
			three.timers<-length(intersect(intersect(i1.tax,i0.tax),i2.tax))
	
			i0.i2.tax<-intersect(i0.tax,i2.tax)
			part.timers<-length(setdiff(i0.i2.tax,i1.tax))

			i0.i3.tax<-intersect(i0.tax,i3.tax)
			gap.fillers<-length(setdiff(i0.i3.tax,i2.tax))

			if(method=="gap fillers")
			{
				GF.E<-1-(three.timers+part.timers+gap.fillers)/(two.timers+part.timers)
				trial.results[w,i]<-GF.E
			}
			else
			{
				i0.i1.tax<-intersect(i0.tax,i1.tax)
				s1<-0
				if(length(i0.i1.tax)>0)
				{
					for(j in 1:length(i0.i1.tax))
					{
						if(1%in%test.data[i0.i1.tax[j],(i+1):ncol(test.data)]==F)
						{
							s1<-s1+1
						}
					}	
				}
		
				s2<-length(setdiff(i0.i2.tax,unique(c(i1.tax,i3.tax))))
			
				s3<-length(setdiff(i0.i3.tax,unique(c(i1.tax,i2.tax))))

				sorted<-sort(c(s1,s2,s3))		
				mod.GF.E<-(s1-sorted[2])/(two.timers+part.timers)
				
			
				trial.results[w,i]<-mod.GF.E
			}
		}
	}
	output<-colMeans(trial.results,na.rm=T)
	
	return(output)
}
	
