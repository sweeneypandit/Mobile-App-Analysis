# Mobile-App-Analysis
Analysing the factors that affect and determine app ratings.
The dataset is downloaded from Kaggle : https://www.kaggle.com/ramamet4/app-store-apple-data-set-10k-apps
 
 ( I removed the rows containing NA's)
I choose this dataset to run some basic models on it to predict what factors would affect the app ratings. I used two approach
of modelling.

Approach 1

 If you look at the dataset the column user rating is a range of values from 0-5. I narrowed down my analysis to just two categories
of app rating good (1) and bad rating (0) as dependent variable.I did this by taking a mean of the user rating column and then classified the rating above mean
as good and the ratings below mean as bad. I created a new column called rating which would keep this classification into account.
Following are the models I created for this approach
a)KSVM- I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
        The accuracy of the model was calculated by % correct prediction. % correct prediction for this model is 70%.
b)SVM- I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
       The accuracy of the model was calculated by % correct prediction. % correct prediction for this model is 67%.
c)Naive Bayes- I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
               The accuracy of the model was calculated by % correct prediction. % correct prediction for this model is 68%.
d)Random Forest- I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
                 The accuracy of the model was calculated by % correct prediction. % correct prediction for this model is 71%.
                 
This approach gave me Random Forest as my best prediction model , though a score of 71% is not very good.

So here is the thing, I wanted the variable importance in the prediction of my models and I knew that Randomforest does give me that feature
but I wanted that for other models as well. I came across a package called rminer which provides us that facility. So my second approach
of modelling is also stating the variable importance in each model.

Approach 2:

In this method, I used the user rating column as contiunous measure for my dependent variable.
Following are the models I created for this approach
a)KSVM- I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
        The accuracy of the model was calculated by root mean square error of model(rmse). rmse value for this model is 1.436
b)SVM-  I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
        The accuracy of the model was calculated by root mean square error of model(rmse). rmse value for this model is 1.401
c) Random Forest -I used all the atttributes as independent variables in the model as I got the highest correct prediction by including all.
        The accuracy of the model was calculated by root mean square error of model(rmse). rmse value for this model is 1.30442     
----------------Variable Importance---------------------------------------------------------------------------------------
Language number supported by app, prime genre,price variables hold most importance in order in all the models. 
------------------------------------------------------ Best Model---------------------------------------------------------
My best model is random forest with least rmse 1.30 and good% prediction of 72 followed by ksvm, svm.

Descriptive analysis

I created 3 simple visual analysis using ggplot for the variable importance affecting user rating
1) Scatter plot between language number and user rating - here I found that the majority language number offered less than 20 tend to have higher user rating so there is some pattern that affects app rating which was also concluded by the variable importance of the model.

2)Scatter plot between price and user rating - As expected the lower the price of the app the higher is the trend of app rating which is not new and also strongly affected in the model.

3) Barplot between prime genre and rating - The  game genre has the highest number of user ratings followed by social network genre This
also is somewhat biased towards rating.
                 
                 
                 
****** You would need to have R studio installed in the system to run this script****************************************
Thank you
                 
