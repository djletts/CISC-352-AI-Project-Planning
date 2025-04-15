(define (domain grid_domain)

(:requirements :strips :adl :typing :equality :negative-preconditions :disjunctive-preconditions 
:existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects 
:derived-predicates :action-costs )

(:types 
col row fill square key
)

(:predicates 
    ; keeps track of what column/row is filled by what
    (is ?a ?b - fill) 

    ; tells what square is in what column and row
    (in ?a - square ?c - col ?r - row)

    ; tells if a square is filled or not (true for filled)
    (filled ?a - square)

    ; tells what the next fill value is
    (nextF ?a - fill ?b - fill)

    ; tells what col/row is next to what
    (nextC ?a - col ?b - col)
    (nextR ?a - row ?b - row)
 
    ;a fluent to tell if a row or column is empty,
    ; so is0 fill0 should always be true
    (is0 ?a - fill) 
    (has ?c ?k - key) ; tells what column/row is filled by what key
    
)

; Actions are how we change the squares to be filled
; we have 4 different actions to fill in the squares. We have a base case, where we fill a 
;square that is surrounded by 4 empty squares. There is 2 actions that fill a square that is
;surrounded by 3 empty squares and 1 filled square- one for where that square is in the same col
;and another where its in the same row. Then we have the last action that fills a square that is
; in the corner of 2 filled squares.
; The planner is not allowed to fill when it is inbettwen 2 filled squares on either side
; - this is so the keys are not messed up
(:action BaseCase
    ; takes in the sqaure(sPrime) that is being filled, the column and row it is in, 
    ; and the fill value of each of the column and row
    ; then finds the 4 adjacent squares
    :parameters (?sPrime - square ?cPrime - col ?rPrime - row 
                ?f_c1 - fill  ?f_r1 - fill ?f_c2 - fill  ?f_r2 - fill 
                ?keyC - key ?keyR - key
                ?sAbove - square ?rAbove - row
                ?sBelow - square ?rBelow - row
                ?sLeft - square ?cLeft - col
                ?sRight - square ?cRight - col
                )

    :precondition (and (not (filled ?sPrime)) ; square is not already filled
                        (in ?sPrime ?cPrime ?rPrime ) ; square is in the column and row

                        (has ?cPrime ?keyC) ; column is filled by
                        (is ?keyC ?f_c1) ; how filled the col is
                        (is0 ?f_c1) ; col key is empty
                        
                        (has ?rPrime ?keyR) ; row is filled
                        (is ?keyR ?f_r1) ; how filled the rowis
                        (is0 ?f_r1) ; row key is empty

                        (in ?sAbove ?cPrime ?rAbove ) ; square above is in the column and row
                        (nextR ?rAbove ?rPrime) ; checks that it is the square above of square prime
                        (not (filled ?sAbove)) ; square above is not filled

                        (in ?sBelow ?cPrime ?rBelow ) ; square below is in the column and row
                        (nextR ?rPrime ?rBelow) ; checks that it is the square below of square prime
                        (not (filled ?sBelow)) ; square below is not filled

                        (in ?sLeft ?cLeft ?rPrime ) ; square left is in the column and row
                        (nextC ?cLeft ?cPrime) ; checks that it is the square left of square prime
                        (not (filled ?sLeft)) ; square to the left is not filled

                        (in ?sRight ?cRight ?rPrime ) ; square right is in the column and row
                        (nextC ?cPrime ?cRight) ; checks that it is the square right of square prime
                        (not (filled ?sRight)) ; square to the right is not filled

                        (nextF ?f_c1 ?f_c2) ; column fill is incremented by 1
                        (nextF ?f_r1 ?f_r2) ; row fill is incremented by 1
                        )

    :effect (and 
                ; the square is filled and the column and row fill is incremented
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) ; have to make this false to properly increment
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2))
                    )); end of effect and Base case

