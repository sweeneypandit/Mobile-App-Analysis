#libraries to download
install.packages("kernlab")
install.packages("e1071")
install.packages("randomForest")
install.packages("rminer")
#-----------------------
file<-file.choose()
df<- read.csv(file)
df<-na.omit(df)
#converting user rating to number
df$user_rating<-as.numeric(df$user_rating)
#taking mean of the user rating
mean_rating<-mean(df$user_rating)
#creating good rating column in dataset 
df$rating<-0
#getting the index value for user rating level below mean
badrating<-which(df$user_rating< mean_rating)
#getting the index value for user rating above mean
goodrating<-which(df$user_rating> mean_rating)
#giving value 0 for bad rating where user rating is below mean level
df[badrating,18]<-"0"
#giving value 1 for good rating where user rating is above mean level
df[goodrating,18]<-"1"
#copying dataset to df1
df1<-df
#converting ratings to factor
df1$rating<-as.factor(df1$rating)
#df1$rating<-as.numeric(df1$rating)
#creating random sample for the df1 dataset
randIndex <- sample(1:dim(df1)[1])
#dividing dimension into 2/3
cutPoint2_3 <- floor(2*dim(df1)[1]/3)
#creating train dataset for the rating variable dataset
trainData <- df1[randIndex[1:cutPoint2_3],]
#using the remainder data as test data
testData <-df1[randIndex[(cutPoint2_3+1):dim(df1)[1]],]
#creating model ksvm to predict rating  by all attributes
ksvmOutput <-ksvm(rating ~ver+lang.num+price+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes, data=trainData)

#using model to predict testdata
ksvmPred<- predict(ksvmOutput,testData)
#tabulating the results
results<-table(ksvmPred,testData$rating)
print(results)


#calculating percent correct predicted goodrating
perGoodrating <- (results[1,1]+results[2,2])/(results[1,1]+results[1,2]+results[2,1]+results[2,2])*100
#rounding the result
round(perGoodrating)

#creating model svm to predict rating  by all attributes
svmOutput <-svm(rating ~ver+lang.num+price+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes, data=trainData)
#using model to predict testdata
svmPred<- predict(svmOutput,testData)
#tabulating the results
results<-table(svmPred,testData$rating)
print(results)
#calculating percent correct predicted goodrating
perGoodrating <- (results[1,1]+results[2,2])/(results[1,1]+results[1,2]+results[2,1]+results[2,2])*100
#rounding the result
round(perGoodrating)

#creating model naive bayes to predict rating  by all attributes
nbOutput <-naiveBayes(rating ~ver+lang.num+price+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes, data=trainData)
#using model to predict testdata
nbPred<- predict(nbOutput,testData)
#tabulating the results
results<-table(nbPred,testData$rating)
print(results)
#calculating percent correct predicted goodrating
perGoodrating <- (results[1,1]+results[2,2])/(results[1,1]+results[1,2]+results[2,1]+results[2,2])*100
#rounding the result
round(perGoodrating)
df1$ver<-as.numeric(df1$ver)
#Trying random forest
rfOutput <- randomForest(rating ~ver+price+lang.num+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes
                         , data=trainData,ntree = 5000, importance = TRUE)
#predicting testdata from random forest 
rfPred <- predict(rfOutput,testData)
#tabulating results
results<-table(rfPred,testData$rating)
#print results
print(results)
#calculating percent correct predicted goodrating
perGoodrating <- (results[1,1]+results[2,2])/(results[1,1]+results[1,2]+results[2,1]+results[2,2])*100
#rounding the result
round(perGoodrating)
importance(rfOutput)

# predicting  original continuous data of user rating along with variable importance
#using ksvm model
#defining function rmse to calculate rmse value
rmse <- function(error){sqrt(mean(error^2))}
model=fit(user_rating~ver+lang.num+price+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes,trainData,model="ksvm")
#predicting testdata from the ksvm model
ksvmPred <- predict(model,testData)
#calculating error
error<-testData$user_rating-ksvmPred
#calling function rmse
rmse(error)
#variable importance
VarImportance<-Importance(model,trainData,method = "sens")
#plotting the graph for variable importance
L=list(runs=1,sen=t(VarImportance$imp),sresponses=VarImportance$sresponses)
mgraph(L,graph="IMP",leg=names(trainData),col="red")
#using svm model
model=fit(user_rating~ver+lang.num+price+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes,trainData,model="svm")
#predicting testdata from the ksvm model
svmPred <- predict(model,testData)
#calculating error
error<-testData$user_rating-svmPred
#calling function rmse
rmse(error)
#variable importance
VarImportance<-Importance(model,trainData,method = "sens")
#plotting the graph for variable importance
L=list(runs=1,sen=t(VarImportance$imp),sresponses=VarImportance$sresponses)
mgraph(L,graph="IMP",leg=names(trainData),col="blue")
#Trying random forest
model=fit(user_rating~ver+lang.num+price+cont_rating+vpp_lic+sup_devices.num+ipadSc_urls.num+cont_rating+prime_genre+size_bytes,trainData,model="randomForest")
#predicting testdata from the ksvm model
rfPred <- predict(model,testData)
#calculating error
error<-testData$user_rating-rfPred
#calling function rmse
rmse(error)
#variable importance
VarImportance<-Importance(model,trainData,method = "sens")
#plotting the graph for variable importance
L=list(runs=1,sen=t(VarImportance$imp),sresponses=VarImportance$sresponses)
mgraph(L,graph="IMP",leg=names(trainData),col="green")
----------------------------------------------------------------
#interpretation
# for ksvm and svm  price, prime_genre,ver,app_lic important var
#for random forest ipadSc_urls.num, cont_rating, lang.num, ver , size improtant var  
#best model is random forest with least rmse 1.30 and good% prediction of 72 followed by ksvm, svm
  ---------------------------------------------------------------
#descriptive analysis
#scatter plot with lang num and price affect over user rating  
ggplot(df1, aes(x=df1$lang.num, y=df1$user_rating)) + geom_point()
ggplot(df1,aes(x=df1$price,y=df1$user_rating))+ geom_point()
#grouping acc to prime f=genre and user rating
df2<-sqldf('select count(df1.prime_genre), df1.prime_genre, df1.user_rating
from df1 group by df1.user_rating')
#plotting analysis
ggplot(df2, aes(x=df2$prime_genre, y=df2$`count(df1.prime_genre)`, colour=df2$user_rating)) + geom_line(size=10)
