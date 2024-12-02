declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@max = global i32 1073741824
@a = global [ 10000000 x i32 ] zeroinitializer
@b = global [ 10000000 x i32 ] zeroinitializer
@kernelid = global [ 10000 x i32 ] zeroinitializer
define i32 @checkrange( i32 %r100 ) {
bb1:
  %r387 = add i32 0, 0
  %r388 = add i32 %r100, 0
  br label %bb2

bb2:
  %r396 = phi i32 [ %r388, %bb1 ], [ %r395, %bb3 ]
  %r102 = add i32 %r396, 0
  %r103 = load i32, i32* @max
  %r104 = icmp sgt i32 %r396, %r103
  br i1 %r104, label %bb3, label %bb4

bb3:
  %r394 = phi i32 [ %r396, %bb2 ]
  %r105 = add i32 %r394, 0
  %r106 = load i32, i32* @max
  %r107 = sub i32 %r394, %r106
  %r395 = add i32 %r107, 0
  br label %bb2

bb4:
  %r392 = phi i32 [ %r396, %bb2 ]
  br label %bb5

bb5:
  %r391 = phi i32 [ %r392, %bb4 ], [ %r390, %bb6 ]
  %r108 = add i32 %r391, 0
  %r109 = icmp slt i32 %r391, 0
  br i1 %r109, label %bb6, label %bb7

bb6:
  %r389 = phi i32 [ %r391, %bb5 ]
  %r110 = add i32 %r389, 0
  %r111 = load i32, i32* @max
  %r112 = add i32 %r389, %r111
  %r390 = add i32 %r112, 0
  br label %bb5

bb7:
  %r393 = phi i32 [ %r391, %bb5 ]
  %r113 = add i32 %r393, 0
  ret i32 %r393
}

define i32 @mod( i32 %r114, i32 %r116 ) {
bb8:
  %r399 = add i32 0, 0
  %r400 = add i32 %r114, 0
  %r401 = add i32 0, 0
  %r402 = add i32 %r116, 0
  %r118 = add i32 %r400, 0
  %r119 = add i32 %r400, 0
  %r120 = add i32 %r402, 0
  %r121 = sdiv i32 %r400, %r402
  %r122 = add i32 %r402, 0
  %r123 = mul i32 %r121, %r402
  %r124 = sub i32 %r400, %r123
  ret i32 %r124
}

