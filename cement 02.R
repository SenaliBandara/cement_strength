#check distribution of the dependent variable
hist(concrete_cap,prob=T,main="Distribution of Concrete compressive strength",
     xlab="Concrete compressive strength in MPa",col="brown",border="black")
lines(density(concrete_cap),lwd=2,col="darkblue")


#Rename variables
cem=cement_clean$Cement
blast=blast_furnace_slag_log
ash=cement_clean$`Fly Ash`
water=water_winsorized
super=Superplasticizer_log
cors=cement_clean$`Coarse Aggregate`
fine=fine_winsorized
age=age_log
con=concrete_cap

#create dataframe with renamed columns
cement_new=data.frame(cem,blast,ash,water,super,cors,fine,age,con)

View(cement_new)

#================================================================================================

#build the model
#split the dataset
library(caTools)
set.seed(123)
split=sample.split(cement_new$con,SplitRatio = 0.7)
training=subset(cement_new,split==T)
testing=subset(cement_new,split==F)

#build the model on training data
con_model=lm(con~cem+blast+ash+water+super+cors+fine+age,data=training)
con_model
summary(con_model)
aov(con_model)

#make predictions
predict_con=predict(con_model,newdata = testing)
predict_con

#Model selection

#To find significance variables automatically
library(MASS)

# backward
library(olsrr)

back_mod=ols_step_backward_p(con_model)
back_mod

back_mod=lm(con~cem+blast+water+super+fine+age,data=training)
back_mod

predict_back=predict(back_mod,newdata = testing)
predict_back

#===========================================================================================

#check both models for perfomance


#ANOVA table
anova_con=anova(con_model)
anova_con

anova_back=anova(back_mod)
anova_back



#=========================================================================================
#residual analysis

#1.check linearlity and Heteroscedasticity(visualization)
con_res=rstandard(con_model)
plot(con_model$fitted.values,con_res, 
     xlab = "Fitted Values", ylab = "St_Residuals", 
     main = "Residuals vs Fitted",col="darkblue")
abline(h = 0, col = "red")


back_res=rstandard(back_mod)
plot(back_mod$fitted.values,back_res, 
     xlab = "Fitted Values", ylab = "St_Residuals", 
     main = "Residuals vs Fitted",col="green")
abline(h = 0, col = "red")
mean(con_model$residuals)

#2.Check normality of residuals

#Normal Q-Q plot
qqnorm(residuals(con_model),col="darkblue")
qqnorm(residuals(back_mod),col="green")

#shapiro test
shapiro.test(con_model$residuals)
shapiro.test(back_mod$residuals)

#visualize using histogram
hist(con_model$residuals,main="Distribution of the residuals",
     prob=T,xlab="Residuals",col="darkblue",border="black")
lines(density(con_model$residuals),col="red",lwd=2)

hist(back_mod$residuals,main="Distribution of the residuals",
     prob=T,xlab="Residuals",col="green",border="black")
lines(density(back_mod$residuals),col="red",lwd=2)

#3.correlation among residuals(independece among residuals)
library(lmtest)
dwtest(con_model)
dwtest(back_mod)


#4.linerity of variables with response variable(multicorlinarlity)
#calculate VIF (Variance Inflation Factor)
library(car)
vif(con_model)
vif(back_mod)

#correlation matrix
library(corrplot)
cor_matrix <- cor(training[, c("cem","blast","ash","water","super","cors","fine","age")])
View(cor_matrix)

#correlation plot
corrplot(cor_matrix, method = "circle", type = "full", order = "hclust", 
         col = colorRampPalette(c("blue", "white", "red"))(200), 
         addCoef.col = "black",  # Add correlation coefficients
         tl.col = "black",       # Color of the text labels
         tl.srt = 45,            # Rotate text labels
         title = "Correlation Plot for Training Data")

#Overall performances
library(performance)
check_outliers(con_model)
check_model(con_model)

check_outliers(back_mod)
check_model(back_mod)
summary(back_mod)
vif(back_mod)
#===========================================================================================
#models performance

#AIC & BIC
con_aic=AIC(con_model)
back_aic=AIC(back_mod)

con_bic=BIC(con_model)
back_bic=BIC(back_mod)

data.frame(model=c("con_model","back_mod"),AIC=c(con_aic,back_aic),BIC=c(con_bic,back_bic))
