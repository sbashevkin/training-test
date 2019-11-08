# R scripts for showing debugging

a <- 10
b <- 50

simplesum <- function(x, y) {
  y <- y+10
  z <- y+20
  out<-sum(x,z)
  return(out)
}

sum

listofsums <- function(n) {
  m <- n*23
  o<-simplesum(m,23)
  return(o)
}