define i32 @reduce( i32 %r125, i32 %r127, i32 %r129 ) {
bb9:
  %r412 = add i32 0, 0
  %r413 = add i32 0, 0
  %r414 = add i32 0, 0
  %r415 = add i32 0, 0
  %r416 = add i32 0, 0
  %r417 = add i32 0, 0
  %r418 = add i32 0, 0
  %r419 = add i32 %r125, 0
  %r420 = add i32 0, 0
  %r421 = add i32 %r127, 0
  %r422 = add i32 0, 0
  %r423 = add i32 %r129, 0
  %r131 = add i32 %r419, 0
  %r132 = icmp eq i32 %r419, 0
  br i1 %r132, label %bb10, label %bb11

bb10:
  %r133 = add i32 %r421, 0
  %r134 = add i32 %r423, 0
  %r135 = add i32 %r421, %r423
  %r136 = call i32 @checkrange(i32 %r135)
  ret i32 %r136
bb11:
  %r137 = add i32 %r419, 0
  %r138 = icmp eq i32 %r419, 1
  br i1 %r138, label %bb12, label %bb13

bb12:
  %r460 = add i32 0, 0
  %r461 = add i32 1, 0
  br label %bb14

bb14:
  %r438 = phi i32 [ %r461, %bb12 ], [ %r457, %bb19 ]
  %r439 = phi i32 [ %r460, %bb12 ], [ %r456, %bb19 ]
  %r141 = add i32 %r438, 0
  %r142 = load i32, i32* @max
  %r143 = icmp slt i32 %r438, %r142
  br i1 %r143, label %bb15, label %bb16

bb15:
  %r433 = phi i32 [ %r438, %bb14 ]
  %r434 = phi i32 [ %r439, %bb14 ]
  %r144 = add i32 %r421, 0
  %r145 = add i32 %r433, 0
  %r146 = sdiv i32 %r421, %r433
  %r147 = call i32 @mod(i32 %r146, i32 2)
  %r148 = add i32 %r423, 0
  %r149 = add i32 %r433, 0
  %r150 = sdiv i32 %r423, %r433
  %r151 = call i32 @mod(i32 %r150, i32 2)
  %r152 = icmp eq i32 %r147, %r151
  br i1 %r152, label %bb17, label %bb18

bb17:
  %r464 = phi i32 [ %r433, %bb15 ]
  %r465 = phi i32 [ %r434, %bb15 ]
  %r153 = add i32 %r465, 0
  %r154 = mul i32 %r465, 2
  %r466 = add i32 %r154, 0
  br label %bb19

bb18:
  %r440 = phi i32 [ %r433, %bb15 ]
  %r441 = phi i32 [ %r434, %bb15 ]
  %r155 = add i32 %r441, 0
  %r156 = mul i32 %r441, 2
  %r157 = add i32 %r156, 1
  %r442 = add i32 %r157, 0
  br label %bb19

bb19:
  %r455 = phi i32 [ %r464, %bb17 ], [ %r440, %bb18 ]
  %r456 = phi i32 [ %r466, %bb17 ], [ %r442, %bb18 ]
  %r158 = add i32 %r455, 0
  %r159 = mul i32 %r455, 2
  %r457 = add i32 %r159, 0
  br label %bb14

bb16:
  %r431 = phi i32 [ %r438, %bb14 ]
  %r432 = phi i32 [ %r439, %bb14 ]
  %r160 = add i32 %r432, 0
  ret i32 %r432
bb13:
  %r161 = add i32 %r419, 0
  %r162 = icmp eq i32 %r419, 2
  br i1 %r162, label %bb20, label %bb21

bb20:
  %r163 = add i32 %r421, 0
  %r164 = add i32 %r423, 0
  %r165 = icmp sgt i32 %r421, %r423
  br i1 %r165, label %bb22, label %bb23

bb22:
  %r166 = add i32 %r421, 0
  ret i32 %r421
bb23:
  %r167 = add i32 %r423, 0
  ret i32 %r423
bb21:
  %r168 = add i32 %r419, 0
  %r169 = icmp eq i32 %r419, 3
  br i1 %r169, label %bb25, label %bb26

bb25:
  %r462 = add i32 0, 0
  %r463 = add i32 1, 0
  br label %bb27

bb27:
  %r467 = phi i32 [ %r462, %bb25 ], [ %r447, %bb32 ]
  %r468 = phi i32 [ %r463, %bb25 ], [ %r449, %bb32 ]
  %r172 = add i32 %r468, 0
  %r173 = load i32, i32* @max
  %r174 = icmp slt i32 %r468, %r173
  br i1 %r174, label %bb28, label %bb29

bb28:
  %r471 = phi i32 [ %r467, %bb27 ]
  %r472 = phi i32 [ %r468, %bb27 ]
  %r175 = add i32 %r421, 0
  %r176 = add i32 %r472, 0
  %r177 = sdiv i32 %r421, %r472
  %r178 = call i32 @mod(i32 %r177, i32 2)
  %r179 = icmp eq i32 %r178, 1
  br i1 %r179, label %bb30, label %bb33

bb33:
  %r424 = phi i32 [ %r471, %bb28 ]
  %r425 = phi i32 [ %r472, %bb28 ]
  %r180 = add i32 %r423, 0
  %r181 = add i32 %r425, 0
  %r182 = sdiv i32 %r423, %r425
  %r183 = call i32 @mod(i32 %r182, i32 2)
  %r184 = icmp eq i32 %r183, 1
  br i1 %r184, label %bb30, label %bb31

bb30:
  %r476 = phi i32 [ %r471, %bb28 ], [ %r424, %bb33 ]
  %r477 = phi i32 [ %r472, %bb28 ], [ %r425, %bb33 ]
  %r185 = add i32 %r476, 0
  %r186 = mul i32 %r476, 2
  %r187 = add i32 %r186, 1
  %r478 = add i32 %r187, 0
  br label %bb32

bb31:
  %r473 = phi i32 [ %r424, %bb33 ]
  %r474 = phi i32 [ %r425, %bb33 ]
  %r188 = add i32 %r473, 0
  %r189 = mul i32 %r473, 2
  %r475 = add i32 %r189, 0
  br label %bb32

bb32:
  %r447 = phi i32 [ %r478, %bb30 ], [ %r475, %bb31 ]
  %r448 = phi i32 [ %r477, %bb30 ], [ %r474, %bb31 ]
  %r190 = add i32 %r448, 0
  %r191 = mul i32 %r448, 2
  %r449 = add i32 %r191, 0
  br label %bb27

bb29:
  %r469 = phi i32 [ %r467, %bb27 ]
  %r470 = phi i32 [ %r468, %bb27 ]
  %r192 = add i32 %r469, 0
  ret i32 %r469
bb26:
  %r193 = add i32 %r419, 0
  %r194 = icmp eq i32 %r419, 4
  br i1 %r194, label %bb34, label %bb35

bb34:
  %r458 = add i32 0, 0
  %r459 = add i32 1, 0
  br label %bb36

bb36:
  %r443 = phi i32 [ %r458, %bb34 ], [ %r435, %bb41 ]
  %r444 = phi i32 [ %r459, %bb34 ], [ %r437, %bb41 ]
  %r197 = add i32 %r444, 0
  %r198 = load i32, i32* @max
  %r199 = icmp slt i32 %r444, %r198
  br i1 %r199, label %bb37, label %bb38

bb37:
  %r426 = phi i32 [ %r443, %bb36 ]
  %r427 = phi i32 [ %r444, %bb36 ]
  %r200 = add i32 %r421, 0
  %r201 = add i32 %r427, 0
  %r202 = sdiv i32 %r421, %r427
  %r203 = call i32 @mod(i32 %r202, i32 2)
  %r204 = icmp eq i32 %r203, 1
  br i1 %r204, label %bb42, label %bb40

bb42:
  %r450 = phi i32 [ %r426, %bb37 ]
  %r451 = phi i32 [ %r427, %bb37 ]
  %r205 = add i32 %r423, 0
  %r206 = add i32 %r451, 0
  %r207 = sdiv i32 %r423, %r451
  %r208 = call i32 @mod(i32 %r207, i32 2)
  %r209 = icmp eq i32 %r208, 1
  br i1 %r209, label %bb39, label %bb40

bb39:
  %r452 = phi i32 [ %r450, %bb42 ]
  %r453 = phi i32 [ %r451, %bb42 ]
  %r210 = add i32 %r452, 0
  %r211 = mul i32 %r452, 2
  %r212 = add i32 %r211, 1
  %r454 = add i32 %r212, 0
  br label %bb41

bb40:
  %r428 = phi i32 [ %r426, %bb37 ], [ %r450, %bb42 ]
  %r429 = phi i32 [ %r427, %bb37 ], [ %r451, %bb42 ]
  %r213 = add i32 %r428, 0
  %r214 = mul i32 %r428, 2
  %r430 = add i32 %r214, 0
  br label %bb41

bb41:
  %r435 = phi i32 [ %r454, %bb39 ], [ %r430, %bb40 ]
  %r436 = phi i32 [ %r453, %bb39 ], [ %r429, %bb40 ]
  %r215 = add i32 %r436, 0
  %r216 = mul i32 %r436, 2
  %r437 = add i32 %r216, 0
  br label %bb36

bb38:
  %r445 = phi i32 [ %r443, %bb36 ]
  %r446 = phi i32 [ %r444, %bb36 ]
  %r217 = add i32 %r445, 0
  ret i32 %r445
bb35:
  ret i32 0
}

