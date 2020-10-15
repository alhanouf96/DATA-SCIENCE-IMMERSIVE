#1
def a():
    return 5
print(a())

#output: 5

#2
def a():
    return 5
print(a()+a())

#will add 5 + 5 => 10

#3
def a():
    return 5
    return 10
print(a())

#only run first statement => 5

#4
def a():
    return 5
    print(10)
print(a())
#only run first statement => 5

#5
def a():
    print(5)
x = a()
print(x)

#function a print 5, x = a()
#output: 5

#6
def a(b,c):
    print(b+c)
print(a(1,2) + a(2,3))

#output: 3  + 5 = 8

#7
def a(b,c):
    return str(b)+str(c)
print(a(2,5))

##output: combine arg1 with arg2= 25

#8
def a():
    b = 100
    print(b)
    if b < 10:
        return 5
    else:
        return 10
    return 7
print(a())

##output: print 100, b not<10 , then return 10

#9
def a(b,c):
    if b<c:
        return 7
    else:
        return 14
    return 3

print(a(2,3))
print(a(5,3))
print(a(2,3) + a(5,3))

#1 b<c: return 7,b>c:return 14, sum 7 + 14
#output:7,14,21

#10
def a(b,c):
    return b+c
    return 10
print(a(3,5))

#run first statement =>8

#11
b = 500
print(b)
def a():
    b = 300
    print(b)
print(b)
a()
print(b)

#output 500, 500, 300,500

#12
b = 500
print(b)
def a():
    b = 300
    print(b)
    return b
print(b)
a()
print(b)

#output 500, 500, 300,300 =>> after compare i have mistake :)


#13
b = 500
print(b)
def a():
    b = 300
    print(b)
    return b
print(b)
b=a()
print(b)

#output 500, 500, 300,300 

#14
def a():
    print(1)
    b()
    print(2)
def b():
    print(3)
a()

#output run a() then b() then come back to a()
# 1,3,2

#15
def a():
    print(1)
    x = b()
    print(x)
    return 10
def b():
    print(3)
    return 5
y = a()
print(y)


# a()={ 1 , b()= 3, 5 , x=5 }
# output: 1,3,5,10
 

 