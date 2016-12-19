myfct <- function(x1) {
	noise <- rnorm(1,0,1)
	retVal <- 2 * cos(2.8 * x1) + 7.5 + noise
	return(retVal)
}

x <- runif(20,0,5)
x <- sort(x, decreasing = FALSE)
y <- vector(,2000)
y1 <- vector(,20)
y2 <- vector(,20)
y3 <- vector(,20)
y4 <- vector(,20)
y5 <- vector(,20)

ytotal <- vector(,20)

i <- 1
j <- 1

while ( j <= 100) {
	i <- 1
	while(i <= 20) {
		index <- i + (j-1) * 20
		y[index] <- myfct(x[i])
		ytotal[i] <- ytotal[i] + y[i]
		if (j == 1){
			y1[i] <- y[i]
		}
		if (j == 2){
			y2[i] <- y[i + 20]
		}
		if (j == 3){
			y3[i] <- y[i + 40]
		}
		if (j == 4){
			y4[i] <- y[i + 60]
		}
		if (j == 5){
			y5[i] <- y[i + 80]
		}
		i <- i + 1
	}
	j <- j + 1
}
k <- 1
while(k <= 20) {
	ytotal[i] <- ytotal[i] / 20
	k <- k + 1
}

lm1 = lm(y1~x)
lm2 = lm(y1~x+I(x^2))

myfct <- function(x1) {
	noise <- rnorm(1,0,1)
	retVal <- 2 * cos(2.8 * x1) + 7.5 + noise
	return(retVal)
}

x <- runif(20,0,5)
x <- sort(x, decreasing = FALSE)
y <- vector(,2000)
y1 <- vector(,20)
y2 <- vector(,20)
y3 <- vector(,20)
y4 <- vector(,20)
y5 <- vector(,20)

ytotal <- vector(,20)

i <- 1
j <- 1

while ( j <= 100) {
	i <- 1
	while(i <= 20) {
		index <- i + (j-1) * 20
		y[index] <- myfct(x[i])
		ytotal[i] <- ytotal[i] + y[index]
		if (j == 1){
			y1[i] <- y[i]
		}
		if (j == 2){
			y2[i] <- y[i + 20]
		}
		if (j == 3){
			y3[i] <- y[i + 40]
		}
		if (j == 4){
			y4[i] <- y[i + 60]
		}
		if (j == 5){
			y5[i] <- y[i + 80]
		}
		i <- i + 1
	}
	j <- j + 1
}
k <- 1
while(k <= 20) {
	ytotal[k] <- ytotal[k] / 100
	k <- k + 1
}
dev.new()
plot(x,y1)
xplot=seq(0,5,length=200)
xplot2=seq(0,5,length=200)
xplot3=seq(0,5,length=200)
xplot4=seq(0,5,length=200)
xplot5=seq(0,5,length=200)
xplot6=seq(0,5,length=200)


lm1 = lm(y1~x)
lm2 = lm(y1~x+I(x^2))
lm3 = lm(y1~x+I(x^2)+I(x^3))
lm4 = lm(y1~x+I(x^2)+I(x^3)+I(x^4))
lm5 = lm(y1~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))

l2m1 = lm(y2~x)
l2m2 = lm(y2~x+I(x^2))
l2m3 = lm(y2~x+I(x^2)+I(x^3))
l2m4 = lm(y2~x+I(x^2)+I(x^3)+I(x^4))
l2m5 = lm(y2~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))

l3m1 = lm(y3~x)
l3m2 = lm(y3~x+I(x^2))
l3m3 = lm(y3~x+I(x^2)+I(x^3))
l3m4 = lm(y3~x+I(x^2)+I(x^3)+I(x^4))
l3m5 = lm(y3~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))

l4m1 = lm(y4~x)
l4m2 = lm(y4~x+I(x^2))
l4m3 = lm(y4~x+I(x^2)+I(x^3))
l4m4 = lm(y4~x+I(x^2)+I(x^3)+I(x^4))
l4m5 = lm(y4~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))

