f <- file.choose()

mydata1 = read.table(f)
mydata <- as.vector(t(mydata1))

seed <- function()
{
	cat("Enter a seed: ")
	x <- readLines(con=stdin(),1)
	return(as.integer(x))
}
newSeed <- seed()

if (is.integer(newSeed)) {
	set.seed(newSeed)
}

initialGuesses1 <- ceiling(runif(3, 0, 5))
initialGuesses <- sample(0:5, 3, replace=F)
newGuesses <- initialGuesses
lastGuesses <- vector(,3)
lastGuesses[1] <- 100
lastGuesses[2] <- 100
lastGuesses[3] <- 100
print("Initial Guesses")
print(initialGuesses)
firstFive <- vector(,15)
ex1 <- vector(,300)
ex2 <- vector(,300)
ex3 <- vector(,300)
i <- 1
j <- 1
e <- exp(1)
count <- 5

while ( i <= 5) {
	j <- 1
	while (j <= 300){
		ex1[j] <- (e ^ (-.5 * (mydata[j] - newGuesses[1]) ^ 2)) / (e ^ (-.5 *(mydata[j] - newGuesses[1]) ^ 2) + e ^ (-.5 *(mydata[j] - newGuesses[2]) ^ 2) + e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2) )
		ex2[j] <- (e ^ (-.5 * (mydata[j] - newGuesses[2]) ^ 2)) / (e ^ (-.5 *(mydata[j] - newGuesses[1]) ^ 2) + e ^ (-.5 *(mydata[j] - newGuesses[2]) ^ 2) + e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2) )
		ex3[j] <- (e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2)) / (e ^ (-.5 *(mydata[j] - newGuesses[1]) ^ 2) + e ^ (-.5 *(mydata[j] - newGuesses[2]) ^ 2) + e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2) )
		j <- j + 1
	}
	numerator1 <- 0
	numerator2 <- 0
	numerator3 <- 0
	k <- 1
	while (k <= 300){
		numerator1 <- numerator1 + ex1[k] * mydata[k]
		numerator2 <- numerator2 + ex2[k] * mydata[k]
		numerator3 <- numerator3 + ex3[k] * mydata[k]
		k <- k + 1
	}
	newGuesses[1] <- numerator1 / sum(ex1)
	newGuesses[2] <- numerator2 / sum(ex2)
	newGuesses[3] <- numerator3 / sum(ex3)
	firstFive[(i - 1) * 3 + 1 ] <- newGuesses[1]
	firstFive[(i - 1) * 3 + 2 ] <- newGuesses[2]
	firstFive[(i - 1) * 3 + 3 ] <- newGuesses[3]
	i <- i + 1
}

while (abs(newGuesses[2] - lastGuesses[2]) > .05){
	lastGuesses <- newGuesses
	j <- 1
	count <- count + 1
	while (j <= 300){
		ex1[j] <- (e ^ (-.5 * (mydata[j] - newGuesses[1]) ^ 2)) / (e ^ (-.5 *(mydata[j] - newGuesses[1]) ^ 2) + e ^ (-.5 *(mydata[j] - newGuesses[2]) ^ 2) + e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2) )
		ex2[j] <- (e ^ (-.5 * (mydata[j] - newGuesses[2]) ^ 2)) / (e ^ (-.5 *(mydata[j] - newGuesses[1]) ^ 2) + e ^ (-.5 *(mydata[j] - newGuesses[2]) ^ 2) + e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2) )
		ex3[j] <- (e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2)) / (e ^ (-.5 *(mydata[j] - newGuesses[1]) ^ 2) + e ^ (-.5 *(mydata[j] - newGuesses[2]) ^ 2) + e ^ (-.5 * (mydata[j] - newGuesses[3]) ^ 2) )
		j <- j + 1
	}
	numerator1 <- 0
	numerator2 <- 0
	numerator3 <- 0
	k <- 1
	while (k <= 300){
		numerator1 <- numerator1 + ex1[k] * mydata[k]
		numerator2 <- numerator2 + ex2[k] * mydata[k]
		numerator3 <- numerator3 + ex3[k] * mydata[k]
		k <- k + 1
	}
	newGuesses[1] <- numerator1 / sum(ex1)
	newGuesses[2] <- numerator2 / sum(ex2)
	newGuesses[3] <- numerator3 / sum(ex3)
}

print("First Five (unformatted)")
print(firstFive)
print("Final Estimates")
print(newGuesses)


