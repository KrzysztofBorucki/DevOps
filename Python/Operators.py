# Arithmetic Operators
x = 2
y = 5
total = x + y
print(total)

total = x - y
print(total)

total = x * y
print(total)

total = y/x
print(total)

total = y % x
print(total)

total = y**x
print(total)

# Comaprison Operators
a = 30
b = 60

out = a < b
print(out)

out = a > b
print(out)

out = a == b
print(out)

out = a != b
print(out)

out = a >= b
print(out)

# Assigment Operators
c = 0
d = 1

#c += d # c = c + d
print (c)

c -= d # c = c + d
print (c)

# Logical Operators

# and
# or

a = 40
b = 60

x = 2
y = 3

out =(a < b) or (x > y)
print(out)

out =(a > b) or (x < y)
print(out)

out =(a < b) and (x > y)
print(out)

out = not(x < y)
print(out)
out = not(x > y)
print(out)

# Membership Operator
devops=("linux" , "Vagrant", "Bash Scripting", "AWS", "Jenkins")
ans = "linux" in devops
print(ans)

ans = "linux" not in devops
print(ans)

ans = 67 in devops
print(ans)

ans = 67 not in devops
print(ans)

# Identity Operators
a = 12
b = 12
result = a is b
print(result)

result = a is not b
print(result)


