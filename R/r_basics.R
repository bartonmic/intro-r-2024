#### R Basics ####
# "A foolish consistency is the hobgoblin of 
#   little minds"   -Ralph Waldo Emerson 

# Literals ----
"this is a string literal"  # double quotes preferred in R but not required
42
T

# Operators ----
# Arithmetic
3 + 4   # note the spacing
2 ** 3  # be careful, this is an exponent
2 ^ 3   # that's better

# Comparison
2 == 2  # test if mathematically equal (not if identical)
2 == (1 + 1)
2 != 1

TRUE == 1   # can be useful for summation
FALSE == 0  

isTRUE(TRUE)  # functino testing if the argument is literally true
isTRUE(1)

?isTRUE # queries built-in help

2 < 3 & 2 > 3   # note '&' instead of 'AND'
2 < 3 | 2 > 3   # note '|' instead of 'OR'

# type matters (sometimes)
typeof("joe")
typeof(42)
typeof(TRUE)

42 == "42"  # equality can cross types
identical(42, "42") # type matters for identity

# variables ----
x <- "this is a string"
x
typeof(x)
x <- 10

# data structures ----
# vectors have a single dimension, like a column or row of data
a <- c("1", "2", "3")
a
a <- c(1, 2, 3)
a
a + 1

a <- c(1, 2, 3, "4")  # R will auto-type to form that "works"
a
typeof(a)

a <- c(1, 2, 3)

a < 3   # evaluates each item in the vector one by one

any(a < 3)
all(a < 3)

3 %in% a  # testing membership in a vector
!4 %in% a



# data frames - the key structure for data science, multi-dimensional
#   collections of vectors

df <- data.frame(a = c(1, 2, 3), 
                 b = c("joe", "tammy", "matt"))   #collection of vectors
df

df$a  # references single column

df$mode <- c("bike", "car", "bus")

df

summary(df)   #summarizes by column

# Special type: factors, and putting it all together ----
# factors are categorical variables with a fixed set of
#   potential values