l5m1 = lm(y5~x)
l5m2 = lm(y5~x+I(x^2))
l5m3 = lm(y5~x+I(x^2)+I(x^3))
l5m4 = lm(y5~x+I(x^2)+I(x^3)+I(x^4))
l5m5 = lm(y5~x+I(x^2)+I(x^3)+I(x^4)+I(x^5))

average1 = lm(ytotal~x)
average2 = lm(ytotal~x+I(x^2))
average3 = lm(ytotal~x+I(x^2)+I(x^3))
average4 = lm(ytotal~x+I(x^2)+I(x^3)+I(x^4))
average5 = lm(ytotal~x+I(x^2)+I(x^3)+I(x^4)+I(x^5)) 

lines(xplot,predict(lm1,newdata=data.frame(x=xplot)), col="blue")
lines(xplot,predict(lm2,newdata=data.frame(x=xplot)), col="red")
lines(xplot,predict(lm3,newdata=data.frame(x=xplot)), col="yellow")
lines(xplot,predict(lm4,newdata=data.frame(x=xplot)), col="green")
lines(xplot,predict(lm5,newdata=data.frame(x=xplot)), col="purple")

dev.new()
plot(x,y2)
lines(xplot2,predict(l2m1,newdata=data.frame(x=xplot2)), col="blue")
lines(xplot2,predict(l2m2,newdata=data.frame(x=xplot2)), col="red")
lines(xplot2,predict(l2m3,newdata=data.frame(x=xplot2)), col="yellow")
lines(xplot2,predict(l2m4,newdata=data.frame(x=xplot2)), col="green")
lines(xplot2,predict(l2m5,newdata=data.frame(x=xplot2)), col="purple")

dev.new()
plot(x,y3)
lines(xplot3,predict(l3m1,newdata=data.frame(x=xplot3)), col="blue")
lines(xplot3,predict(l3m2,newdata=data.frame(x=xplot3)), col="red")
lines(xplot3,predict(l3m3,newdata=data.frame(x=xplot3)), col="yellow")
lines(xplot3,predict(l3m4,newdata=data.frame(x=xplot3)), col="green")
lines(xplot3,predict(l3m5,newdata=data.frame(x=xplot3)), col="purple")

dev.new()
plot(x,y4)
lines(xplot4,predict(l4m1,newdata=data.frame(x=xplot4)), col="blue")
lines(xplot4,predict(l4m2,newdata=data.frame(x=xplot4)), col="red")
lines(xplot4,predict(l4m3,newdata=data.frame(x=xplot4)), col="yellow")
lines(xplot4,predict(l4m4,newdata=data.frame(x=xplot4)), col="green")
lines(xplot4,predict(l4m5,newdata=data.frame(x=xplot4)), col="purple")

dev.new()
plot(x,y5)
lines(xplot5,predict(l5m1,newdata=data.frame(x=xplot5)), col="blue")
lines(xplot5,predict(l5m2,newdata=data.frame(x=xplot5)), col="red")
lines(xplot5,predict(l5m3,newdata=data.frame(x=xplot5)), col="yellow")
lines(xplot5,predict(l5m4,newdata=data.frame(x=xplot5)), col="green")
lines(xplot5,predict(l5m5,newdata=data.frame(x=xplot5)), col="purple")

dev.new()
plot(x,ytotal)
lines(xplot6,predict(average1,newdata=data.frame(x=xplot6)), col="blue", lty=2)
lines(xplot6,predict(average2,newdata=data.frame(x=xplot6)), col="red", lty=2)
lines(xplot6,predict(average3,newdata=data.frame(x=xplot6)), col="yellow", lty=2)
lines(xplot6,predict(average4,newdata=data.frame(x=xplot6)), col="green", lty=2)
lines(xplot6,predict(average5,newdata=data.frame(x=xplot6)), col="purple", lty=2)