define i32 @getvalue( i32* %r218, i32 %r219, i32 %r221, i32 %r223, i32 %r225 ) {
bb43:
  %r484 = add i32 0, 0
  %r485 = add i32 0, 0
  %r486 = add i32 %r219, 0
  %r487 = add i32 0, 0
  %r488 = add i32 %r221, 0
  %r489 = add i32 0, 0
  %r490 = add i32 %r223, 0
  %r491 = add i32 0, 0
  %r492 = add i32 %r225, 0
  %r227 = add i32 %r490, 0
  %r228 = icmp slt i32 %r490, 0
  br i1 %r228, label %bb44, label %bb48

bb48:
  %r229 = add i32 %r492, 0
  %r230 = icmp slt i32 %r492, 0
  br i1 %r230, label %bb44, label %bb47

bb47:
  %r231 = add i32 %r490, 0
  %r232 = add i32 %r486, 0
  %r233 = icmp sge i32 %r490, %r486
  br i1 %r233, label %bb44, label %bb46

bb46:
  %r234 = add i32 %r492, 0
  %r235 = add i32 %r488, 0
  %r236 = icmp sge i32 %r492, %r488
  br i1 %r236, label %bb44, label %bb45

bb44:
  ret i32 0
bb45:
  %r238 = add i32 %r490, 0
  %r239 = add i32 %r488, 0
  %r240 = mul i32 %r490, %r488
  %r241 = add i32 %r492, 0
  %r242 = add i32 %r240, %r492
  %r493 = add i32 %r242, 0
  %r243 = add i32 %r493, 0
  %r244 = getelementptr i32, i32* %r218, i32 %r493
  %r245 = load i32, i32* %r244
  ret i32 %r245
}

