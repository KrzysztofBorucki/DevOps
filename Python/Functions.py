# Defining Function
def add(arg1, arg2):
    total = arg1 + arg2
    return total

out = add(2, 3)
print(out)
print(add(10, 30))

def adder(arg1, arg2):
    total = arg1 + arg2
    print(total)

adder(10, 50)

def summ(arg):
    x = 0
    for i in arg:
        x = x + i
    return x
out = summ([1, 2, 3])
print(out)

# Default Argument
def greetings(MSG="Morning"):
    print(f"Good {MSG}")
    print("Welcome to the function.")

greetings()
greetings("Evening")
