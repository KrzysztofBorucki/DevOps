# String Build in Methods/Functions
message = "corona vaccine is ready to use, most of them are more than 90% effective."
print(message)
print(message.capitalize())
Message = message.capitalize()
print(Message)
"""
#dir() function
print(dir(message))
print(dir(""))
print(dir([]))
print(dir({}))


print(message.upper())
print(message.islower())
print(message.isupper())

print(message.find("ready"))


seq1 = ("192", "168", "40", "90")
print(".".join(seq1))
print("-".join(seq1))
seq2 = ["192", "168", "40", "90"]
seq2.append("50")
print(seq2)

seq2.extend(["30", "50"])
print(seq2)

seq2.insert(2, "sakura")
print(seq2)

seq2.pop()
print(seq2)
seq2.pop(2)
print(seq2)
"""
Skills = {"Name": "Santa", "Skill": "AI", "Code":1218}
print(Skills.keys())
print(Skills.values())
Skills.clear()
print(Skills)
