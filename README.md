# CISC-352-AI-Project-Planning
BY:
Nicole Hernandez- Student ID: 20329562 -  School Email: 21nhm5@queensu.ca
Dylan Letts - Student ID: 20323382 - School Email: 21djl11@queensu.ca

#Introduction

##Project Discription:
This project is for Queen's University CISC 325 Artificial Intelligence for the Winter 2025 semester taught by Dr. Christian Muise. The semester-long assignment is to code 3 different AI agents (CSP, Planning, Deep Learning) to solve a nonogram puzzle (https://en.wikipedia.org/wiki/Nonogram). The nonograms that we are interested in are nxn grids and single colours (filled or blank). Each row and col has a key that tells you how many squares are coloured in a row. 

##Planning Description:
PDDL was used to code the planning AI agent. Each square in the grid corresponds to a row and col object. Row and col objects keep track of how many squares are filled in a row using the fill objects. It then outputs actions taken to the squares it filled to complete the given puzzle. For the moment, It only works if each row/col has 1 key.


#Getting Started
##1.Installation process:The PDDL extension for VScode was installed through the VScode extensions marketplace. It was used to program and run the files
##2.Software dependencies: The grid_domain.pddl and planning.pddl are both needed to run 
##3.Latest releases:N/A
##4.API references: N/A

#Build and Test
Using LAMA-first to run the planning.pddl as all others do not work

To test, change the goal in planning.pddl so that each row and col has the fill# as its key. If it is invalid keys, then no plan will be found
 for example:
        (is col0 fill0)
        (is col1 fill3)
        (is col2 fill3)
        (is col3 fill3)
        (is col4 fill0)

        (is row0 fill0)
        (is row1 fill3)
        (is row2 fill3)
        (is row3 fill3)
        (is row4 fill0)
corrisponds to 
00000
0###0
0###0
0###0
00000

#Contribute
Nicole Hernandez and Dylan Letts code the project together. The way we coded was often to discuss how we wanted to implement features together- brainstorming logic faster. Then we took turns coding on the same computer so we both understood the code and could help each other ensure correctness. 