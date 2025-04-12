import math

def getInput():
    """
    -------------------------------------------------------
    Gets the input from the user for the nonogram puzzle.

    Use: getInput()
    -------------------------------------------------------

    return:
    None
    -------------------------------------------------------
    """
    n = int(input("Enter the number of columns/rows you want(columns=rows since grid is a square): "))
    
    numKeys=math.ceil(n/2)

    colKeys = []
    rowKeys = []

    for i in range(n):
        colK = input(f"Enter the keys for column {i+1} (space-separated): ")
        colKeys.append(list(map(int, colK.split())))
    print()
    for i in range(n):
        rowK = input(f"Enter the keys for column {i+1} (space-separated): ")
        rowKeys.append(list(map(int, rowK.split())))

    for i in range(n):
        while len(colKeys[i]) < numKeys:
            colKeys[i].append(0)
        while len(rowKeys[i]) < numKeys:
            rowKeys[i].append(0)

    return n, numKeys, colKeys, rowKeys
n, numKeys, colKeys, rowKeys = getInput()
print(colKeys, rowKeys)

f = open("planningcode.pddl", "w")

f.write("(define (problem planning)\n")
f.write("\t(:domain grid_domain)\n")

#-   objects
f.write("\t(:objects\n")
list = ["col", "row"]
for j in range(2):
    string = ""
    for i in range(n):
        string = string + list[j] + str(i) + " "
    f.write(f"\t\t;Corresponding {list[j]} 0 to {n - 1} in a {n}x{n} grid)\n")
    f.write(f"\t\t; will be used to tell how many squares are filled in each {list[j]}\n")
    f.write(f"\t\t{string}- {list[j] }\n")
    f.write("\n")

string = ""
for i in range(n + 1):
    string = string + "fill" + str(i) + " "
f.write("\t\t;Corresponding to how many squares are filled in a row\n")
f.write("\t\t" + string + "- fill\n")

list = ["c", "r"]
for j in range(2):
    string = "\n\t\t"
    for i in range(n):
        for k in range(numKeys):
            string = string + list[j] + str(i) + "Key" + str(k) + " "
        f.write(f"\n\t\t{string}")
        string = ""
f.write("- key\n")

string = ""
for i in range(n):
    string = string + "\n\t\t"
    for j in range(n):
        string = string + "sq" + str(i) + "_" + str(j) + " "

f.write("\n\t\t;Corresponding to each square (true if filled)")
f.write(string + " - square\n")

f.write("\t)\n")

#------ init
f.write("\t(:init\n")
for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is c{i}Key{j} fill0)\n")
    f.write("\n")

for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is r{i}Key{j} fill0)\n")
    f.write("\n")

f.write("\n")
f.write("\t\t(is0 fill0)\n")
f.write("\n")

for i in range(n):
    f.write(f"\t\t(nextF fill{i} fill{i+1})\n")
f.write("\n")

for i in range(n-1):
    f.write(f"\t\t(nextR row{i} row{i+1})\n")
f.write("\n")

for i in range(n-1):
    f.write(f"\t\t(nextC col{i} col{i+1})\n")
f.write("\n")

# to tell what square are in what column and row
for i in range(n):
    for j in range(n):
        f.write(f"\t\t(in sq{i}_{j} col{i} row{j})\n")
    f.write(f"\t\t\n")


list = ["c", "r"]
list2 = ["col", "row"]
for j in range(2):
    for i in range(n):
        for k in range(numKeys):
            f.write(f"\n\t\t(has {list2[j]}{i} {list[j]}{i}Key{k})")
        f.write("\n")
    f.write("\n")
f.write(")\n")
#------ goals
f.write("\t(:goal (and\n")

for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is c{i}Key{j} fill{colKeys[i][j]})\n")
    f.write("\n")

for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is r{i}Key{j} fill{rowKeys[i][j]})\n")
    f.write("\n")
    
f.write("\t))\n")
f.write(")\n")
f.close()

print("Number of keys: ", numKeys)