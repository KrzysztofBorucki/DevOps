planet1 = "Closest to sun"
print(planet1)

print(planet1[0])
print(planet1[1])
print(planet1[2])

print (planet1[-1])
print (planet1[-2])
print (planet1[-3])

# Slicing a string
print(planet1[1:4])
print(planet1[:])
print(planet1[:7])
print(planet1[11:])

# Slicing Tuple
devops = ("linux" , "Vagrant", "Bash Scripting", "AWS", "Jenkins")
print(devops[0])
print(devops[4])
print(devops[1:4])

print(devops[2:5][0])

print(devops[2:5][0][5:11])
print(devops[2:5][0][5:11][-1])

# Slicing list
devops = ["linux" , "Vagrant", "Bash Scripting", "AWS", "Jenkins"]
print(devops[0])
print(devops[4])
print(devops[1:4])

print(devops[2:5][0])

print(devops[2:5][0][5:11])
print(devops[2:5][0][5:11][-1])

# Dictionary Example
Skills = {"devops": ("linux" , "Vagrant", "Bash Scripting", "AWS", "Jenkins"), "Development": ["Java", "NodeJS", ".net"]}
print (Skills)
print(Skills["devops"])
print(Skills["Development"])

print(Skills["devops"][-1])
print(Skills["devops"][-1][:3])