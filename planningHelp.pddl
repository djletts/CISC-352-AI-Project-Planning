(define (problem planning)
	(:domain grid_domain)
	(:objects
		;Corresponding col 0 to 4 in a 5x5 grid)
		; will be used to tell how many squares are filled in each col
		col0 col1 col2 col3 col4 col5 col6 - col

		;Corresponding row 0 to 4 in a 5x5 grid)
		; will be used to tell how many squares are filled in each row
		row0 row1 row2 row3 row4 row5 row6 - row

		;Corresponding to how many squares are filled in a row
		fill0 fill1 fill2 fill3 fill4 fill5 - fill

		;Corresponding to each key for a given row or column
		
		c0Key0 c0Key1 c0Key2 
		c1Key0 c1Key1 c1Key2 
		c2Key0 c2Key1 c2Key2 
		c3Key0 c3Key1 c3Key2 
		c4Key0 c4Key1 c4Key2 
		c5Key0 c5Key1 c5Key2 
		c6Key0 c6Key1 c6Key2 
		
		r0Key0 r0Key1 r0Key2 
		r1Key0 r1Key1 r1Key2 
		r2Key0 r2Key1 r2Key2 
		r3Key0 r3Key1 r3Key2 
		r4Key0 r4Key1 r4Key2 
		r5Key0 r5Key1 r5Key2 
		r6Key0 r6Key1 r6Key2 - key

		;Corresponding to each square (true if filled)
		sq0_0 sq0_1 sq0_2 sq0_3 sq0_4 sq0_5 sq0_6 
		sq1_0 sq1_1 sq1_2 sq1_3 sq1_4 sq1_5 sq1_6 
		sq2_0 sq2_1 sq2_2 sq2_3 sq2_4 sq2_5 sq2_6 
		sq3_0 sq3_1 sq3_2 sq3_3 sq3_4 sq3_5 sq3_6 
		sq4_0 sq4_1 sq4_2 sq4_3 sq4_4 sq4_5 sq4_6 
		sq5_0 sq5_1 sq5_2 sq5_3 sq5_4 sq5_5 sq5_6 
		sq6_0 sq6_1 sq6_2 sq6_3 sq6_4 sq6_5 sq6_6  - square
	)
	(:init

		;Sets all keys to fill 0 (they all start off empty)
		(is c0Key0 fill0);for padding

		(is c1Key0 fill0)
		(is c1Key1 fill0)
		(is c1Key2 fill0)

		(is c2Key0 fill0)
		(is c2Key1 fill0)
		(is c2Key2 fill0)

		(is c3Key0 fill0)
		(is c3Key1 fill0)
		(is c3Key2 fill0)

		(is c4Key0 fill0)
		(is c4Key1 fill0)
		(is c4Key2 fill0)

		(is c5Key0 fill0)
		(is c5Key1 fill0)
		(is c5Key2 fill0)

		(is c6Key0 fill0);for padding

		(is r0Key0 fill0);for padding
		(is r1Key0 fill0)
		(is r1Key1 fill0)
		(is r1Key2 fill0)

		(is r2Key0 fill0)
		(is r2Key1 fill0)
		(is r2Key2 fill0)

		(is r3Key0 fill0)
		(is r3Key1 fill0)
		(is r3Key2 fill0)

		(is r4Key0 fill0)
		(is r4Key1 fill0)
		(is r4Key2 fill0)

		(is r5Key0 fill0)
		(is r5Key1 fill0)
		(is r5Key2 fill0)

		(is r6Key0 fill0);for padding

		(is0 fill0); helps to know if key is empty


		;to tell what fills come after eachother
		(nextF fill0 fill1)
		(nextF fill1 fill2)
		(nextF fill2 fill3)
		(nextF fill3 fill4)
		(nextF fill4 fill5)


		;to tell row is next to eachother
		(nextR row0 row1)
		(nextR row1 row2)
		(nextR row2 row3)
		(nextR row3 row4)
		(nextR row4 row5)
		(nextR row5 row6)


		;to tell col is next to eachother
		(nextC col0 col1)
		(nextC col1 col2)
		(nextC col2 col3)
		(nextC col3 col4)
		(nextC col4 col5)
		(nextC col5 col6)


		;to tell what square are in what column and row
		(in sq0_0 col0 row0)
		(in sq0_1 col0 row1)
		(in sq0_2 col0 row2)
		(in sq0_3 col0 row3)
		(in sq0_4 col0 row4)
		(in sq0_5 col0 row5)
		(in sq0_6 col0 row6)
		
		(in sq1_0 col1 row0)
		(in sq1_1 col1 row1)
		(in sq1_2 col1 row2)
		(in sq1_3 col1 row3)
		(in sq1_4 col1 row4)
		(in sq1_5 col1 row5)
		(in sq1_6 col1 row6)
		
		(in sq2_0 col2 row0)
		(in sq2_1 col2 row1)
		(in sq2_2 col2 row2)
		(in sq2_3 col2 row3)
		(in sq2_4 col2 row4)
		(in sq2_5 col2 row5)
		(in sq2_6 col2 row6)
		
		(in sq3_0 col3 row0)
		(in sq3_1 col3 row1)
		(in sq3_2 col3 row2)
		(in sq3_3 col3 row3)
		(in sq3_4 col3 row4)
		(in sq3_5 col3 row5)
		(in sq3_6 col3 row6)
		
		(in sq4_0 col4 row0)
		(in sq4_1 col4 row1)
		(in sq4_2 col4 row2)
		(in sq4_3 col4 row3)
		(in sq4_4 col4 row4)
		(in sq4_5 col4 row5)
		(in sq4_6 col4 row6)
		
		(in sq5_0 col5 row0)
		(in sq5_1 col5 row1)
		(in sq5_2 col5 row2)
		(in sq5_3 col5 row3)
		(in sq5_4 col5 row4)
		(in sq5_5 col5 row5)
		(in sq5_6 col5 row6)
		
		(in sq6_0 col6 row0)
		(in sq6_1 col6 row1)
		(in sq6_2 col6 row2)
		(in sq6_3 col6 row3)
		(in sq6_4 col6 row4)
		(in sq6_5 col6 row5)
		(in sq6_6 col6 row6)
		

		;Setting the keys to its given row/column
		(has col1 c1Key0)
		(has col1 c1Key1)
		(has col1 c1Key2)

		(has col2 c2Key0)
		(has col2 c2Key1)
		(has col2 c2Key2)

		(has col3 c3Key0)
		(has col3 c3Key1)
		(has col3 c3Key2)

		(has col4 c4Key0)
		(has col4 c4Key1)
		(has col4 c4Key2)

		(has col5 c5Key0)
		(has col5 c5Key1)
		(has col5 c5Key2)


		(has row1 r1Key0)
		(has row1 r1Key1)
		(has row1 r1Key2)

		(has row2 r2Key0)
		(has row2 r2Key1)
		(has row2 r2Key2)

		(has row3 r3Key0)
		(has row3 r3Key1)
		(has row3 r3Key2)

		(has row4 r4Key0)
		(has row4 r4Key1)
		(has row4 r4Key2)

		(has row5 r5Key0)
		(has row5 r5Key1)
		(has row5 r5Key2)


		(has col0 c0Key0)
		(has col6 c6Key0)
		(has row0 r0Key0)
		(has row6 r6Key0))
	(:goal (and
		(is c0Key0 fill0);for padding

		;Corresponding to the col keys 
		;[[2, 0, 0], [2, 0, 0], [2, 1, 0], [3, 0, 0], [3, 0, 0]]
		(is c1Key0 fill2)
		(is c1Key1 fill0)
		(is c1Key2 fill0)

		(is c2Key0 fill2)
		(is c2Key1 fill0)
		(is c2Key2 fill0)

		(is c3Key0 fill2)
		(is c3Key1 fill1)
		(is c3Key2 fill0)

		(is c4Key0 fill3)
		(is c4Key1 fill0)
		(is c4Key2 fill0)

		(is c5Key0 fill3)
		(is c5Key1 fill0)
		(is c5Key2 fill0)

		(is c6Key0 fill0);for padding


		(is r0Key0 fill0);for padding


		;Corresponding to the row keys
		;[[3, 0, 0], [4, 0, 0], [2, 0, 0], [1, 1, 1], [1, 0, 0]]
		(is r1Key0 fill3)
		(is r1Key1 fill0)
		(is r1Key2 fill0)

		(is r2Key0 fill4)
		(is r2Key1 fill0)
		(is r2Key2 fill0)

		(is r3Key0 fill2)
		(is r3Key1 fill0)
		(is r3Key2 fill0)

		(is r4Key0 fill1)
		(is r4Key1 fill1)
		(is r4Key2 fill1)

		(is r5Key0 fill1)
		(is r5Key1 fill0)
		(is r5Key2 fill0)

		(is r6Key0 fill0);for padding

	)); end of goal
);end of define