(:action appendToKeyRow
    ; fills next to a square that is already filled in the row
    :parameters (?sPrime - square ?cPrime - col ?rPrime - row 
                ?f_c1 - fill  ?f_r1 - fill ?f_c2 - fill  ?f_r2 - fill 
                ?keyC - key ?keyR - key
                ?sAbove - square ?rAbove - row
                ?sBelow - square ?rBelow - row
                ?sLeft - square ?cLeft - col
                ?sRight - square ?cRight - col
                )

    :precondition (and (not (filled ?sPrime)) ; square is not already filled
                        (in ?sPrime ?cPrime ?rPrime ) ; square is in the column and row

                        (has ?cPrime ?keyC) ; column is filled by
                        (is ?keyC ?f_c1) ; how filled the col is
                        (is0 ?f_c1) ; col key is empty
                        
                        (has ?rPrime ?keyR) ; row is filled
                        (is ?keyR ?f_r1) ; how filled the rowis
                        (not (is0 ?f_r1)) ; row is not empty

                        (in ?sAbove ?cPrime ?rAbove ) ; square above is in the column and row
                        (nextR ?rAbove ?rPrime) ; checks that it is the square above of square prime

                        (in ?sBelow ?cPrime ?rBelow ) ; square below is in the column and row
                        (nextR ?rPrime ?rBelow) ; checks that it is the square below of square prime

                        (in ?sLeft ?cLeft ?rPrime ) ; square left is in the column and row
                        (nextC ?cLeft ?cPrime) ; checks that it is the square left of square prime

                        (in ?sRight ?cRight ?rPrime ) ; square right is in the column and row
                        (nextC ?cPrime ?cRight) ; checks that it is the square right of square prime

                        (nextF ?f_c1 ?f_c2) ; column fill is incremented by 1
                        (nextF ?f_r1 ?f_r2) ; row fill is incremented by 1

                        )

    :effect (and 

                ; appends to square to the left of it
                (when (and (filled ?sLeft) (not(filled ?sRight)) 
                        (not(filled ?sAbove)) (not(filled ?sBelow))) 

                ; the square is filled and the column and row fill is incremented
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))
                
                ; appends to square to the right of it
                (when (and (not(filled ?sLeft))  (filled ?sRight) 
                        (not(filled ?sAbove)) (not(filled ?sBelow))) 
                    ; fills the square and increments the column and row fill
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))
        ))  ;end of effect and append to key row

(:action appendToKeyCol
    ; fills next to a square that is already filled in the col
    :parameters (?sPrime - square ?cPrime - col ?rPrime - row 
                ?f_c1 - fill  ?f_r1 - fill ?f_c2 - fill  ?f_r2 - fill 
                ?keyC - key ?keyR - key
                ?sAbove - square ?rAbove - row
                ?sBelow - square ?rBelow - row
                ?sLeft - square ?cLeft - col
                ?sRight - square ?cRight - col
                );end of parameters

    :precondition (and (not (filled ?sPrime)) ; square is not already filled
                        (in ?sPrime ?cPrime ?rPrime ) ; square is in the column and row

                        (has ?cPrime ?keyC) ; column is filled by
                        (is ?keyC ?f_c1) ; how filled the col is
                        (not (is0 ?f_c1)) ; col key is not empty

                        (has ?rPrime ?keyR) ; row is filled
                        (is ?keyR ?f_r1) ; how filled the rowis
                        (is0 ?f_r1) ; row key is empty
                        

                        (in ?sAbove ?cPrime ?rAbove ) ; square above is in the column and row
                        (nextR ?rAbove ?rPrime) ; checks that it is the square above of square prime

                        (in ?sBelow ?cPrime ?rBelow ) ; square below is in the column and row
                        (nextR ?rPrime ?rBelow) ; checks that it is the square below of square prime

                        (in ?sLeft ?cLeft ?rPrime ) ; square left is in the column and row
                        (nextC ?cLeft ?cPrime) ; checks that it is the square left of square prime

                        (in ?sRight ?cRight ?rPrime ) ; square right is in the column and row
                        (nextC ?cPrime ?cRight) ; checks that it is the square right of square prime

                        (nextF ?f_c1 ?f_c2) ; column fill is incremented by 1
                        (nextF ?f_r1 ?f_r2) ; row fill is incremented by 1

                        );end of precondition

    :effect (and 
               ; appends to the square below it
                (when (and (not(filled ?sLeft)) (not(filled ?sRight)) 
                        (not(filled ?sAbove)) (filled ?sBelow)) 
                    ; fills the square and increments the column and row fill
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))

                ; appends to the square above it
                (when (and (not(filled ?sLeft)) (not(filled ?sRight)) 
                        (filled ?sAbove) (not(filled ?sBelow))) 
                    ; fills the square and increments the column and row fill
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))
        ));end of effect and append to key row