define i32 @convn( i32 %r246, i32* %r248, i32* %r249, i32 %r250, i32 %r252, i32 %r254 ) {
bb49:
  %r505 = add i32 0, 0
  %r506 = add i32 0, 0
  %r507 = add i32 %r246, 0
  %r508 = add i32 0, 0
  %r509 = add i32 %r250, 0
  %r510 = add i32 0, 0
  %r511 = add i32 %r252, 0
  %r512 = add i32 0, 0
  %r513 = add i32 %r254, 0
  %r514 = add i32 0, 0
  %r515 = add i32 0, 0
  %r516 = add i32 0, 0
  %r517 = add i32 0, 0
  %r518 = add i32 0, 0
  %r519 = add i32 0, 0
  %r520 = add i32 0, 0
  %r521 = add i32 0, 0
  %r522 = add i32 1, 0
  br label %bb50

bb50:
  %r568 = phi i32 [ %r515, %bb49 ], [ %r593, %bb69 ]
  %r569 = phi i32 [ %r517, %bb49 ], [ %r594, %bb69 ]
  %r570 = phi i32 [ %r505, %bb49 ], [ %r595, %bb69 ]
  %r571 = phi i32 [ %r518, %bb49 ], [ %r596, %bb69 ]
  %r572 = phi i32 [ %r519, %bb49 ], [ %r597, %bb69 ]
  %r573 = phi i32 [ %r520, %bb49 ], [ %r598, %bb69 ]
  %r262 = add i32 %r522, 0
  %r263 = add i32 %r522, 0
  %r264 = icmp eq i32 %r522, %r522
  br i1 %r264, label %bb51, label %bb52

bb51:
  %r574 = phi i32 [ %r568, %bb50 ]
  %r575 = phi i32 [ %r569, %bb50 ]
  %r576 = phi i32 [ %r570, %bb50 ]
  %r577 = phi i32 [ %r571, %bb50 ]
  %r578 = phi i32 [ %r572, %bb50 ]
  %r579 = phi i32 [ %r573, %bb50 ]
  %r580 = add i32 0, 0
  br label %bb53

bb53:
  %r581 = phi i32 [ %r574, %bb51 ], [ %r523, %bb67 ]
  %r582 = phi i32 [ %r580, %bb51 ], [ %r524, %bb67 ]
  %r583 = phi i32 [ %r576, %bb51 ], [ %r525, %bb67 ]
  %r584 = phi i32 [ %r577, %bb51 ], [ %r526, %bb67 ]
  %r585 = phi i32 [ %r578, %bb51 ], [ %r527, %bb67 ]
  %r586 = phi i32 [ %r579, %bb51 ], [ %r528, %bb67 ]
  %r265 = add i32 %r522, 0
  %r266 = add i32 %r522, 0
  %r267 = icmp eq i32 %r522, %r522
  br i1 %r267, label %bb54, label %bb55

bb54:
  %r611 = phi i32 [ %r581, %bb53 ]
  %r612 = phi i32 [ %r582, %bb53 ]
  %r613 = phi i32 [ %r583, %bb53 ]
  %r614 = phi i32 [ %r584, %bb53 ]
  %r615 = phi i32 [ %r585, %bb53 ]
  %r616 = phi i32 [ %r586, %bb53 ]
  %r617 = add i32 0, 0
  %r268 = add i32 %r611, 0
  %r269 = add i32 %r513, 0
  %r270 = sdiv i32 %r513, 2
  %r271 = sub i32 %r611, %r270
  %r618 = add i32 %r271, 0
  br label %bb56

bb56:
  %r605 = phi i32 [ %r611, %bb54 ], [ %r543, %bb65 ]
  %r606 = phi i32 [ %r612, %bb54 ], [ %r544, %bb65 ]
  %r607 = phi i32 [ %r613, %bb54 ], [ %r545, %bb65 ]
  %r608 = phi i32 [ %r618, %bb54 ], [ %r546, %bb65 ]
  %r609 = phi i32 [ %r615, %bb54 ], [ %r547, %bb65 ]
  %r610 = phi i32 [ %r617, %bb54 ], [ %r548, %bb65 ]
  %r272 = add i32 %r522, 0
  %r273 = add i32 %r522, 0
  %r274 = icmp eq i32 %r522, %r522
  br i1 %r274, label %bb57, label %bb58

bb57:
  %r619 = phi i32 [ %r605, %bb56 ]
  %r620 = phi i32 [ %r606, %bb56 ]
  %r621 = phi i32 [ %r607, %bb56 ]
  %r622 = phi i32 [ %r608, %bb56 ]
  %r623 = phi i32 [ %r609, %bb56 ]
  %r624 = phi i32 [ %r610, %bb56 ]
  %r275 = add i32 %r620, 0
  %r276 = add i32 %r513, 0
  %r277 = sdiv i32 %r513, 2
  %r278 = sub i32 %r620, %r277
  %r625 = add i32 %r278, 0
  br label %bb59

bb59:
  %r626 = phi i32 [ %r619, %bb57 ], [ %r562, %bb63 ]
  %r627 = phi i32 [ %r620, %bb57 ], [ %r563, %bb63 ]
  %r628 = phi i32 [ %r621, %bb57 ], [ %r564, %bb63 ]
  %r629 = phi i32 [ %r622, %bb57 ], [ %r565, %bb63 ]
  %r630 = phi i32 [ %r625, %bb57 ], [ %r566, %bb63 ]
  %r631 = phi i32 [ %r624, %bb57 ], [ %r567, %bb63 ]
  %r279 = add i32 %r522, 0
  %r280 = add i32 %r522, 0
  %r281 = icmp eq i32 %r522, %r522
  br i1 %r281, label %bb60, label %bb61

bb60:
  %r639 = phi i32 [ %r626, %bb59 ]
  %r640 = phi i32 [ %r627, %bb59 ]
  %r641 = phi i32 [ %r628, %bb59 ]
  %r642 = phi i32 [ %r629, %bb59 ]
  %r643 = phi i32 [ %r630, %bb59 ]
  %r644 = phi i32 [ %r631, %bb59 ]
  %r282 = add i32 %r507, 0
  %r283 = add i32 %r644, 0
  %r284 = add i32 %r509, 0
  %r285 = add i32 %r511, 0
  %r286 = add i32 %r642, 0
  %r287 = add i32 %r643, 0
  %r288 = call i32 @getvalue(i32* %r248, i32 %r509, i32 %r511, i32 %r642, i32 %r643)
  %r289 = call i32 @reduce(i32 %r507, i32 %r644, i32 %r288)
  %r645 = add i32 %r289, 0
  %r290 = add i32 %r643, 0
  %r291 = add i32 %r643, 1
  %r646 = add i32 %r291, 0
  %r292 = add i32 %r646, 0
  %r293 = add i32 %r640, 0
  %r294 = add i32 %r513, 0
  %r295 = sdiv i32 %r513, 2
  %r296 = add i32 %r640, %r295
  %r297 = icmp sge i32 %r646, %r296
  br i1 %r297, label %bb62, label %bb63

bb62:
  %r647 = phi i32 [ %r639, %bb60 ]
  %r648 = phi i32 [ %r640, %bb60 ]
  %r649 = phi i32 [ %r641, %bb60 ]
  %r650 = phi i32 [ %r642, %bb60 ]
  %r651 = phi i32 [ %r646, %bb60 ]
  %r652 = phi i32 [ %r645, %bb60 ]
  br label %bb61

bb63:
  %r562 = phi i32 [ %r639, %bb60 ]
  %r563 = phi i32 [ %r640, %bb60 ]
  %r564 = phi i32 [ %r641, %bb60 ]
  %r565 = phi i32 [ %r642, %bb60 ]
  %r566 = phi i32 [ %r646, %bb60 ]
  %r567 = phi i32 [ %r645, %bb60 ]
  br label %bb59

bb61:
  %r555 = phi i32 [ %r626, %bb59 ], [ %r647, %bb62 ]
  %r556 = phi i32 [ %r627, %bb59 ], [ %r648, %bb62 ]
  %r557 = phi i32 [ %r628, %bb59 ], [ %r649, %bb62 ]
  %r558 = phi i32 [ %r629, %bb59 ], [ %r650, %bb62 ]
  %r559 = phi i32 [ %r630, %bb59 ], [ %r651, %bb62 ]
  %r560 = phi i32 [ %r631, %bb59 ], [ %r652, %bb62 ]
  %r298 = add i32 %r558, 0
  %r299 = add i32 %r558, 1
  %r561 = add i32 %r299, 0
  %r300 = add i32 %r561, 0
  %r301 = add i32 %r555, 0
  %r302 = add i32 %r513, 0
  %r303 = sdiv i32 %r513, 2
  %r304 = add i32 %r555, %r303
  %r305 = icmp sge i32 %r561, %r304
  br i1 %r305, label %bb64, label %bb65

bb64:
  %r549 = phi i32 [ %r555, %bb61 ]
  %r550 = phi i32 [ %r556, %bb61 ]
  %r551 = phi i32 [ %r557, %bb61 ]
  %r552 = phi i32 [ %r561, %bb61 ]
  %r553 = phi i32 [ %r559, %bb61 ]
  %r554 = phi i32 [ %r560, %bb61 ]
  br label %bb58

bb65:
  %r543 = phi i32 [ %r555, %bb61 ]
  %r544 = phi i32 [ %r556, %bb61 ]
  %r545 = phi i32 [ %r557, %bb61 ]
  %r546 = phi i32 [ %r561, %bb61 ]
  %r547 = phi i32 [ %r559, %bb61 ]
  %r548 = phi i32 [ %r560, %bb61 ]
  br label %bb56

bb58:
  %r529 = phi i32 [ %r605, %bb56 ], [ %r549, %bb64 ]
  %r530 = phi i32 [ %r606, %bb56 ], [ %r550, %bb64 ]
  %r531 = phi i32 [ %r607, %bb56 ], [ %r551, %bb64 ]
  %r532 = phi i32 [ %r608, %bb56 ], [ %r552, %bb64 ]
  %r533 = phi i32 [ %r609, %bb56 ], [ %r553, %bb64 ]
  %r534 = phi i32 [ %r610, %bb56 ], [ %r554, %bb64 ]
  %r307 = add i32 %r529, 0
  %r308 = add i32 %r511, 0
  %r309 = mul i32 %r529, %r511
  %r310 = add i32 %r530, 0
  %r311 = add i32 %r309, %r530
  %r535 = add i32 %r311, 0
  %r312 = add i32 %r535, 0
  %r313 = getelementptr i32, i32* %r249, i32 %r535
  %r314 = add i32 %r534, 0
  store i32 %r314, i32* %r313
  %r315 = add i32 %r530, 0
  %r316 = add i32 %r530, 1
  %r536 = add i32 %r316, 0
  %r317 = add i32 %r536, 0
  %r318 = add i32 %r511, 0
  %r319 = icmp sge i32 %r536, %r511
  br i1 %r319, label %bb66, label %bb67

bb66:
  %r537 = phi i32 [ %r529, %bb58 ]
  %r538 = phi i32 [ %r536, %bb58 ]
  %r539 = phi i32 [ %r535, %bb58 ]
  %r540 = phi i32 [ %r532, %bb58 ]
  %r541 = phi i32 [ %r533, %bb58 ]
  %r542 = phi i32 [ %r534, %bb58 ]
  br label %bb55

bb67:
  %r523 = phi i32 [ %r529, %bb58 ]
  %r524 = phi i32 [ %r536, %bb58 ]
  %r525 = phi i32 [ %r535, %bb58 ]
  %r526 = phi i32 [ %r532, %bb58 ]
  %r527 = phi i32 [ %r533, %bb58 ]
  %r528 = phi i32 [ %r534, %bb58 ]
  br label %bb53

bb55:
  %r632 = phi i32 [ %r581, %bb53 ], [ %r537, %bb66 ]
  %r633 = phi i32 [ %r582, %bb53 ], [ %r538, %bb66 ]
  %r634 = phi i32 [ %r583, %bb53 ], [ %r539, %bb66 ]
  %r635 = phi i32 [ %r584, %bb53 ], [ %r540, %bb66 ]
  %r636 = phi i32 [ %r585, %bb53 ], [ %r541, %bb66 ]
  %r637 = phi i32 [ %r586, %bb53 ], [ %r542, %bb66 ]
  %r320 = add i32 %r632, 0
  %r321 = add i32 %r632, 1
  %r638 = add i32 %r321, 0
  %r322 = add i32 %r638, 0
  %r323 = add i32 %r509, 0
  %r324 = icmp sge i32 %r638, %r509
  br i1 %r324, label %bb68, label %bb69

bb68:
  %r587 = phi i32 [ %r638, %bb55 ]
  %r588 = phi i32 [ %r633, %bb55 ]
  %r589 = phi i32 [ %r634, %bb55 ]
  %r590 = phi i32 [ %r635, %bb55 ]
  %r591 = phi i32 [ %r636, %bb55 ]
  %r592 = phi i32 [ %r637, %bb55 ]
  br label %bb52

bb69:
  %r593 = phi i32 [ %r638, %bb55 ]
  %r594 = phi i32 [ %r633, %bb55 ]
  %r595 = phi i32 [ %r634, %bb55 ]
  %r596 = phi i32 [ %r635, %bb55 ]
  %r597 = phi i32 [ %r636, %bb55 ]
  %r598 = phi i32 [ %r637, %bb55 ]
  br label %bb50

bb52:
  %r599 = phi i32 [ %r568, %bb50 ], [ %r587, %bb68 ]
  %r600 = phi i32 [ %r569, %bb50 ], [ %r588, %bb68 ]
  %r601 = phi i32 [ %r570, %bb50 ], [ %r589, %bb68 ]
  %r602 = phi i32 [ %r571, %bb50 ], [ %r590, %bb68 ]
  %r603 = phi i32 [ %r572, %bb50 ], [ %r591, %bb68 ]
  %r604 = phi i32 [ %r573, %bb50 ], [ %r592, %bb68 ]
  ret i32 0
}

