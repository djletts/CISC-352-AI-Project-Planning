(define (problem planning)
    (:domain grid_domain)
    (:objects 
        ;Corresponding col 0 to 4 in a 5x5 grid
        ; will be used to tell how many squares are filled in each column
        col0 col1 col2 col3 col4  - col

        ;Corresponding row 0 to 4 in a 5x5 grid
        ;will be used to tell how many squares are filled in each row
        row0 row1 row2 row3 row4  - row

        ;Corresponding to how many squares are filled in a row
        fill0 fill1 fill2 fill3 fill4 fill5 - fill

        ;Corresponding to each square (true if filled)
        sq00 sq01 sq02 sq03 sq04   
        sq10 sq11 sq12 sq13 sq14 
        sq20 sq21 sq22 sq23 sq24 
        sq30 sq31 sq32 sq33 sq34 
        sq40 sq41 sq42 sq43 sq44 - square
    )
    (:init
        ; all columns and rows are empty to start
        (is col0 fill0)
        (is col1 fill0)
        (is col2 fill0)
        (is col3 fill0)
        (is col4 fill0)
        

        (is row0 fill0)
        (is row1 fill0)
        (is row2 fill0)
        (is row3 fill0)
        (is row4 fill0)

        (is0 fill0) ; used to know if a row /col is empty
 
        ; so that the planner knows how to increment the fill
        (nextF fill0 fill1)
        (nextF fill1 fill2)
        (nextF fill2 fill3)
        (nextF fill3 fill4)
        (nextF fill4 fill5)

        ; so that the planner knows what column/row are adjacent to each other
        (nextC col0 col1)
        (nextC col1 col2)
        (nextC col2 col3)
        (nextC col3 col4)

        (nextR row0 row1)
        (nextR row1 row2)
        (nextR row2 row3)
        (nextR row3 row4)

        ; so that the planner know that square 00 
        ;corresponds to col0 and row0 and ect
        (in sq00 col0 row0)
        (in sq01 col1 row0)
        (in sq02 col2 row0)
        (in sq03 col3 row0)
        (in sq04 col4 row0)

        (in sq10 col0 row1)
        (in sq11 col1 row1)
        (in sq12 col2 row1)
        (in sq13 col3 row1)
        (in sq14 col4 row1)

        (in sq20 col0 row2)
        (in sq21 col1 row2)
        (in sq22 col2 row2)
        (in sq23 col3 row2)
        (in sq24 col4 row2)

        (in sq30 col0 row3)
        (in sq31 col1 row3)
        (in sq32 col2 row3)
        (in sq33 col3 row3)
        (in sq34 col4 row3)

        (in sq40 col0 row4)
        (in sq41 col1 row4) 
        (in sq42 col2 row4)
        (in sq43 col3 row4)
        (in sq44 col4 row4)
    )
    (:goal (and
        ; We know we are complete when all rows and columns are filled
        ; coresponding to the keys
        ; the last number is how many square should be filled to complete
        ; the puzzel in that row or column
        (is col0 fill1)
        (is col1 fill3)
        (is col2 fill3)
        (is col3 fill3)
        (is col4 fill0)

        (is row0 fill1)
        (is row1 fill3)
        (is row2 fill3)
        (is row3 fill3)
        (is row4 fill0)
    ))
)