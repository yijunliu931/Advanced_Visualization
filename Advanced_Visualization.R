getwd()
setwd("D:\\R\\Rcode")
movies <- read.csv("P2-Movie-Ratings.csv")
head(movies)
colnames(movies) <- c("Film","Genre", "CriticRating", "AudienceRating", "BudgetMillion", "year")
head(movies)
tail(movies)
str(movies)
summary(movies)
factor(movies$year)

movies$year <- factor(movies$year)
head(movies)
str(movies)

# ------------Aesthetic-------------
libray(ggplot2)
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

#add geometry
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating)) + 
  geom_point()

#add colour
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=Genre)) + 
  geom_point()

#add size - better way
ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillion)) + 
  geom_point()


#--------Plotting with layers----------
p <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre, size=BudgetMillion))

#point
p + geom_point()

#lines
p + geom_line()

#multiple layers
p + geom_line() + geom_point()


#----------overriding Aesthetics------------
q <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,colour=Genre,size=BudgetMillion))

#add geom layer
q + geom_point()

#overriding aes
q + geom_point(aes(size=CriticRating))

q + geom_point(aes(colour=BudgetMillion))

q + geom_point(aes(x=BudgetMillion))+xlab("Budget Million $$$")

p + geom_line(size=0.1) + geom_point(size=0.1)


r <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating))

r + geom_point()


#Add colour

#1. Mapping
r + geom_point(aes(colour=Genre))

#2. Setting
r + geom_point(colour="DarkGreen")

#1. Mapping
r + geom_point(aes(size=BudgetMillion))

#2. Setting
r + geom_point(size=10)



#----------- Histograms and Density Charts-------
s <- ggplot(data=movies, aes(x=BudgetMillion))
s + geom_histogram(binwidth=10)

#Add colour
s + geom_histogram(binwidth = 10, aes(fill=Genre))

#add a border

s + geom_histogram(binwidth = 10, aes(fill=Genre), colour="black")


#we will improve it
s + geom_density(aes(fill=Genre), position = "stack")

t <- ggplot(data=movies, aes(x=AudienceRating))
t + geom_histogram(binwidth = 10, fill="white",colour="Blue")


#another way:
t <- ggplot(data=movies)
t + geom_histogram(binwidth = 10, aes(x=AudienceRating), fill = "white", colour = "Blue")


#further
t + geom_histogram(binwidth = 10, aes(x=CriticRating), fill = "white", colour = "Blue")

#-----------Statistical Transformation--------
u <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,colour=Genre))
u + geom_point() + geom_smooth(fill=NA)


#boxplots
u <- ggplot(data=movies, aes(x=Genre, y=AudienceRating, colour=Genre))

u + geom_boxplot()
u + geom_boxplot(size=1.2)
u + geom_boxplot(size=1.2) + geom_point()


#tips/hack:
u + geom_boxplot(size=1.2)+geom_jitter()

#another way:
u + geom_jitter() + geom_boxplot(size=1.2, alpha=0.5)

#----------Using Facets--------
v <- ggplot(data=movies, aes(x=BudgetMillion))
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour = "Black")


#facets
v + geom_histogram(binwidth = 10, aes(fill=Genre), colour = "Black")+
  facet_grid(Genre~., scales = "free")


#scatterplots
w <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating, colour=Genre))
w + geom_point(size=3)



#facets
w + geom_point(size=3)+facet_grid(Genre~.)
w + geom_point(size=3)+facet_grid(.~year)
w + geom_point(size=3)+facet_grid(Genre~year)
w + geom_point(aes(size=BudgetMillion))+geom_smooth()+facet_grid(Genre~year)

#--------Coordinates---------
#limites
#zoom
m <- ggplot(data=movies, aes(x=CriticRating, y=AudienceRating,size=BudgetMillion,colour=Genre))
m + geom_point()
m + geom_point() + xlim(50,100) + ylim(50,100)


#wom't work well always
n <- ggplot(data=movies, aes(x=BudgetMillion))
n + geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")
n + geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+ylim(0,50)

n + geom_histogram(binwidth = 10,aes(fill=Genre),colour="Black")+ coord_cartesian(ylim = c(0,50))

#improve
w + geom_point(aes(size=BudgetMillion))+geom_smooth()+facet_grid(Genre~year)+coord_cartesian(ylim = c(0,100))

#----------Theme--------
o <- ggplot(data=movies,aes(x=BudgetMillion))
h <- o + geom_histogram(binwidth = 10, aes(fill=Genre), colour="Black")


#axes labels
h + xlab("Money Axis") + ylab("Number of Movies")


#label formatting
h +
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen",size=30),
        axis.title.y = element_text(colour = "Red",size=30))

#tick mark formatting
h +
  xlab("Money Axis") +
  ylab("Number of Movies") +
  theme(axis.title.x = element_text(colour = "DarkGreen",size=30),
        axis.title.y = element_text(colour = "Red",size=30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size=20))


#legend formatting
h +
  xlab("Money Axis") +
  ylab("Number of Movies") +
  ggtitle("Movie Budget Distribution")
  theme(axis.title.x = element_text(colour = "DarkGreen",size=30),
        axis.title.y = element_text(colour = "Red",size=30),
        axis.text.x = element_text(size = 20),
        axis.text.y = element_text(size=20),
        legend.title = element_text(size=30),
        legend.text = element_text(size=20),
        legend.position = c(1,1),
        legend.justification = c(1,1),
        plot.title = element_text(colour = "DarkBlue",
                                  size=40,
                                  family = "Courier"))

















