"""
Vaccines = ["Moderna", "Pfizer", "Sputnik v", "Covaxin", "AsteraZeneca"]

for vac in Vaccines:
    print("")
    print("I would like to take a shot of ")
    for i in vac:
        print(i)
"""

import time

x = 2
while True:
    print("Value of X is:", x)
    print("Looping")
    x *= 2
    time.sleep(2)
