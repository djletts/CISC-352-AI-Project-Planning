;Header and description

(define (domain grid_domain)

(:requirements :strips :fluents :typing :conditional-effects :negative-preconditions )

(:types 
col row fill square
)

; un-comment following line if constants are needed
;(:constants )

(:predicates 
    (is ?a -col ?b -fill)
    ;(is ?a -row ?b -fill)
    ; tells what square is in what column and row
    (in ?a - square ?c - col ?r -row)

    ; tells if a square is filled or not (true for filled)
    (filled ?a - square)
    ;(next ?a -fill ?b -fill)
    ;(prev ?a -fill ?b -fill)

    (goal)
)


;(:functions 
;    (fill ?c - col)
;    (fill ?r - row)
;)

; fill action for when we have non numeric fluents
(:action cross_Fill
    ; takes in the sqaure that is being filled, the column and row it is in, 
    ;and the fill value of each of the column and row
    :parameters (?s - square ?c - col ?r - row ?f_c  ?f_r )

    :precondition (and (not (filled ?s)) ; square is not already filled
                        (in ?s ?c ?r ) ; square is in the column and row
                        (is ?c ?f_c) ; column is filled by 
                        (is ?r ?f_r) ; row is filled
                        )

    :effect (and (filled ?s) ; square is filled
                ;The column and row fills are changed and increment by 1
                (not (is ?c ?f_c)) 
                (not (is ?r ?f_r))
                ;(next ?f_c ?f_c+1)
                ;(next ?f_r ?f_r+1)
    )
    )

; fill action for when we have numeric fluents
    ;(:action cross
     ; takes in the sqaure that is being filled, the column and row it is in
    ;:parameters (?s - square ?c - col ?r - row ?)

    ;:precondition (and (not (filled ?s)) ; square is not already filled
    ;                    (in ?s ?c ?r ); square is in the column and row
    ;                    )

    ;:effect (and (filled ?s) ; square is filled
         ;The column and row fills are changed and increment by 1
    ;    (increase (fill ?c) 1)
    ;    (increase (fill ?r) 1)
    ;)
    ;)

; action to complete the goal
(:action complete
    :parameters ( ?c1 - col ?r - row)
    :precondition (and (is ?c1 )
                        (is ?r)
                        )
    :effect (and 
                (goal)
    )
    )
)