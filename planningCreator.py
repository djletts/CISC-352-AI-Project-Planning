import math
# run then follow instructions to create a planning problem file for
# the grid_domain.pddl file
def getInput():
    """
    -------------------------------------------------------
    Gets the input from the user for the nonogram puzzle.

    Use: getInput()
    -------------------------------------------------------
    Parameters:
    None

    Return:
    n- number of columns/rows in the nonogram (since it is a square grid)
    NumKeys- max number of keys for each column/row
    colKeys- list of the keys for each column
    rowKeys- list of the keys for each row
    -------------------------------------------------------
    """
    n = int(input("Enter the number of columns/rows " \
    "you want(columns=rows since grid is a square): "))
    
    # Calculate the max number of keys a row/column can have give a n
    numKeys=math.ceil(n/2)

    colKeys = []
    rowKeys = []

    for i in range(n):
        colK = input(f"Enter the keys for column {i+1} (space-separated): ")
        colKeys.append(list(map(int, colK.split())))
    print()
    for i in range(n):
        rowK = input(f"Enter the keys for row {i+1} (space-separated): ")
        rowKeys.append(list(map(int, rowK.split())))

    for i in range(n):
        while len(colKeys[i]) < numKeys:
            colKeys[i].append(0)
        while len(rowKeys[i]) < numKeys:
            rowKeys[i].append(0)

    return n, numKeys, colKeys, rowKeys

# Create the variables
n, numKeys, colKeys, rowKeys = getInput()

# Creates the file
f = open("planningTestCase4.pddl", "w")

# create the planning code
f.write("(define (problem planning)\n")
f.write("\t(:domain grid_domain)\n")

#-   objects
f.write("\t(:objects\n")
#    Creates the row and column objects
list = ["col", "row"]
for j in range(2):
    string = ""
    for i in range(n+2):
        string = string + list[j] + str(i) + " "
    f.write(f"\t\t;Corresponding {list[j]} 0 to {n - 1} in a {n}x{n} grid)\n")
    f.write(f"\t\t; will be used to tell how many squares are filled in each {list[j]}\n")
    f.write(f"\t\t{string}- {list[j] }\n")
    f.write("\n")

#    Creates the fill objects
string = ""
for i in range(n + 1):
    string = string + "fill" + str(i) + " "
f.write("\t\t;Corresponding to how many squares are filled in a row\n")
f.write("\t\t" + string + "- fill\n")

#    Creates the row and column key objects
f.write("\n\t\t;Corresponding to each key for a given row or column")
list = ["c", "r"]
for j in range(2):
    string = "\n\t\t"
    for i in range(n+2):
        for k in range(numKeys):
            string = string + list[j] + str(i) + "Key" + str(k) + " "
        f.write(f"\n\t\t{string}")
        string = ""
f.write("- key\n")

#    Creates square objects for the grid
string = ""
for i in range(n+2):
    string = string + "\n\t\t"
    for j in range(n+2):
        string = string + "sq" + str(i) + "_" + str(j) + " "

f.write("\n\t\t;Corresponding to each square (true if filled)")
f.write(string + " - square\n")

f.write("\t)\n")

#------------------------init
f.write("\t(:init\n")

# sets all the keys to 0
f.write("\n\t\t;Sets all keys to fill 0 (they all start off empty)\n")
f.write(f"\t\t(is c{0}Key{0} fill0);for padding\n\n") # to add padding
for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is c{i+1}Key{j} fill0)\n")
    f.write("\n")
f.write(f"\t\t(is c{n+1}Key{0} fill0);for padding\n\n") # to add padding

f.write(f"\t\t(is r{0}Key{0} fill0);for padding\n") # to add padding


for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is r{i+1}Key{j} fill0)\n")
    f.write("\n")
f.write(f"\t\t(is r{n+1}Key{0} fill0);for padding\n") # to add padding

f.write("\n")
#tells if a kry is filled or not
f.write("\t\t(is0 fill0); helps to know if key is empty\n")
f.write("\n")

# to tell what fills come after eachother
f.write("\n\t\t;to tell what fills come after eachother\n")
for i in range(n):
    f.write(f"\t\t(nextF fill{i} fill{i+1})\n")
f.write("\n")

# to tell row is next to eachother
f.write("\n\t\t;to tell row is next to eachother\n")
for i in range(n+1):
    f.write(f"\t\t(nextR row{i} row{i+1})\n")
f.write("\n")

# to tell col is next to eachother
f.write("\n\t\t;to tell col is next to eachother\n")
for i in range(n+1):
    f.write(f"\t\t(nextC col{i} col{i+1})\n")
f.write("\n")

# to tell what square are in what column and row
f.write("\n\t\t;to tell what square are in what column and row\n")
for i in range(n+2):
    for j in range(n+2):
        f.write(f"\t\t(in sq{i}_{j} col{i} row{j})\n")
    f.write(f"\t\t\n")

f.write("\n\t\t;Setting the keys to its given row/column")
list = ["c", "r"]
list2 = ["col", "row"]
for j in range(2):
    for i in range(n):
        for k in range(numKeys):
            f.write(f"\n\t\t(has {list2[j]}{i+1} {list[j]}{i+1}Key{k})")
        f.write("\n")
    f.write("\n")
f.write(f"\n\t\t(has col0 c0Key0)")
f.write(f"\n\t\t(has col{n+1} c{n+1}Key0)")
f.write(f"\n\t\t(has row0 r0Key0)")
f.write(f"\n\t\t(has row{n+1} r{n+1}Key0)")
f.write(")\n")

#------ goal
f.write("\t(:goal (and\n")

f.write(f"\t\t(is c{0}Key{0} fill0);for padding\n") # to add padding
f.write(f"\n\t\t;Corresponding to the col keys \n\t\t;{colKeys}\n")
for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is c{i+1}Key{j} fill{colKeys[i][j]})\n")
    f.write("\n")
f.write(f"\t\t(is c{n+1}Key{0} fill0);for padding\n\n\n") # to add padding

f.write(f"\t\t(is r{0}Key{0} fill0);for padding\n\n") # to add padding
f.write(f"\n\t\t;Corresponding to the row keys\n\t\t;{rowKeys}\n")
for i in range(n):
    for j in range(numKeys):
        f.write(f"\t\t(is r{i+1}Key{j} fill{rowKeys[i][j]})\n")
    f.write("\n")
f.write(f"\t\t(is r{n+1}Key{0} fill0);for padding\n\n") # to add padding

f.write("\t)); end of goal\n")
f.write(");end of define\n")
f.close()
