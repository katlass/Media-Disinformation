#Converting discordance scores to Z scores to be plotted for interactive component
#The data is normalized and circles are placed based on standard deviations from the mean.
dataset$participant_id=1:nrow(dataset)
dataset2=select(dataset,c("participant_id","discordant_rt","ideology"))
dataset2$zscore=scale(dataset2$discordant_rt)
dataset2=dataset2[order(dataset2$ideology),]
dput(dataset2$zscore)

#Getting y coordinates to place circles for each participant
y=seq(5,555,length.out=nrow(dataset2))

#Printing output as a list to paste into D3 file
dput(y)

#An alternate methodology was tested where the median value was the center of the interactive chart, and minmax scaling was used on either side to place circles. Please see interactive_prep_median.R