define void @memmove( i32* %r325, i32* %r326, i32 %r327 ) {
bb70:
  %r655 = add i32 0, 0
  %r656 = add i32 %r327, 0
  %r657 = add i32 0, 0
  %r658 = add i32 0, 0
  br label %bb71

bb71:
  %r662 = phi i32 [ %r658, %bb70 ], [ %r661, %bb72 ]
  %r330 = add i32 %r662, 0
  %r331 = add i32 %r656, 0
  %r332 = icmp slt i32 %r662, %r656
  br i1 %r332, label %bb72, label %bb73

bb72:
  %r660 = phi i32 [ %r662, %bb71 ]
  %r333 = add i32 %r660, 0
  %r334 = getelementptr i32, i32* %r325, i32 %r660
  %r335 = add i32 %r660, 0
  %r336 = getelementptr i32, i32* %r326, i32 %r660
  %r337 = load i32, i32* %r336
  store i32 %r337, i32* %r334
  %r338 = add i32 %r660, 0
  %r339 = add i32 %r660, 1
  %r661 = add i32 %r339, 0
  br label %bb71

bb73:
  %r659 = phi i32 [ %r662, %bb71 ]
  ret void
}

define i32 @main( ) {
bb74:
  %r670 = add i32 0, 0
  %r671 = add i32 0, 0
  %r672 = add i32 0, 0
  %r341 = call i32 @getint()
  %r673 = add i32 %r341, 0
  %r674 = add i32 0, 0
  %r343 = call i32 @getint()
  %r675 = add i32 %r343, 0
  %r676 = add i32 0, 0
  %r345 = call i32 @getint()
  %r677 = add i32 %r345, 0
  %r678 = add i32 0, 0
  %r347 = call i32 @getint()
  %r679 = add i32 %r347, 0
  %r680 = add i32 0, 0
  %r681 = add i32 0, 0
  br label %bb75

bb75:
  %r709 = phi i32 [ %r681, %bb74 ], [ %r708, %bb76 ]
  %r349 = add i32 %r709, 0
  %r350 = add i32 %r679, 0
  %r351 = icmp slt i32 %r709, %r679
  br i1 %r351, label %bb76, label %bb77

bb76:
  %r707 = phi i32 [ %r709, %bb75 ]
  %r352 = add i32 %r707, 0
  %r353 = getelementptr [10000000 x i32 ], [10000000 x i32 ]* @a, i32 0, i32 %r707
  %r354 = call i32 @getint()
  store i32 %r354, i32* %r353
  %r355 = add i32 %r707, 0
  %r356 = add i32 %r707, 1
  %r708 = add i32 %r356, 0
  br label %bb75

bb77:
  %r700 = phi i32 [ %r709, %bb75 ]
  %r357 = call i32 @getint()
  %r701 = add i32 %r357, 0
  %r702 = add i32 0, 0
  br label %bb78

bb78:
  %r694 = phi i32 [ %r702, %bb77 ], [ %r693, %bb79 ]
  %r695 = phi i32 [ %r701, %bb77 ], [ %r692, %bb79 ]
  %r358 = add i32 %r694, 0
  %r359 = add i32 %r695, 0
  %r360 = icmp slt i32 %r694, %r695
  br i1 %r360, label %bb79, label %bb80

bb79:
  %r691 = phi i32 [ %r694, %bb78 ]
  %r692 = phi i32 [ %r695, %bb78 ]
  %r361 = add i32 %r691, 0
  %r362 = getelementptr [10000 x i32 ], [10000 x i32 ]* @kernelid, i32 0, i32 %r691
  %r363 = call i32 @getint()
  store i32 %r363, i32* %r362
  %r364 = add i32 %r691, 0
  %r365 = add i32 %r691, 1
  %r693 = add i32 %r365, 0
  br label %bb78

bb80:
  %r696 = phi i32 [ %r694, %bb78 ]
  %r697 = phi i32 [ %r695, %bb78 ]
  %r367 = add i32 %r697, 0
  %r698 = add i32 %r697, 0
  call void @_sysy_starttime(i32 209)
  %r699 = add i32 0, 0
  br label %bb81

bb81:
  %r703 = phi i32 [ %r699, %bb80 ], [ %r690, %bb82 ]
  %r704 = phi i32 [ %r696, %bb80 ], [ %r687, %bb82 ]
  %r705 = phi i32 [ %r698, %bb80 ], [ %r688, %bb82 ]
  %r706 = phi i32 [ %r697, %bb80 ], [ %r689, %bb82 ]
  %r369 = add i32 %r703, 0
  %r370 = add i32 %r705, 0
  %r371 = icmp slt i32 %r703, %r705
  br i1 %r371, label %bb82, label %bb83

bb82:
  %r686 = phi i32 [ %r703, %bb81 ]
  %r687 = phi i32 [ %r704, %bb81 ]
  %r688 = phi i32 [ %r705, %bb81 ]
  %r689 = phi i32 [ %r706, %bb81 ]
  %r372 = add i32 %r686, 0
  %r373 = getelementptr [10000 x i32 ], [10000 x i32 ]* @kernelid, i32 0, i32 %r686
  %r374 = load i32, i32* %r373
  %r375 = add i32 %r675, 0
  %r376 = add i32 %r677, 0
  %r377 = add i32 %r673, 0
  call void @convn(i32 %r374, i32* @a, i32* @b, i32 %r675, i32 %r677, i32 %r673)
  %r378 = add i32 %r675, 0
  %r379 = add i32 %r677, 0
  %r380 = mul i32 %r675, %r677
  call void @memmove(i32* @a, i32* @b, i32 %r380)
  %r381 = add i32 %r686, 0
  %r382 = add i32 %r686, 1
  %r690 = add i32 %r382, 0
  br label %bb81

bb83:
  %r682 = phi i32 [ %r703, %bb81 ]
  %r683 = phi i32 [ %r704, %bb81 ]
  %r684 = phi i32 [ %r705, %bb81 ]
  %r685 = phi i32 [ %r706, %bb81 ]
  call void @_sysy_stoptime(i32 312)
  %r383 = add i32 %r675, 0
  %r384 = add i32 %r677, 0
  %r385 = mul i32 %r675, %r677
  call void @putarray(i32 %r385, i32* @a)
  ret i32 0
}

