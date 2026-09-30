# merge List 

list1 = list(1,2,3)
list2 = list("water","juice","lemonlade")
list1
list2

list12 = c(list1,list2)
list12

# Unlist
list1 = list(1,2,3)
list2 = list("water","juice","lemonlade")

unlist(list1)
unlist(list2)
mode(list1)
mode(unlist(list2))


# append()
list1 = list(1,2,3)
list2 = list("water","juice","lemonlade")

append(list1,100)
append(list2,"coffee")

list1 = list(1,2,3)
list2 = list("water","juice","lemonlade")

append(list1,100,after = 2)
append(list2,"coffee",after = 2)

#remove form list 

list1 = list(1,2,3)
list2 = list("water","juice","lemonlade")

list1[-1]
list2[-2]

list1 <- list(1, 2, 3, 4, 5, 6)
list2 <- list("water", "juice", "lemonade",
              "tea", "coffee", "milk")

list1[2:4]
list1[c(1, 3, 5)]

list1[2:4]
list1[c(1, 3, 5)]


list2[2:4]
list2[c(1, 3, 5)]

list2[2:4]
list2[c(1, 3, 5)]

# vector 

x = 1:10
x
x[x>5]
x[x %% 2 == 0]
x[x %% 2 == 1]

x[5] = NA
x
y = x[ !is.na(x)]
y
mean(x)
mean(y)

x = 1:10
x[-(1:5)]
x[(6:10)]

z <- list(a1 = 1, a2 = "c", a3 = 1:3)
z
names(z)

z <- list(a1 = 1, a2 = "c", a3 = 1:3)
names(z)[3] <- "c2"
z

x <- c(water = 1, juice = 2, lemonade = 3)
names(x)
x["juice"]

x <- 1:10
x
x[]


ab <- list(1, 2, 3, "X", "Y", "Z")
dim(ab) <- c(2, 3)
print(ab)
mode(ab)

x <- factor(c("red", "blue", "green","red", "blue"))
x
levels(x)

y <- c(1, 4, 3, 5, 4, 2, 4)
y
possible.dieface <- c(1, 2, 3, 4, 5, 6)
possible.dieface
labels.dieface <- c("one", "two", "three","four", "five", "six")
labels.dieface
facy <- factor(y,levels = possible.dieface,labels = labels.dieface)
facy

x = c(3, 4, 5, 6, 1, 2, 3, 3, 4, 4, 5, 6) 
x
y = as.factor(x)
y
x = factor( c("lemonade", "lemonade","juice", "lemonade", "water") ) 
x

class(9)
class("9")
class(print)
class(x)
x = matrix(nrow=2 , ncol = 2 , data= 1:4)
class(x)
x


brands = c("A","A","B","B","B","B","C")
brands
brands_fac = factor(brands)
brands_fac

unclass(brands_fac)
colourss = c("blue","green","red")
colours
colours[unclass(brands_fac)]

x <- factor(c("lemonade", "lemonade","juice", "lemonade", "water"))
x
unclass(x)

x <- factor(c("lemonade", "lemonade","juice", "lemonade", "water"),levels = c("water", "juice", "lemonade"))
x
unclass(x)
levels(x)

income <- ordered(c("high", "high", "low","medium", "medium"),levels = c("low", "medium", "high"))
income
unclass(income)

print(sqrt(2))
print(sqrt(2), digits = 5)
print(sqrt(2), digits = 10)

print("apple")
print(c("apple", "banana"))
print(c("apple", "banana", 6, 10))

# format 

format(0.5)
print(format(0.5,digits = 10,nsmall = 15))

format(c("A","BB","CCC","DDDD"),width = 7 , justify = "centre")
format(c("A","BB","CCC","DDDD"),width = 14 , justify = "centre")
format(c("A","BB","CCC","DDDD"),width = 7 , justify = "centre")
format(c("A","BB","CCC","DDDD"),width = 7 , justify = "left")
format(c("A","BB","CCC","DDDD"),width = 7 , justify = "right")
format(c("A","BB","CCC","DDDD"),width = 7 , justify = "none")

x = matrix(nrow = 3 , ncol=2 , data = 1:6 , byrow =T)
print(x)
format(1234567,big.mark = ",")
format(12345678,big.mark = ",")
format(123456789,big.mark = ",")
format(123456789,big.mark = "  ")

data = c(4,5,9,4,6,6,7,7,9) 
factor(data) 
levels(data) = c('A','B','C','D') 
data