
import random
Vaccines = ["Moderna", "Pfizer", "Sputnik v", "Covaxin", "AsteraZeneca"]

random.shuffle(Vaccines)
print(Vaccines)

Lucky = random.choice(Vaccines)
print(Lucky)

for vac in Vaccines:
    print(f"*********Testing Vaccine {vac}")
    if vac == Lucky:
        print(f"{Lucky} Vaccine, Test Succesfulll")
        break # break/continue
    print("Test Failed")


