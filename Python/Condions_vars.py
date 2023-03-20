Devops = ["linux" , "Vagrant", "Bash Scripting", "AWS", "Jenkins"]
Development = ("C#" , "Java", ".net", "AWS", "Python")
Skills = {"Name": "Santa", "Skill": "AI", "Code":1218}

usr_skill = input("Enter your desired skill: ")
#print(usr_skill)

# Check in the database if we have this skill

if usr_skill in Devops:
    print(f"We Have {usr_skill} in DevOps Team.")
elif (usr_skill in Development):
    print(f"We have {usr_skill} in Development Team.")
elif (usr_skill in Skills.values()):
    print("We have contract employees with this skill.")
else:
    print("Skill not found")
    print("Please check if you have entered value in capitalize or check the spelling")

