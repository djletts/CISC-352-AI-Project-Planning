(define (problem nonogram)
    (:domain nonogram-grid)
    (:objects 
    col1 col2 col3 col4 col5 
    
    row1 row2 row3 row4 row5 
    
    fill0 fill1 fill2 fill3 fill4 fill5 

    sq00 sq01 sq02 sq03 sq04 
    sq10 sq11 sq12 sq13 sq14 
    sq20 sq21 sq22 sq23 sq24 
    sq30 sq31 sq32 sq33 sq34 
    sq40 sq41 sq42 sq43 sq44
    
    goal)
    (:init)
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

    (:goal goal)
)