(define (problem planning)
	(:domain grid_domain)
	(:objects
		;Corresponding col 0 to 2 in a 3x3 grid)
		; will be used to tell how many squares are filled in each col
		col0 col1 col2 col3 col4 - col

		;Corresponding row 0 to 2 in a 3x3 grid)
		; will be used to tell how many squares are filled in each row
		row0 row1 row2 row3 row4 - row

		;Corresponding to how many squares are filled in a row
		fill0 fill1 fill2 fill3 - fill

		;Corresponding to each key for a given row or column
		c0Key0 c0Key1 
		c1Key0 c1Key1 
		c2Key0 c2Key1 
		c3Key0 c3Key1 
		c4Key0 c4Key1 
		
		r0Key0 r0Key1 
		r1Key0 r1Key1 
		r2Key0 r2Key1 
		r3Key0 r3Key1 
		r4Key0 r4Key1 - key

		;Corresponding to each square (true if filled)
		sq0_0 sq0_1 sq0_2 sq0_3 sq0_4 
		sq1_0 sq1_1 sq1_2 sq1_3 sq1_4 
		sq2_0 sq2_1 sq2_2 sq2_3 sq2_4 
		sq3_0 sq3_1 sq3_2 sq3_3 sq3_4 
		sq4_0 sq4_1 sq4_2 sq4_3 sq4_4  - square
	)
	(:init

		;Sets all keys to fill 0 (they all start off empty)
		(is c0Key0 fill0);for padding

		(is c1Key0 fill0)
		(is c1Key1 fill0)

		(is c2Key0 fill0)
		(is c2Key1 fill0)

		(is c3Key0 fill0)
		(is c3Key1 fill0)

		(is c4Key0 fill0);for padding

		(is r0Key0 fill0);for padding
		(is r1Key0 fill0)
		(is r1Key1 fill0)

		(is r2Key0 fill0)
		(is r2Key1 fill0)

		(is r3Key0 fill0)
		(is r3Key1 fill0)

		(is r4Key0 fill0);for padding

		(is0 fill0); helps to know if key is empty


		;to tell what fills come after eachother
		(nextF fill0 fill1)
		(nextF fill1 fill2)
		(nextF fill2 fill3)


		;to tell row is next to eachother
		(nextR row0 row1)
		(nextR row1 row2)
		(nextR row2 row3)
		(nextR row3 row4)


		;to tell col is next to eachother
		(nextC col0 col1)
		(nextC col1 col2)
		(nextC col2 col3)
		(nextC col3 col4)


		;to tell what square are in what column and row
		(in sq0_0 col0 row0)
		(in sq0_1 col0 row1)
		(in sq0_2 col0 row2)
		(in sq0_3 col0 row3)
		(in sq0_4 col0 row4)
		
		(in sq1_0 col1 row0)
		(in sq1_1 col1 row1)
		(in sq1_2 col1 row2)
		(in sq1_3 col1 row3)
		(in sq1_4 col1 row4)
		
		(in sq2_0 col2 row0)
		(in sq2_1 col2 row1)
		(in sq2_2 col2 row2)
		(in sq2_3 col2 row3)
		(in sq2_4 col2 row4)
		
		(in sq3_0 col3 row0)
		(in sq3_1 col3 row1)
		(in sq3_2 col3 row2)
		(in sq3_3 col3 row3)
		(in sq3_4 col3 row4)
		
		(in sq4_0 col4 row0)
		(in sq4_1 col4 row1)
		(in sq4_2 col4 row2)
		(in sq4_3 col4 row3)
		(in sq4_4 col4 row4)
		

		;Setting the keys to its given row/column
		(has col1 c1Key0)
		(has col1 c1Key1)

		(has col2 c2Key0)
		(has col2 c2Key1)

		(has col3 c3Key0)
		(has col3 c3Key1)


		(has row1 r1Key0)
		(has row1 r1Key1)

		(has row2 r2Key0)
		(has row2 r2Key1)

		(has row3 r3Key0)
		(has row3 r3Key1)


		(has col0 c0Key0)
		(has col4 c4Key0)
		(has row0 r0Key0)
		(has row4 r4Key0))
	(:goal (and
		(is c0Key0 fill0);for padding

		;Corresponding to the col keys 
		;[[1, 0], [1, 1], [1, 0]]
		(is c1Key0 fill1)
		(is c1Key1 fill0)

		(is c2Key0 fill1)
		(is c2Key1 fill1)

		(is c3Key0 fill1)
		(is c3Key1 fill0)

		(is c4Key0 fill0);for padding


		(is r0Key0 fill0);for padding


		;Corresponding to the row keys
		;[[1, 0], [1, 1], [1, 0]]
		(is r1Key0 fill1)
		(is r1Key1 fill0)

		(is r2Key0 fill1)
		(is r2Key1 fill1)

		(is r3Key0 fill1)
		(is r3Key1 fill0)

		(is r4Key0 fill0);for padding
	)); end of goal
	;Sol: #-filled 0-blank
	;0#0
	;#0#
	;0#0
);end of define
