;Header and description

(define (domain nonogram-grid)

;remove requirements that are not needed
(:requirements :strips :fluents :durative-actions :timed-initial-literals :typing :conditional-effects :negative-preconditions :duration-inequalities :equality)

(:types ;todo: enumerate types and their hierarchy here, e.g. car truck bus - vehicle
col
row
fill
square
)

; un-comment following line if constants are needed
;(:constants )

(:predicates ;todo: define predicates here
    ;(is ?a -col ?b -fill)
    ;(is ?a -row ?b -fill)
    (in ?a -square ?b - col ?c -row)
    (filled ?a -square)
    (next ?a -fill ?b -fill)
    (prev ?a -fill ?b -fill)
    (goal)
)


(:functions ;todo: define numeric functions here
    (fill ?c - col)
    (fill ?r - row)

    (:action cross_Fill
    :parameters (?s - square ?c - col ?r - row ?f_c - fill ?f_r - fill)
    :precondition (and (not (filled ?s))
                        (in ?s ?c ?r )
                        (is ?c ?f_c)
                        (is ?r ?f_r)
                        )

    :effect (and (filled ?s)
                (not (is ?c ?f_c))
                (not (is ?r ?f_r))
                (next ?f_c ?f_c+1)
                (next ?f_r ?f_r+1)
    )
    
    )

    (:action cross
    :parameters (?s - square ?c - col ?r - row ?)
    :precondition (and (not (filled ?s))
                        (in ?s ?c ?r )
                        )

    :effect (and (filled ?s)
    (increase (fill ?c) 1)
    (increase (fill ?r) 1)
    )
    )

    (:action complete
    :parameters ( ?c1 - col ?r - row ?)
    :duration ( and 
                       )
    :precondition (and (is ?c 5)
                        (is ?r 5)
                        )
    
    )
)

;define actions here

)