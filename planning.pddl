(define (problem planning)
    (:domain grid_domain)
    (:objects 
        ;Corresponding to how many squares are filled in each column
        col0 col1 col2 col3 col4  - col

        ;Corresponding to how many squares are filled in each row
        row0 row1 row2 row3 row4  - row

        ;Corresponding to how many squares are filled in a row
        fill0 fill1 fill2 fill3 fill4 fill5

        ;Corresponding to each square (true if filled)
        sq00 sq01 sq02 sq03 sq04   
        sq10 sq11 sq12 sq13 sq14 
        sq20 sq21 sq22 sq23 sq24 
        sq30 sq31 sq32 sq33 sq34 
        sq40 sq41 sq42 sq43 sq44 - square
    )
    (:init
        ; all columns and rows are empty to start
        (= (fill col0) 0)
        (= (fill col1) 0)
        (=(fill col2) 0)
        (= (fill col3) 0)
        (= (fill col4) 0)

        (= (fill row0) 0)
        (= (fill row1) 0)
        (= (fill row2) 0)
        (= (fill row3) 0)
        (= (fill row4) 0)

        (at col1 fill0)
        (at col2 fill0)
        (at col3 fill0)
        (at col4 fill0)
        (at col5 fill0)
        (at row1 fill0)
        (at row2 fill0)
        (at row3 fill0)
        (at row4 fill0)
        (at row5 fill0)

        ; so that the planner knows how to increment the fill
        (next fill0 fill1)
        (next fill1 fill2)
        (next fill2 fill3)
        (next fill3 fill4)
        (next fill4 fill5)

        ; so that the planner knows how to decrement the fill
        (prev fill1 fill0)
        (prev fill2 fill1)
        (prev fill3 fill2)
        (prev fill4 fill3)
        (prev fill5 fill4)

        ; so that the planner know that square 00 
        ;corresponds to col0 and row0
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
        ; the puzzel in that row or column` 
        (= (fill col0) 3)
        (= (fill col1) 3)
        (= (fill col2) 3)
        (= (fill col3) 2)
        (= (fill col4) 2)

        (= (fill row0) 2)
        (= (fill row1) 2)
        (= (fill row2) 3)
        (= (fill row3) 3)
        (= (fill row4) 3)
    ))
)