(:action appendToKeyCorner
    ; fills next to a square that is already filled in the col and row
    :parameters (?sPrime - square ?cPrime - col ?rPrime - row 
                ?f_c1 - fill  ?f_r1 - fill ?f_c2 - fill  ?f_r2 - fill 
                ?keyC - key ?keyR - key
                ?sAbove - square ?rAbove - row
                ?sBelow - square ?rBelow - row
                ?sLeft - square ?cLeft - col
                ?sRight - square ?cRight - col
                );end of parameters

    :precondition (and (not (filled ?sPrime)) ; square is not already filled
                        (in ?sPrime ?cPrime ?rPrime ) ; square is in the column and row

                        (has ?cPrime ?keyC) ; column is filled by
                        (is ?keyC ?f_c1) ; how filled the col is
                        (not (is0 ?f_c1)) ; col key is not empty

                        (has ?rPrime ?keyR) ; row is filled
                        (is ?keyR ?f_r1) ; how filled the rowis
                        (not (is0 ?f_r1)) ; col key is not empty
                        

                        (in ?sAbove ?cPrime ?rAbove ) ; square above is in the column and row
                        (nextR ?rAbove ?rPrime) ; checks that it is the square above of square prime

                        (in ?sBelow ?cPrime ?rBelow ) ; square below is in the column and row
                        (nextR ?rPrime ?rBelow) ; checks that it is the square below of square prime

                        (in ?sLeft ?cLeft ?rPrime ) ; square left is in the column and row
                        (nextC ?cLeft ?cPrime) ; checks that it is the square left of square prime

                        (in ?sRight ?cRight ?rPrime ) ; square right is in the column and row
                        (nextC ?cPrime ?cRight) ; checks that it is the square right of square prime

                        (nextF ?f_c1 ?f_c2) ; column fill is incremented by 1
                        (nextF ?f_r1 ?f_r2) ; row fill is incremented by 1

                        );end of precondition

    :effect (and 
               ; bottom right is filled
                (when (and (filled ?sLeft) (not(filled ?sRight)) 
                        (filled ?sAbove) (not(filled ?sBelow))) 
                    ; fills the square and increments the column and row fill
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))

                ; top right is filled
                (when (and (filled ?sLeft) (not(filled ?sRight)) 
                        (not(filled ?sAbove)) (filled ?sBelow)) 
                    ; fills the square and increments the column and row fill
                        (and (filled ?sPrime)
                        (not (is ?keyC ?f_c1)) 
                        (not (is ?keyR ?f_r1))
                        (is ?keyC ?f_c2)
                        (is ?keyR ?f_r2)
                ))

                ; bottom left is filled
                (when (and (not(filled ?sLeft)) (filled ?sRight) 
                        (filled ?sAbove) (not(filled ?sBelow))) 
                    ; fills the square and increments the column and row fill
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))

                ; top left is filled
                (when (and (not(filled ?sLeft)) (filled ?sRight) 
                        (not(filled ?sAbove)) (filled ?sBelow)) 

                    ; fills the square and increments the column and row fill
                (and (filled ?sPrime)
                    (not (is ?keyC ?f_c1)) 
                    (not (is ?keyR ?f_r1))
                    (is ?keyC ?f_c2)
                    (is ?keyR ?f_r2)
                ))
        ));end of effect and append to key row
); end of define domain