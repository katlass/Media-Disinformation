#An alternate methodology was used where the data was normalized and circles were placed based on standard deviations from the mean. Please see interactive_prep_mean.R

#min max scaling, subtracting median value
range01 <- function(x){(x-min(x))/(max(x)-min(x))}
dataset2=select(dataset,c("participant_id","discordant_rt","ideology"))
dataset2$diff=dataset2$discordant_rt-median(dataset2$discordant_rt)

#scaling the positive values such that 0.5 becomes the minimum, so this is to the right of the median/middle of the screen
pos=filter(dataset2,diff>0)
pos$scaled=range01(pos$discordant_rt)
pos$scaled2=0.5+(range01(pos$discordant_rt)*.50)

#scaling the negative values such that 0.5 becomes the maximum, so this is to the left of the median/middle of the screen
neg=filter(dataset2,diff<0)
neg$scaled=range01(neg$discordant_rt)
neg$scaled2=range01(neg$discordant_rt)*.50

#Correction so no points are drawn off screen
pos$scaled3=ifelse(pos$scaled2==1,pos$scaled2*0.99,pos$scaled2)
neg$scaled3=ifelse(neg$scaled2==0,neg$scaled2+.01,neg$scaled2)

#Median value is now 0.5, i.e 50% of the pixel width in the svg
med=filter(dataset2,diff==0)
med$diff=0.5
colnames(med)=c("participant_id","discordant_rt","ideology","scaled3")

#Binding together final dataframe
final=rbind(neg,pos)
final=select(final,c("participant_id","discordant_rt","ideology","scaled3"))
final=rbind(med,final)
final=final[order(final$ideology),]

#Printing output as a list to paste into D3 file
dput(final$scaled3)