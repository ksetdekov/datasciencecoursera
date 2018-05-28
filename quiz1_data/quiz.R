myfunction <- function() {
  x <- rnorm(100000)
  mean(x)
}
second <- function(x) {
  x+rnorm(length(x))
}