#check the missing values
colSums(is.na(cement))
rowSums(is.na(cement))

#1.3remove duplicates
#view the duplicated rows
duplicates <- duplicated(cement)

# View duplicate rows
cement[duplicates, ]

cement_clean=cement[!duplicated(cement),]
cement_clean

View(cement_clean)

# detect outliers
boxplot(cement_clean$Cement,main="Distribution of Cement",ylab="cement in kg in a m3",
        col="gray",border="black")

boxplot(cement_clean$`Blast Furnace Slag`,main="Distribution of blast furnace slag",
        ylab="blast furnace slag in kg in a m3",col="red",border="black") 

boxplot(cement_clean$`Fly Ash`,main="Distribution of Fly ash",ylab="Fly ash in kg in a m3",
        col="cyan",border="black")

boxplot(cement_clean$Water,main="Distribution of Water",
        ylab="Water in kg in a m3",col="darkblue",border="black") #outliers

boxplot(cement_clean$Superplasticizer,main="Distribution of Superplasticizer",
        ylab="Superplasticizer in kg in a m3",col="darkgreen",border="black") #outliers
hist(cement$Superplasticizer)

boxplot(cement_clean$`Coarse Aggregate`,main="Distribution of Coarse Aggregate",
        ylab="Coarse Aggregate in kg in a m3",col="orange",border="black")

boxplot(cement_clean$`Fine Aggregate`,main="Distribution of Fine Aggregate",
        ylab="Fine Aggregate in kg in a m3",col="magenta",border="black")

boxplot(cement_clean$`Age (day)`,main="Distribution of Age",ylab="Age in (1~365)",
        col="yellow",border="black") #outliers
hist(cement$`Age (day)`)

boxplot(cement_clean$`Concrete compressive strength`,main="Distribution of Concrete compressive strength",
        ylab="Concrete compressive strength in MPa",col="brown",border="black")  #outliers

hist(cement$`Concrete compressive strength`)

#Handling outliers for water(winzorisation)
# Set the lower and upper percentiles for capping (e.g., 5th and 95th percentiles)
lower_cap <- quantile(cement_clean$Water, 0.05)
upper_cap <- quantile(cement_clean$Water, 0.95)

# Apply Winsorization: cap values outside the 5th and 95th percentiles
Water_winsorized <- cement_clean$Water
Water_winsorized[cement_clean$Water < lower_cap] <- lower_cap
Water_winsorized[cement_clean$Water > upper_cap] <- upper_cap

# View the Winsorized data
boxplot(Water_winsorized,main="Distribution of Water",
        ylab="Water in kg in a m3",col="darkblue",border="black")


#detect outliers in Superplasticizer (log transformation)
Superplasticizer_log <- log(cement_clean$Superplasticizer + 1)  # Add 1 to avoid log(0)
boxplot(Superplasticizer_log,main="Distribution of Superplasticizer",
        ylab="Superplasticizer in kg in a m3",col="darkgreen",border="black")

#detect outliers in blast furnace slag (log transformation)
blast_furnace_slag_log <- log(cement_clean$`Blast Furnace Slag` + 1)
boxplot(blast_furnace_slag_log,main="Distribution of blast furnace slag",
        ylab="blast furnace slag in kg in a m3",col="red",border="black") 

#detect outliers in fine aggregate (winsorization)
lower_cap <- quantile(cement_clean$`Fine Aggregate`, 0.05)
upper_cap <- quantile(cement_clean$`Fine Aggregate`, 0.95)

# Apply Winsorization: cap values outside the 5th and 95th percentiles
fine_winsorized <- cement_clean$`Fine Aggregate`
fine_winsorized[cement_clean$`Fine Aggregate` < lower_cap] <- lower_cap
fine_winsorized[cement_clean$`Fine Aggregate` > upper_cap] <- upper_cap

boxplot(fine_winsorized,main="Distribution of Fine Aggregate",
        ylab="Fine Aggregate in kg in a m3",col="magenta",border="black")

#detect outliers in Age (log transformation)
age_log <- log(cement_clean$`Age (day)` + 1)
boxplot(age_log,main="Distribution of Age",ylab="Age in (1~365)",col="yellow",border="black")


#detect outliers in concrete compressive strength (capping)
# Define lower and upper caps (e.g., 1st and 99th percentiles)
lower_cap <- quantile(cement_clean$`Concrete compressive strength`, 0.05)
upper_cap <- quantile(cement_clean$`Concrete compressive strength`, 0.95)

# Cap the outliers
concrete_cap <- pmin(pmax(cement_clean$`Concrete compressive strength`, lower_cap), upper_cap)

boxplot(concrete_cap,main="Distribution of Concrete compressive strength",
        ylab="Concrete compressive strength in MPa",col="brown",border="black")


X=matrix(data=c(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                415,550,415,550,415,550,415,550,415,550,415,550,415,550,415,550,
                25,25,95,95,25,25,95,95,25,25,95,95,25,25,95,95,
                5,5,5,5,15,15,15,15,5,5,5,5,15,15,15,15,
                40,40,40,40,40,40,40,40,60,60,60,60,60,60,60,60,
                1.28,4.05,4.05,1.28,4.05,1.28,1.28,4.05,4.05,1.28,1.28,4.05,1.28,4.05,4.05,1.28),nrow=16,ncol=6)
X
X1=t(X)
X1

inv=X1%*%X
solve(inv)
inv

Y=matrix(c(63,21,36,99,24,66,71,54,23,74,80,33,63,21,44,96),nrow=16,ncol=1)

hi=X1%*%Y
beeta=inv%*%hi
beeta

b1=t(beeta)

sol=b1%*%hi
sol-(868^2/16)

10363-(7.1702*10^-17)


# Example data
x1 <- c(0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02, 0.02, 
        0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05,0.05)  # Amount of surfactant
x2 <- c(10,50,85,110,140,170,200,230,260,290,10,30,62,90,150,210,270,10,
        30,60,90,120,210,30,60,120,150,20,40,130,190,250,60,90,120,150)    # Time
y <- c(7.5,15,22,28.6,31.6,34,35,36.5,38.5,12.3,18,20.8,25.7,32.5,34,35,14.4,
       19,26.4,28.5,29,35,15.1,26.4,27,29,21,27.3,48.5,50.4,52.5,34.4,46.5,50,51.9)  # Clathrate formation

mod=data.frame(x1,x2,y)
# Create matrix X with a column of 1s for the intercept
X <- cbind(1, x1, x2)

# Convert y into a matrix (or vector)
y <- matrix(y, ncol = 1)

# Compute X'X
XtX <- t(X) %*% X
XtX

# Compute X'y
Xt <- t(X)
Xt
Xdy=Xt %*% y
Xdy

# Compute (X'X)^-1
XtX_inv <- solve(XtX)
XtX_inv

XtX# Compute the coefficients
beta <- XtX_inv %*% Xty

# Print the coefficients
beta


