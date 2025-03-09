(define (domain grid_domain)

(:requirements :strips :adl :typing :equality :negative-preconditions :disjunctive-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :derived-predicates :action-costs )

(:types 
col row fill square
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 
    (is ?a ?b - fill)
    ;(is ?a -row ?b -fill)
    ; tells what square is in what column and row
    (in ?a - square ?c - col ?r - row)

    ; tells if a square is filled or not (true for filled)
    (filled ?a - square)
    (nextF ?a - fill ?b - fill)
    (nextC ?a - col ?b - col)
    (nextR ?a - row ?b - row)
    (is0 ?a)
)

; fill action for when we have non numeric fluents
(:action cross_Fill
    ; takes in the sqaure that is being filled, the column and row it is in, 
    ;and the fill value of each of the column and row
    :parameters (?sPrime - square ?cPrime - col ?rPrime - row ?f_c1 - fill  ?f_r1 - fill ?f_c2 - fill  ?f_r2 - fill 
                ?sAbove - square ?rAbove - row
                ?sBelow - square ?rBelow - row
                ?sLeft - square ?cLeft - col
                ?sRight - square ?cRight - col
                )


    :precondition (and (not (filled ?sPrime)) ; square is not already filled
                        (in ?sPrime ?cPrime ?rPrime ) ; square is in the column and row
                        (is ?cPrime ?f_c1) ; column is filled by 
                        (is ?rPrime ?f_r1) ; row is filled

                        (in ?sAbove ?cPrime ?rAbove ) ; square is in the column and row
                        (nextR ?rAbove ?rPrime) ; row above is the next row

                        (in ?sBelow ?cPrime ?rBelow ) ; square is in the column and row
                        (nextR ?rPrime ?rBelow) ; row below is the next row

                        (in ?sLeft ?cLeft ?rPrime ) ; square is in the column and row
                        (nextC ?cLeft ?cPrime) ; column left is the next column

                        (in ?sRight ?cRight ?rPrime ) ; square is in the column and row
                        (nextC ?cPrime ?cRight) ; column right is the next column

                        (nextF ?f_c1 ?f_c2) ; column fill is incremented by 1
                        (nextF ?f_r1 ?f_r2) ; row fill is incremented by 1
                        )

    :effect (and 
                ; To make the problem simpler for now, we are requiring only 1 number per key
                ; we plan on expanding this to allow for multiple numbers per key as nonograms usually have
                ; If both column and row are empty
                (when (and (is0 ?f_c1) (is0 ?f_r1))
                    ; fills the square and increments the column and row fill
                    (and (filled ?sPrime)
                    (not (is ?cPrime ?f_c1)) 
                    (not (is ?rPrime ?f_r1))
                    (is ?cPrime ?f_c2)
                    (is ?rPrime ?f_r2))
                    )

                ; If column is empty and left is filled
                (when (and (is0 ?f_c1) (filled ?sLeft))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If column is empty and right is filled
                (when (and (is0 ?f_c1) (filled ?sRight))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If row is empty and above is filled
                (when (and (is0 ?f_r1) (filled ?sAbove))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If row is empty and below is filled
                (when (and (is0 ?f_r1) (filled ?sBelow))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If left and above squares are filled
                (when (and (filled ?sLeft) (filled ?sAbove))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If left and below squares are filled
                (when (and (filled ?sLeft) (filled ?sBelow))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If right and above squares are filled
                (when (and (filled ?sRight) (filled ?sAbove))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )

                ; If right and below squares are filled
                (when (and (filled ?sRight) (filled ?sBelow))
                        (and (filled ?sPrime)
                        (not (is ?cPrime ?f_c1)) 
                        (not (is ?rPrime ?f_r1))
                        (is ?cPrime ?f_c2)
                        (is ?rPrime ?f_r2))
                        )
                )
        )

    )
