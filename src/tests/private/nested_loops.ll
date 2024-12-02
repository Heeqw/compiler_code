declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
%my_struct_1 = type { [7 x i32 ] }
%my_struct_2 = type { [8 x %my_struct_1 ] }
%my_struct_3 = type { [5 x %my_struct_2 ] }
%my_struct_4 = type { [4 x %my_struct_3 ] }
%my_struct_5 = type { [3 x %my_struct_4 ] }
%my_struct_6 = type { [2 x %my_struct_5 ] }
@arr1 = global [ 10 x %my_struct_6 ] zeroinitializer
@arr2 = global [ 10 x %my_struct_6 ] zeroinitializer
define i32 @loop1( i32 %r100, i32 %r102 ) {
bb1:
  %r401 = add i32 0, 0
  %r402 = add i32 %r100, 0
  %r403 = add i32 0, 0
  %r404 = add i32 %r102, 0
  %r405 = add i32 0, 0
  %r406 = add i32 0, 0
  %r407 = add i32 0, 0
  %r408 = add i32 0, 0
  %r409 = add i32 0, 0
  %r410 = add i32 0, 0
  %r411 = add i32 0, 0
  %r412 = add i32 0, 0
  br label %bb2

bb2:
  %r550 = phi i32 [ %r411, %bb1 ], [ %r564, %bb8 ]
  %r551 = phi i32 [ %r410, %bb1 ], [ %r565, %bb8 ]
  %r552 = phi i32 [ %r407, %bb1 ], [ %r566, %bb8 ]
  %r553 = phi i32 [ %r409, %bb1 ], [ %r567, %bb8 ]
  %r554 = phi i32 [ %r406, %bb1 ], [ %r568, %bb8 ]
  %r555 = phi i32 [ %r408, %bb1 ], [ %r569, %bb8 ]
  %r556 = phi i32 [ %r412, %bb1 ], [ %r571, %bb8 ]
  %r111 = add i32 %r556, 0
  %r112 = add i32 %r402, 0
  %r113 = icmp slt i32 %r556, %r402
  br i1 %r113, label %bb5, label %bb4

bb5:
  %r488 = phi i32 [ %r550, %bb2 ]
  %r489 = phi i32 [ %r551, %bb2 ]
  %r490 = phi i32 [ %r552, %bb2 ]
  %r491 = phi i32 [ %r553, %bb2 ]
  %r492 = phi i32 [ %r554, %bb2 ]
  %r493 = phi i32 [ %r555, %bb2 ]
  %r494 = phi i32 [ %r556, %bb2 ]
  %r114 = add i32 %r494, 0
  %r115 = add i32 %r404, 0
  %r116 = icmp slt i32 %r494, %r404
  br i1 %r116, label %bb3, label %bb4

bb3:
  %r450 = phi i32 [ %r488, %bb5 ]
  %r451 = phi i32 [ %r489, %bb5 ]
  %r452 = phi i32 [ %r490, %bb5 ]
  %r453 = phi i32 [ %r491, %bb5 ]
  %r454 = phi i32 [ %r492, %bb5 ]
  %r455 = phi i32 [ %r493, %bb5 ]
  %r456 = phi i32 [ %r494, %bb5 ]
  %r457 = add i32 0, 0
  br label %bb6

bb6:
  %r436 = phi i32 [ %r450, %bb3 ], [ %r510, %bb11 ]
  %r437 = phi i32 [ %r451, %bb3 ], [ %r511, %bb11 ]
  %r438 = phi i32 [ %r452, %bb3 ], [ %r512, %bb11 ]
  %r439 = phi i32 [ %r453, %bb3 ], [ %r513, %bb11 ]
  %r440 = phi i32 [ %r457, %bb3 ], [ %r517, %bb11 ]
  %r441 = phi i32 [ %r455, %bb3 ], [ %r515, %bb11 ]
  %r442 = phi i32 [ %r456, %bb3 ], [ %r516, %bb11 ]
  %r117 = add i32 %r440, 0
  %r118 = icmp slt i32 %r440, 2
  br i1 %r118, label %bb7, label %bb8

bb7:
  %r428 = phi i32 [ %r436, %bb6 ]
  %r429 = phi i32 [ %r437, %bb6 ]
  %r430 = phi i32 [ %r438, %bb6 ]
  %r431 = phi i32 [ %r439, %bb6 ]
  %r432 = phi i32 [ %r440, %bb6 ]
  %r433 = phi i32 [ %r441, %bb6 ]
  %r434 = phi i32 [ %r442, %bb6 ]
  %r435 = add i32 0, 0
  br label %bb9

bb9:
  %r413 = phi i32 [ %r428, %bb7 ], [ %r518, %bb14 ]
  %r414 = phi i32 [ %r429, %bb7 ], [ %r519, %bb14 ]
  %r415 = phi i32 [ %r435, %bb7 ], [ %r525, %bb14 ]
  %r416 = phi i32 [ %r431, %bb7 ], [ %r521, %bb14 ]
  %r417 = phi i32 [ %r432, %bb7 ], [ %r522, %bb14 ]
  %r418 = phi i32 [ %r433, %bb7 ], [ %r523, %bb14 ]
  %r419 = phi i32 [ %r434, %bb7 ], [ %r524, %bb14 ]
  %r119 = add i32 %r415, 0
  %r120 = icmp slt i32 %r415, 3
  br i1 %r120, label %bb10, label %bb11

bb10:
  %r572 = phi i32 [ %r413, %bb9 ]
  %r573 = phi i32 [ %r414, %bb9 ]
  %r574 = phi i32 [ %r415, %bb9 ]
  %r575 = phi i32 [ %r416, %bb9 ]
  %r576 = phi i32 [ %r417, %bb9 ]
  %r577 = phi i32 [ %r418, %bb9 ]
  %r578 = phi i32 [ %r419, %bb9 ]
  %r579 = add i32 0, 0
  br label %bb12

bb12:
  %r557 = phi i32 [ %r572, %bb10 ], [ %r526, %bb17 ]
  %r558 = phi i32 [ %r573, %bb10 ], [ %r527, %bb17 ]
  %r559 = phi i32 [ %r574, %bb10 ], [ %r528, %bb17 ]
  %r560 = phi i32 [ %r575, %bb10 ], [ %r529, %bb17 ]
  %r561 = phi i32 [ %r576, %bb10 ], [ %r530, %bb17 ]
  %r562 = phi i32 [ %r579, %bb10 ], [ %r533, %bb17 ]
  %r563 = phi i32 [ %r578, %bb10 ], [ %r532, %bb17 ]
  %r121 = add i32 %r562, 0
  %r122 = icmp slt i32 %r562, 4
  br i1 %r122, label %bb13, label %bb14

bb13:
  %r542 = phi i32 [ %r557, %bb12 ]
  %r543 = phi i32 [ %r558, %bb12 ]
  %r544 = phi i32 [ %r559, %bb12 ]
  %r545 = phi i32 [ %r560, %bb12 ]
  %r546 = phi i32 [ %r561, %bb12 ]
  %r547 = phi i32 [ %r562, %bb12 ]
  %r548 = phi i32 [ %r563, %bb12 ]
  %r549 = add i32 0, 0
  br label %bb15

bb15:
  %r443 = phi i32 [ %r542, %bb13 ], [ %r534, %bb20 ]
  %r444 = phi i32 [ %r543, %bb13 ], [ %r535, %bb20 ]
  %r445 = phi i32 [ %r544, %bb13 ], [ %r536, %bb20 ]
  %r446 = phi i32 [ %r549, %bb13 ], [ %r541, %bb20 ]
  %r447 = phi i32 [ %r546, %bb13 ], [ %r538, %bb20 ]
  %r448 = phi i32 [ %r547, %bb13 ], [ %r539, %bb20 ]
  %r449 = phi i32 [ %r548, %bb13 ], [ %r540, %bb20 ]
  %r123 = add i32 %r446, 0
  %r124 = icmp slt i32 %r446, 5
  br i1 %r124, label %bb16, label %bb17

bb16:
  %r495 = phi i32 [ %r443, %bb15 ]
  %r496 = phi i32 [ %r444, %bb15 ]
  %r497 = phi i32 [ %r445, %bb15 ]
  %r498 = phi i32 [ %r446, %bb15 ]
  %r499 = phi i32 [ %r447, %bb15 ]
  %r500 = phi i32 [ %r448, %bb15 ]
  %r501 = phi i32 [ %r449, %bb15 ]
  %r502 = add i32 0, 0
  br label %bb18

bb18:
  %r481 = phi i32 [ %r495, %bb16 ], [ %r458, %bb23 ]
  %r482 = phi i32 [ %r502, %bb16 ], [ %r465, %bb23 ]
  %r483 = phi i32 [ %r497, %bb16 ], [ %r460, %bb23 ]
  %r484 = phi i32 [ %r498, %bb16 ], [ %r461, %bb23 ]
  %r485 = phi i32 [ %r499, %bb16 ], [ %r462, %bb23 ]
  %r486 = phi i32 [ %r500, %bb16 ], [ %r463, %bb23 ]
  %r487 = phi i32 [ %r501, %bb16 ], [ %r464, %bb23 ]
  %r125 = add i32 %r482, 0
  %r126 = icmp slt i32 %r482, 6
  br i1 %r126, label %bb19, label %bb20

bb19:
  %r466 = phi i32 [ %r481, %bb18 ]
  %r467 = phi i32 [ %r482, %bb18 ]
  %r468 = phi i32 [ %r483, %bb18 ]
  %r469 = phi i32 [ %r484, %bb18 ]
  %r470 = phi i32 [ %r485, %bb18 ]
  %r471 = phi i32 [ %r486, %bb18 ]
  %r472 = phi i32 [ %r487, %bb18 ]
  %r473 = add i32 0, 0
  br label %bb21

bb21:
  %r474 = phi i32 [ %r473, %bb19 ], [ %r427, %bb22 ]
  %r475 = phi i32 [ %r467, %bb19 ], [ %r421, %bb22 ]
  %r476 = phi i32 [ %r468, %bb19 ], [ %r422, %bb22 ]
  %r477 = phi i32 [ %r469, %bb19 ], [ %r423, %bb22 ]
  %r478 = phi i32 [ %r470, %bb19 ], [ %r424, %bb22 ]
  %r479 = phi i32 [ %r471, %bb19 ], [ %r425, %bb22 ]
  %r480 = phi i32 [ %r472, %bb19 ], [ %r426, %bb22 ]
  %r127 = add i32 %r474, 0
  %r128 = icmp slt i32 %r474, 2
  br i1 %r128, label %bb22, label %bb23

bb22:
  %r420 = phi i32 [ %r474, %bb21 ]
  %r421 = phi i32 [ %r475, %bb21 ]
  %r422 = phi i32 [ %r476, %bb21 ]
  %r423 = phi i32 [ %r477, %bb21 ]
  %r424 = phi i32 [ %r478, %bb21 ]
  %r425 = phi i32 [ %r479, %bb21 ]
  %r426 = phi i32 [ %r480, %bb21 ]
  %r129 = add i32 %r426, 0
  %r130 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* @arr1, i32 0, i32 %r426
  %r131 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* %r130, i32 0, i32 0
  %r132 = add i32 %r424, 0
  %r133 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r131, i32 0, i32 %r424
  %r134 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r133, i32 0, i32 0
  %r135 = add i32 %r422, 0
  %r136 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r134, i32 0, i32 %r422
  %r137 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r136, i32 0, i32 0
  %r138 = add i32 %r425, 0
  %r139 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r137, i32 0, i32 %r425
  %r140 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r139, i32 0, i32 0
  %r141 = add i32 %r423, 0
  %r142 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r140, i32 0, i32 %r423
  %r143 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r142, i32 0, i32 0
  %r144 = add i32 %r421, 0
  %r145 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r143, i32 0, i32 %r421
  %r146 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r145, i32 0, i32 0
  %r147 = add i32 %r420, 0
  %r148 = getelementptr [7 x i32 ], [7 x i32 ]* %r146, i32 0, i32 %r420
  %r149 = add i32 %r426, 0
  %r150 = add i32 %r424, 0
  %r151 = add i32 %r426, %r424
  %r152 = add i32 %r422, 0
  %r153 = add i32 %r151, %r422
  %r154 = add i32 %r425, 0
  %r155 = add i32 %r153, %r425
  %r156 = add i32 %r423, 0
  %r157 = add i32 %r155, %r423
  %r158 = add i32 %r421, 0
  %r159 = add i32 %r157, %r421
  %r160 = add i32 %r420, 0
  %r161 = add i32 %r159, %r420
  %r162 = add i32 %r402, 0
  %r163 = add i32 %r161, %r402
  %r164 = add i32 %r404, 0
  %r165 = add i32 %r163, %r404
  store i32 %r165, i32* %r148
  %r166 = add i32 %r420, 0
  %r167 = add i32 %r420, 1
  %r427 = add i32 %r167, 0
  br label %bb21

bb23:
  %r458 = phi i32 [ %r474, %bb21 ]
  %r459 = phi i32 [ %r475, %bb21 ]
  %r460 = phi i32 [ %r476, %bb21 ]
  %r461 = phi i32 [ %r477, %bb21 ]
  %r462 = phi i32 [ %r478, %bb21 ]
  %r463 = phi i32 [ %r479, %bb21 ]
  %r464 = phi i32 [ %r480, %bb21 ]
  %r168 = add i32 %r459, 0
  %r169 = add i32 %r459, 1
  %r465 = add i32 %r169, 0
  br label %bb18

bb20:
  %r534 = phi i32 [ %r481, %bb18 ]
  %r535 = phi i32 [ %r482, %bb18 ]
  %r536 = phi i32 [ %r483, %bb18 ]
  %r537 = phi i32 [ %r484, %bb18 ]
  %r538 = phi i32 [ %r485, %bb18 ]
  %r539 = phi i32 [ %r486, %bb18 ]
  %r540 = phi i32 [ %r487, %bb18 ]
  %r170 = add i32 %r537, 0
  %r171 = add i32 %r537, 1
  %r541 = add i32 %r171, 0
  br label %bb15

bb17:
  %r526 = phi i32 [ %r443, %bb15 ]
  %r527 = phi i32 [ %r444, %bb15 ]
  %r528 = phi i32 [ %r445, %bb15 ]
  %r529 = phi i32 [ %r446, %bb15 ]
  %r530 = phi i32 [ %r447, %bb15 ]
  %r531 = phi i32 [ %r448, %bb15 ]
  %r532 = phi i32 [ %r449, %bb15 ]
  %r172 = add i32 %r531, 0
  %r173 = add i32 %r531, 1
  %r533 = add i32 %r173, 0
  br label %bb12

bb14:
  %r518 = phi i32 [ %r557, %bb12 ]
  %r519 = phi i32 [ %r558, %bb12 ]
  %r520 = phi i32 [ %r559, %bb12 ]
  %r521 = phi i32 [ %r560, %bb12 ]
  %r522 = phi i32 [ %r561, %bb12 ]
  %r523 = phi i32 [ %r562, %bb12 ]
  %r524 = phi i32 [ %r563, %bb12 ]
  %r174 = add i32 %r520, 0
  %r175 = add i32 %r520, 1
  %r525 = add i32 %r175, 0
  br label %bb9

bb11:
  %r510 = phi i32 [ %r413, %bb9 ]
  %r511 = phi i32 [ %r414, %bb9 ]
  %r512 = phi i32 [ %r415, %bb9 ]
  %r513 = phi i32 [ %r416, %bb9 ]
  %r514 = phi i32 [ %r417, %bb9 ]
  %r515 = phi i32 [ %r418, %bb9 ]
  %r516 = phi i32 [ %r419, %bb9 ]
  %r176 = add i32 %r514, 0
  %r177 = add i32 %r514, 1
  %r517 = add i32 %r177, 0
  br label %bb6

bb8:
  %r564 = phi i32 [ %r436, %bb6 ]
  %r565 = phi i32 [ %r437, %bb6 ]
  %r566 = phi i32 [ %r438, %bb6 ]
  %r567 = phi i32 [ %r439, %bb6 ]
  %r568 = phi i32 [ %r440, %bb6 ]
  %r569 = phi i32 [ %r441, %bb6 ]
  %r570 = phi i32 [ %r442, %bb6 ]
  %r178 = add i32 %r570, 0
  %r179 = add i32 %r570, 1
  %r571 = add i32 %r179, 0
  br label %bb2

bb4:
  %r503 = phi i32 [ %r550, %bb2 ], [ %r488, %bb5 ]
  %r504 = phi i32 [ %r551, %bb2 ], [ %r489, %bb5 ]
  %r505 = phi i32 [ %r552, %bb2 ], [ %r490, %bb5 ]
  %r506 = phi i32 [ %r553, %bb2 ], [ %r491, %bb5 ]
  %r507 = phi i32 [ %r554, %bb2 ], [ %r492, %bb5 ]
  %r508 = phi i32 [ %r555, %bb2 ], [ %r493, %bb5 ]
  %r509 = phi i32 [ %r556, %bb2 ], [ %r494, %bb5 ]
  ret i32 0
}

define i32 @loop2( ) {
bb24:
  %r587 = add i32 0, 0
  %r588 = add i32 0, 0
  %r589 = add i32 0, 0
  %r590 = add i32 0, 0
  %r591 = add i32 0, 0
  %r592 = add i32 0, 0
  %r593 = add i32 0, 0
  %r594 = add i32 0, 0
  br label %bb25

bb25:
  %r672 = phi i32 [ %r594, %bb24 ], [ %r609, %bb30 ]
  %r673 = phi i32 [ %r591, %bb24 ], [ %r603, %bb30 ]
  %r674 = phi i32 [ %r593, %bb24 ], [ %r604, %bb30 ]
  %r675 = phi i32 [ %r590, %bb24 ], [ %r605, %bb30 ]
  %r676 = phi i32 [ %r589, %bb24 ], [ %r606, %bb30 ]
  %r677 = phi i32 [ %r592, %bb24 ], [ %r607, %bb30 ]
  %r678 = phi i32 [ %r588, %bb24 ], [ %r608, %bb30 ]
  %r187 = add i32 %r672, 0
  %r188 = icmp slt i32 %r672, 10
  br i1 %r188, label %bb26, label %bb27

bb26:
  %r686 = phi i32 [ %r672, %bb25 ]
  %r687 = phi i32 [ %r673, %bb25 ]
  %r688 = phi i32 [ %r674, %bb25 ]
  %r689 = phi i32 [ %r675, %bb25 ]
  %r690 = phi i32 [ %r676, %bb25 ]
  %r691 = phi i32 [ %r677, %bb25 ]
  %r692 = phi i32 [ %r678, %bb25 ]
  %r693 = add i32 0, 0
  br label %bb28

bb28:
  %r657 = phi i32 [ %r686, %bb26 ], [ %r610, %bb33 ]
  %r658 = phi i32 [ %r687, %bb26 ], [ %r611, %bb33 ]
  %r659 = phi i32 [ %r688, %bb26 ], [ %r612, %bb33 ]
  %r660 = phi i32 [ %r689, %bb26 ], [ %r613, %bb33 ]
  %r661 = phi i32 [ %r690, %bb26 ], [ %r614, %bb33 ]
  %r662 = phi i32 [ %r691, %bb26 ], [ %r615, %bb33 ]
  %r663 = phi i32 [ %r693, %bb26 ], [ %r617, %bb33 ]
  %r189 = add i32 %r663, 0
  %r190 = icmp slt i32 %r663, 2
  br i1 %r190, label %bb29, label %bb30

bb29:
  %r701 = phi i32 [ %r657, %bb28 ]
  %r702 = phi i32 [ %r658, %bb28 ]
  %r703 = phi i32 [ %r659, %bb28 ]
  %r704 = phi i32 [ %r660, %bb28 ]
  %r705 = phi i32 [ %r661, %bb28 ]
  %r706 = phi i32 [ %r662, %bb28 ]
  %r707 = phi i32 [ %r663, %bb28 ]
  %r708 = add i32 0, 0
  br label %bb31

bb31:
  %r709 = phi i32 [ %r701, %bb29 ], [ %r634, %bb36 ]
  %r710 = phi i32 [ %r702, %bb29 ], [ %r635, %bb36 ]
  %r711 = phi i32 [ %r703, %bb29 ], [ %r636, %bb36 ]
  %r712 = phi i32 [ %r704, %bb29 ], [ %r637, %bb36 ]
  %r713 = phi i32 [ %r708, %bb29 ], [ %r641, %bb36 ]
  %r714 = phi i32 [ %r706, %bb29 ], [ %r639, %bb36 ]
  %r715 = phi i32 [ %r707, %bb29 ], [ %r640, %bb36 ]
  %r191 = add i32 %r713, 0
  %r192 = icmp slt i32 %r713, 3
  br i1 %r192, label %bb32, label %bb33

bb32:
  %r664 = phi i32 [ %r709, %bb31 ]
  %r665 = phi i32 [ %r710, %bb31 ]
  %r666 = phi i32 [ %r711, %bb31 ]
  %r667 = phi i32 [ %r712, %bb31 ]
  %r668 = phi i32 [ %r713, %bb31 ]
  %r669 = phi i32 [ %r714, %bb31 ]
  %r670 = phi i32 [ %r715, %bb31 ]
  %r671 = add i32 0, 0
  br label %bb34

bb34:
  %r679 = phi i32 [ %r664, %bb32 ], [ %r732, %bb39 ]
  %r680 = phi i32 [ %r665, %bb32 ], [ %r733, %bb39 ]
  %r681 = phi i32 [ %r666, %bb32 ], [ %r734, %bb39 ]
  %r682 = phi i32 [ %r671, %bb32 ], [ %r739, %bb39 ]
  %r683 = phi i32 [ %r668, %bb32 ], [ %r736, %bb39 ]
  %r684 = phi i32 [ %r669, %bb32 ], [ %r737, %bb39 ]
  %r685 = phi i32 [ %r670, %bb32 ], [ %r738, %bb39 ]
  %r193 = add i32 %r682, 0
  %r194 = icmp slt i32 %r682, 2
  br i1 %r194, label %bb35, label %bb36

bb35:
  %r724 = phi i32 [ %r679, %bb34 ]
  %r725 = phi i32 [ %r680, %bb34 ]
  %r726 = phi i32 [ %r681, %bb34 ]
  %r727 = phi i32 [ %r682, %bb34 ]
  %r728 = phi i32 [ %r683, %bb34 ]
  %r729 = phi i32 [ %r684, %bb34 ]
  %r730 = phi i32 [ %r685, %bb34 ]
  %r731 = add i32 0, 0
  br label %bb37

bb37:
  %r740 = phi i32 [ %r724, %bb35 ], [ %r716, %bb42 ]
  %r741 = phi i32 [ %r731, %bb35 ], [ %r723, %bb42 ]
  %r742 = phi i32 [ %r726, %bb35 ], [ %r718, %bb42 ]
  %r743 = phi i32 [ %r727, %bb35 ], [ %r719, %bb42 ]
  %r744 = phi i32 [ %r728, %bb35 ], [ %r720, %bb42 ]
  %r745 = phi i32 [ %r729, %bb35 ], [ %r721, %bb42 ]
  %r746 = phi i32 [ %r730, %bb35 ], [ %r722, %bb42 ]
  %r195 = add i32 %r741, 0
  %r196 = icmp slt i32 %r741, 4
  br i1 %r196, label %bb38, label %bb39

bb38:
  %r747 = phi i32 [ %r740, %bb37 ]
  %r748 = phi i32 [ %r741, %bb37 ]
  %r749 = phi i32 [ %r742, %bb37 ]
  %r750 = phi i32 [ %r743, %bb37 ]
  %r751 = phi i32 [ %r744, %bb37 ]
  %r752 = phi i32 [ %r745, %bb37 ]
  %r753 = phi i32 [ %r746, %bb37 ]
  %r754 = add i32 0, 0
  br label %bb40

bb40:
  %r694 = phi i32 [ %r747, %bb38 ], [ %r618, %bb45 ]
  %r695 = phi i32 [ %r748, %bb38 ], [ %r619, %bb45 ]
  %r696 = phi i32 [ %r749, %bb38 ], [ %r620, %bb45 ]
  %r697 = phi i32 [ %r750, %bb38 ], [ %r621, %bb45 ]
  %r698 = phi i32 [ %r751, %bb38 ], [ %r622, %bb45 ]
  %r699 = phi i32 [ %r754, %bb38 ], [ %r625, %bb45 ]
  %r700 = phi i32 [ %r753, %bb38 ], [ %r624, %bb45 ]
  %r197 = add i32 %r699, 0
  %r198 = icmp slt i32 %r699, 8
  br i1 %r198, label %bb41, label %bb42

bb41:
  %r649 = phi i32 [ %r694, %bb40 ]
  %r650 = phi i32 [ %r695, %bb40 ]
  %r651 = phi i32 [ %r696, %bb40 ]
  %r652 = phi i32 [ %r697, %bb40 ]
  %r653 = phi i32 [ %r698, %bb40 ]
  %r654 = phi i32 [ %r699, %bb40 ]
  %r655 = phi i32 [ %r700, %bb40 ]
  %r656 = add i32 0, 0
  br label %bb43

bb43:
  %r642 = phi i32 [ %r649, %bb41 ], [ %r626, %bb44 ]
  %r643 = phi i32 [ %r650, %bb41 ], [ %r627, %bb44 ]
  %r644 = phi i32 [ %r656, %bb41 ], [ %r633, %bb44 ]
  %r645 = phi i32 [ %r652, %bb41 ], [ %r629, %bb44 ]
  %r646 = phi i32 [ %r653, %bb41 ], [ %r630, %bb44 ]
  %r647 = phi i32 [ %r654, %bb41 ], [ %r631, %bb44 ]
  %r648 = phi i32 [ %r655, %bb41 ], [ %r632, %bb44 ]
  %r199 = add i32 %r644, 0
  %r200 = icmp slt i32 %r644, 7
  br i1 %r200, label %bb44, label %bb45

bb44:
  %r626 = phi i32 [ %r642, %bb43 ]
  %r627 = phi i32 [ %r643, %bb43 ]
  %r628 = phi i32 [ %r644, %bb43 ]
  %r629 = phi i32 [ %r645, %bb43 ]
  %r630 = phi i32 [ %r646, %bb43 ]
  %r631 = phi i32 [ %r647, %bb43 ]
  %r632 = phi i32 [ %r648, %bb43 ]
  %r201 = add i32 %r626, 0
  %r202 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* @arr2, i32 0, i32 %r626
  %r203 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* %r202, i32 0, i32 0
  %r204 = add i32 %r632, 0
  %r205 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r203, i32 0, i32 %r632
  %r206 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r205, i32 0, i32 0
  %r207 = add i32 %r630, 0
  %r208 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r206, i32 0, i32 %r630
  %r209 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r208, i32 0, i32 0
  %r210 = add i32 %r629, 0
  %r211 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r209, i32 0, i32 %r629
  %r212 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r211, i32 0, i32 0
  %r213 = add i32 %r627, 0
  %r214 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r212, i32 0, i32 %r627
  %r215 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r214, i32 0, i32 0
  %r216 = add i32 %r631, 0
  %r217 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r215, i32 0, i32 %r631
  %r218 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r217, i32 0, i32 0
  %r219 = add i32 %r628, 0
  %r220 = getelementptr [7 x i32 ], [7 x i32 ]* %r218, i32 0, i32 %r628
  %r221 = add i32 %r626, 0
  %r222 = add i32 %r632, 0
  %r223 = add i32 %r626, %r632
  %r224 = add i32 %r629, 0
  %r225 = add i32 %r223, %r629
  %r226 = add i32 %r628, 0
  %r227 = add i32 %r225, %r628
  store i32 %r227, i32* %r220
  %r228 = add i32 %r628, 0
  %r229 = add i32 %r628, 1
  %r633 = add i32 %r229, 0
  br label %bb43

bb45:
  %r618 = phi i32 [ %r642, %bb43 ]
  %r619 = phi i32 [ %r643, %bb43 ]
  %r620 = phi i32 [ %r644, %bb43 ]
  %r621 = phi i32 [ %r645, %bb43 ]
  %r622 = phi i32 [ %r646, %bb43 ]
  %r623 = phi i32 [ %r647, %bb43 ]
  %r624 = phi i32 [ %r648, %bb43 ]
  %r230 = add i32 %r623, 0
  %r231 = add i32 %r623, 1
  %r625 = add i32 %r231, 0
  br label %bb40

bb42:
  %r716 = phi i32 [ %r694, %bb40 ]
  %r717 = phi i32 [ %r695, %bb40 ]
  %r718 = phi i32 [ %r696, %bb40 ]
  %r719 = phi i32 [ %r697, %bb40 ]
  %r720 = phi i32 [ %r698, %bb40 ]
  %r721 = phi i32 [ %r699, %bb40 ]
  %r722 = phi i32 [ %r700, %bb40 ]
  %r232 = add i32 %r717, 0
  %r233 = add i32 %r717, 1
  %r723 = add i32 %r233, 0
  br label %bb37

bb39:
  %r732 = phi i32 [ %r740, %bb37 ]
  %r733 = phi i32 [ %r741, %bb37 ]
  %r734 = phi i32 [ %r742, %bb37 ]
  %r735 = phi i32 [ %r743, %bb37 ]
  %r736 = phi i32 [ %r744, %bb37 ]
  %r737 = phi i32 [ %r745, %bb37 ]
  %r738 = phi i32 [ %r746, %bb37 ]
  %r234 = add i32 %r735, 0
  %r235 = add i32 %r735, 1
  %r739 = add i32 %r235, 0
  br label %bb34

bb36:
  %r634 = phi i32 [ %r679, %bb34 ]
  %r635 = phi i32 [ %r680, %bb34 ]
  %r636 = phi i32 [ %r681, %bb34 ]
  %r637 = phi i32 [ %r682, %bb34 ]
  %r638 = phi i32 [ %r683, %bb34 ]
  %r639 = phi i32 [ %r684, %bb34 ]
  %r640 = phi i32 [ %r685, %bb34 ]
  %r236 = add i32 %r638, 0
  %r237 = add i32 %r638, 1
  %r641 = add i32 %r237, 0
  br label %bb31

bb33:
  %r610 = phi i32 [ %r709, %bb31 ]
  %r611 = phi i32 [ %r710, %bb31 ]
  %r612 = phi i32 [ %r711, %bb31 ]
  %r613 = phi i32 [ %r712, %bb31 ]
  %r614 = phi i32 [ %r713, %bb31 ]
  %r615 = phi i32 [ %r714, %bb31 ]
  %r616 = phi i32 [ %r715, %bb31 ]
  %r238 = add i32 %r616, 0
  %r239 = add i32 %r616, 1
  %r617 = add i32 %r239, 0
  br label %bb28

bb30:
  %r602 = phi i32 [ %r657, %bb28 ]
  %r603 = phi i32 [ %r658, %bb28 ]
  %r604 = phi i32 [ %r659, %bb28 ]
  %r605 = phi i32 [ %r660, %bb28 ]
  %r606 = phi i32 [ %r661, %bb28 ]
  %r607 = phi i32 [ %r662, %bb28 ]
  %r608 = phi i32 [ %r663, %bb28 ]
  %r240 = add i32 %r602, 0
  %r241 = add i32 %r602, 1
  %r609 = add i32 %r241, 0
  br label %bb25

bb27:
  %r595 = phi i32 [ %r672, %bb25 ]
  %r596 = phi i32 [ %r673, %bb25 ]
  %r597 = phi i32 [ %r674, %bb25 ]
  %r598 = phi i32 [ %r675, %bb25 ]
  %r599 = phi i32 [ %r676, %bb25 ]
  %r600 = phi i32 [ %r677, %bb25 ]
  %r601 = phi i32 [ %r678, %bb25 ]
  ret i32 0
}

define i32 @loop3( i32 %r242, i32 %r244, i32 %r246, i32 %r248, i32 %r250, i32 %r252, i32 %r254 ) {
bb46:
  %r770 = add i32 0, 0
  %r771 = add i32 %r242, 0
  %r772 = add i32 0, 0
  %r773 = add i32 %r244, 0
  %r774 = add i32 0, 0
  %r775 = add i32 %r246, 0
  %r776 = add i32 0, 0
  %r777 = add i32 %r248, 0
  %r778 = add i32 0, 0
  %r779 = add i32 %r250, 0
  %r780 = add i32 0, 0
  %r781 = add i32 %r252, 0
  %r782 = add i32 0, 0
  %r783 = add i32 %r254, 0
  %r784 = add i32 0, 0
  %r785 = add i32 0, 0
  %r786 = add i32 0, 0
  %r787 = add i32 0, 0
  %r788 = add i32 0, 0
  %r789 = add i32 0, 0
  %r790 = add i32 0, 0
  %r791 = add i32 0, 0
  %r792 = add i32 0, 0
  %r793 = add i32 0, 0
  br label %bb47

bb47:
  %r853 = phi i32 [ %r786, %bb46 ], [ %r802, %bb81 ]
  %r854 = phi i32 [ %r787, %bb46 ], [ %r803, %bb81 ]
  %r855 = phi i32 [ %r793, %bb46 ], [ %r804, %bb81 ]
  %r856 = phi i32 [ %r788, %bb46 ], [ %r805, %bb81 ]
  %r857 = phi i32 [ %r792, %bb46 ], [ %r806, %bb81 ]
  %r858 = phi i32 [ %r790, %bb46 ], [ %r807, %bb81 ]
  %r859 = phi i32 [ %r785, %bb46 ], [ %r808, %bb81 ]
  %r860 = phi i32 [ %r789, %bb46 ], [ %r809, %bb81 ]
  %r264 = add i32 %r855, 0
  %r265 = icmp slt i32 %r855, 10
  br i1 %r265, label %bb48, label %bb49

bb48:
  %r971 = phi i32 [ %r853, %bb47 ]
  %r972 = phi i32 [ %r854, %bb47 ]
  %r973 = phi i32 [ %r855, %bb47 ]
  %r974 = phi i32 [ %r856, %bb47 ]
  %r975 = phi i32 [ %r857, %bb47 ]
  %r976 = phi i32 [ %r858, %bb47 ]
  %r977 = phi i32 [ %r859, %bb47 ]
  %r978 = phi i32 [ %r860, %bb47 ]
  %r979 = add i32 0, 0
  br label %bb50

bb50:
  %r1005 = phi i32 [ %r971, %bb48 ], [ %r913, %bb79 ]
  %r1006 = phi i32 [ %r972, %bb48 ], [ %r914, %bb79 ]
  %r1007 = phi i32 [ %r973, %bb48 ], [ %r915, %bb79 ]
  %r1008 = phi i32 [ %r974, %bb48 ], [ %r916, %bb79 ]
  %r1009 = phi i32 [ %r975, %bb48 ], [ %r917, %bb79 ]
  %r1010 = phi i32 [ %r976, %bb48 ], [ %r918, %bb79 ]
  %r1011 = phi i32 [ %r979, %bb48 ], [ %r919, %bb79 ]
  %r1012 = phi i32 [ %r978, %bb48 ], [ %r920, %bb79 ]
  %r266 = add i32 %r1011, 0
  %r267 = icmp slt i32 %r1011, 100
  br i1 %r267, label %bb51, label %bb52

bb51:
  %r988 = phi i32 [ %r1005, %bb50 ]
  %r989 = phi i32 [ %r1006, %bb50 ]
  %r990 = phi i32 [ %r1007, %bb50 ]
  %r991 = phi i32 [ %r1008, %bb50 ]
  %r992 = phi i32 [ %r1009, %bb50 ]
  %r993 = phi i32 [ %r1010, %bb50 ]
  %r994 = phi i32 [ %r1011, %bb50 ]
  %r995 = phi i32 [ %r1012, %bb50 ]
  %r996 = add i32 0, 0
  br label %bb53

bb53:
  %r1030 = phi i32 [ %r996, %bb51 ], [ %r1055, %bb77 ]
  %r1031 = phi i32 [ %r989, %bb51 ], [ %r1056, %bb77 ]
  %r1032 = phi i32 [ %r990, %bb51 ], [ %r1057, %bb77 ]
  %r1033 = phi i32 [ %r991, %bb51 ], [ %r1058, %bb77 ]
  %r1034 = phi i32 [ %r992, %bb51 ], [ %r1059, %bb77 ]
  %r1035 = phi i32 [ %r993, %bb51 ], [ %r1060, %bb77 ]
  %r1036 = phi i32 [ %r994, %bb51 ], [ %r1061, %bb77 ]
  %r1037 = phi i32 [ %r995, %bb51 ], [ %r1062, %bb77 ]
  %r268 = add i32 %r1030, 0
  %r269 = icmp slt i32 %r1030, 1000
  br i1 %r269, label %bb54, label %bb55

bb54:
  %r1046 = phi i32 [ %r1030, %bb53 ]
  %r1047 = phi i32 [ %r1031, %bb53 ]
  %r1048 = phi i32 [ %r1032, %bb53 ]
  %r1049 = phi i32 [ %r1033, %bb53 ]
  %r1050 = phi i32 [ %r1034, %bb53 ]
  %r1051 = phi i32 [ %r1035, %bb53 ]
  %r1052 = phi i32 [ %r1036, %bb53 ]
  %r1053 = phi i32 [ %r1037, %bb53 ]
  %r1054 = add i32 0, 0
  br label %bb56

bb56:
  %r870 = phi i32 [ %r1046, %bb54 ], [ %r1022, %bb75 ]
  %r871 = phi i32 [ %r1054, %bb54 ], [ %r1023, %bb75 ]
  %r872 = phi i32 [ %r1048, %bb54 ], [ %r1024, %bb75 ]
  %r873 = phi i32 [ %r1049, %bb54 ], [ %r1025, %bb75 ]
  %r874 = phi i32 [ %r1050, %bb54 ], [ %r1026, %bb75 ]
  %r875 = phi i32 [ %r1051, %bb54 ], [ %r1027, %bb75 ]
  %r876 = phi i32 [ %r1052, %bb54 ], [ %r1028, %bb75 ]
  %r877 = phi i32 [ %r1053, %bb54 ], [ %r1029, %bb75 ]
  %r270 = add i32 %r871, 0
  %r271 = icmp slt i32 %r871, 10000
  br i1 %r271, label %bb57, label %bb58

bb57:
  %r887 = phi i32 [ %r870, %bb56 ]
  %r888 = phi i32 [ %r871, %bb56 ]
  %r889 = phi i32 [ %r872, %bb56 ]
  %r890 = phi i32 [ %r873, %bb56 ]
  %r891 = phi i32 [ %r874, %bb56 ]
  %r892 = phi i32 [ %r875, %bb56 ]
  %r893 = phi i32 [ %r876, %bb56 ]
  %r894 = phi i32 [ %r877, %bb56 ]
  %r895 = add i32 0, 0
  br label %bb59

bb59:
  %r845 = phi i32 [ %r887, %bb57 ], [ %r963, %bb73 ]
  %r846 = phi i32 [ %r888, %bb57 ], [ %r964, %bb73 ]
  %r847 = phi i32 [ %r889, %bb57 ], [ %r965, %bb73 ]
  %r848 = phi i32 [ %r895, %bb57 ], [ %r966, %bb73 ]
  %r849 = phi i32 [ %r891, %bb57 ], [ %r967, %bb73 ]
  %r850 = phi i32 [ %r892, %bb57 ], [ %r968, %bb73 ]
  %r851 = phi i32 [ %r893, %bb57 ], [ %r969, %bb73 ]
  %r852 = phi i32 [ %r894, %bb57 ], [ %r970, %bb73 ]
  %r272 = add i32 %r848, 0
  %r273 = icmp slt i32 %r848, 100000
  br i1 %r273, label %bb60, label %bb61

bb60:
  %r1063 = phi i32 [ %r845, %bb59 ]
  %r1064 = phi i32 [ %r846, %bb59 ]
  %r1065 = phi i32 [ %r847, %bb59 ]
  %r1066 = phi i32 [ %r848, %bb59 ]
  %r1067 = phi i32 [ %r849, %bb59 ]
  %r1068 = phi i32 [ %r850, %bb59 ]
  %r1069 = phi i32 [ %r851, %bb59 ]
  %r1070 = phi i32 [ %r852, %bb59 ]
  %r1071 = add i32 0, 0
  br label %bb62

bb62:
  %r1080 = phi i32 [ %r1063, %bb60 ], [ %r938, %bb71 ]
  %r1081 = phi i32 [ %r1064, %bb60 ], [ %r939, %bb71 ]
  %r1082 = phi i32 [ %r1065, %bb60 ], [ %r940, %bb71 ]
  %r1083 = phi i32 [ %r1066, %bb60 ], [ %r941, %bb71 ]
  %r1084 = phi i32 [ %r1067, %bb60 ], [ %r942, %bb71 ]
  %r1085 = phi i32 [ %r1068, %bb60 ], [ %r943, %bb71 ]
  %r1086 = phi i32 [ %r1069, %bb60 ], [ %r944, %bb71 ]
  %r1087 = phi i32 [ %r1071, %bb60 ], [ %r945, %bb71 ]
  %r274 = add i32 %r1087, 0
  %r275 = icmp slt i32 %r1087, 1000000
  br i1 %r275, label %bb63, label %bb64

bb63:
  %r1013 = phi i32 [ %r1080, %bb62 ]
  %r1014 = phi i32 [ %r1081, %bb62 ]
  %r1015 = phi i32 [ %r1082, %bb62 ]
  %r1016 = phi i32 [ %r1083, %bb62 ]
  %r1017 = phi i32 [ %r1084, %bb62 ]
  %r1018 = phi i32 [ %r1085, %bb62 ]
  %r1019 = phi i32 [ %r1086, %bb62 ]
  %r1020 = phi i32 [ %r1087, %bb62 ]
  %r1021 = add i32 0, 0
  br label %bb65

bb65:
  %r997 = phi i32 [ %r1013, %bb63 ], [ %r1072, %bb69 ]
  %r998 = phi i32 [ %r1014, %bb63 ], [ %r1073, %bb69 ]
  %r999 = phi i32 [ %r1015, %bb63 ], [ %r1074, %bb69 ]
  %r1000 = phi i32 [ %r1016, %bb63 ], [ %r1075, %bb69 ]
  %r1001 = phi i32 [ %r1017, %bb63 ], [ %r1076, %bb69 ]
  %r1002 = phi i32 [ %r1021, %bb63 ], [ %r1077, %bb69 ]
  %r1003 = phi i32 [ %r1019, %bb63 ], [ %r1078, %bb69 ]
  %r1004 = phi i32 [ %r1020, %bb63 ], [ %r1079, %bb69 ]
  %r276 = add i32 %r1002, 0
  %r277 = icmp slt i32 %r1002, 10000000
  br i1 %r277, label %bb66, label %bb67

bb66:
  %r835 = phi i32 [ %r997, %bb65 ]
  %r836 = phi i32 [ %r998, %bb65 ]
  %r837 = phi i32 [ %r999, %bb65 ]
  %r838 = phi i32 [ %r1000, %bb65 ]
  %r839 = phi i32 [ %r1001, %bb65 ]
  %r840 = phi i32 [ %r1002, %bb65 ]
  %r841 = phi i32 [ %r1003, %bb65 ]
  %r842 = phi i32 [ %r1004, %bb65 ]
  %r278 = add i32 %r839, 0
  %r279 = add i32 %r839, 0
  %r280 = sdiv i32 %r839, 817
  %r281 = mul i32 %r280, 817
  %r282 = sub i32 %r839, %r281
  %r283 = add i32 %r837, 0
  %r284 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* @arr1, i32 0, i32 %r837
  %r285 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* %r284, i32 0, i32 0
  %r286 = add i32 %r841, 0
  %r287 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r285, i32 0, i32 %r841
  %r288 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r287, i32 0, i32 0
  %r289 = add i32 %r835, 0
  %r290 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r288, i32 0, i32 %r835
  %r291 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r290, i32 0, i32 0
  %r292 = add i32 %r836, 0
  %r293 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r291, i32 0, i32 %r836
  %r294 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r293, i32 0, i32 0
  %r295 = add i32 %r838, 0
  %r296 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r294, i32 0, i32 %r838
  %r297 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r296, i32 0, i32 0
  %r298 = add i32 %r842, 0
  %r299 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r297, i32 0, i32 %r842
  %r300 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r299, i32 0, i32 0
  %r301 = add i32 %r840, 0
  %r302 = getelementptr [7 x i32 ], [7 x i32 ]* %r300, i32 0, i32 %r840
  %r303 = load i32, i32* %r302
  %r304 = add i32 %r282, %r303
  %r305 = add i32 %r837, 0
  %r306 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* @arr2, i32 0, i32 %r837
  %r307 = getelementptr [10 x %my_struct_6 ], [10 x %my_struct_6 ]* %r306, i32 0, i32 0
  %r308 = add i32 %r841, 0
  %r309 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r307, i32 0, i32 %r841
  %r310 = getelementptr [2 x %my_struct_5 ], [2 x %my_struct_5 ]* %r309, i32 0, i32 0
  %r311 = add i32 %r835, 0
  %r312 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r310, i32 0, i32 %r835
  %r313 = getelementptr [3 x %my_struct_4 ], [3 x %my_struct_4 ]* %r312, i32 0, i32 0
  %r314 = add i32 %r836, 0
  %r315 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r313, i32 0, i32 %r836
  %r316 = getelementptr [4 x %my_struct_3 ], [4 x %my_struct_3 ]* %r315, i32 0, i32 0
  %r317 = add i32 %r838, 0
  %r318 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r316, i32 0, i32 %r838
  %r319 = getelementptr [5 x %my_struct_2 ], [5 x %my_struct_2 ]* %r318, i32 0, i32 0
  %r320 = add i32 %r842, 0
  %r321 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r319, i32 0, i32 %r842
  %r322 = getelementptr [8 x %my_struct_1 ], [8 x %my_struct_1 ]* %r321, i32 0, i32 0
  %r323 = add i32 %r840, 0
  %r324 = getelementptr [7 x i32 ], [7 x i32 ]* %r322, i32 0, i32 %r840
  %r325 = load i32, i32* %r324
  %r326 = add i32 %r304, %r325
  %r843 = add i32 %r326, 0
  %r327 = add i32 %r840, 0
  %r328 = add i32 %r840, 1
  %r844 = add i32 %r328, 0
  %r329 = add i32 %r844, 0
  %r330 = add i32 %r783, 0
  %r331 = icmp sge i32 %r844, %r783
  br i1 %r331, label %bb68, label %bb69

bb68:
  %r827 = phi i32 [ %r835, %bb66 ]
  %r828 = phi i32 [ %r836, %bb66 ]
  %r829 = phi i32 [ %r837, %bb66 ]
  %r830 = phi i32 [ %r838, %bb66 ]
  %r831 = phi i32 [ %r843, %bb66 ]
  %r832 = phi i32 [ %r844, %bb66 ]
  %r833 = phi i32 [ %r841, %bb66 ]
  %r834 = phi i32 [ %r842, %bb66 ]
  br label %bb67

bb69:
  %r1072 = phi i32 [ %r835, %bb66 ]
  %r1073 = phi i32 [ %r836, %bb66 ]
  %r1074 = phi i32 [ %r837, %bb66 ]
  %r1075 = phi i32 [ %r838, %bb66 ]
  %r1076 = phi i32 [ %r843, %bb66 ]
  %r1077 = phi i32 [ %r844, %bb66 ]
  %r1078 = phi i32 [ %r841, %bb66 ]
  %r1079 = phi i32 [ %r842, %bb66 ]
  br label %bb65

bb67:
  %r810 = phi i32 [ %r997, %bb65 ], [ %r827, %bb68 ]
  %r811 = phi i32 [ %r998, %bb65 ], [ %r828, %bb68 ]
  %r812 = phi i32 [ %r999, %bb65 ], [ %r829, %bb68 ]
  %r813 = phi i32 [ %r1000, %bb65 ], [ %r830, %bb68 ]
  %r814 = phi i32 [ %r1001, %bb65 ], [ %r831, %bb68 ]
  %r815 = phi i32 [ %r1002, %bb65 ], [ %r832, %bb68 ]
  %r816 = phi i32 [ %r1003, %bb65 ], [ %r833, %bb68 ]
  %r817 = phi i32 [ %r1004, %bb65 ], [ %r834, %bb68 ]
  %r332 = add i32 %r817, 0
  %r333 = add i32 %r817, 1
  %r818 = add i32 %r333, 0
  %r334 = add i32 %r818, 0
  %r335 = add i32 %r781, 0
  %r336 = icmp sge i32 %r818, %r781
  br i1 %r336, label %bb70, label %bb71

bb70:
  %r794 = phi i32 [ %r810, %bb67 ]
  %r795 = phi i32 [ %r811, %bb67 ]
  %r796 = phi i32 [ %r812, %bb67 ]
  %r797 = phi i32 [ %r813, %bb67 ]
  %r798 = phi i32 [ %r814, %bb67 ]
  %r799 = phi i32 [ %r815, %bb67 ]
  %r800 = phi i32 [ %r816, %bb67 ]
  %r801 = phi i32 [ %r818, %bb67 ]
  br label %bb64

bb71:
  %r938 = phi i32 [ %r810, %bb67 ]
  %r939 = phi i32 [ %r811, %bb67 ]
  %r940 = phi i32 [ %r812, %bb67 ]
  %r941 = phi i32 [ %r813, %bb67 ]
  %r942 = phi i32 [ %r814, %bb67 ]
  %r943 = phi i32 [ %r815, %bb67 ]
  %r944 = phi i32 [ %r816, %bb67 ]
  %r945 = phi i32 [ %r818, %bb67 ]
  br label %bb62

bb64:
  %r946 = phi i32 [ %r1080, %bb62 ], [ %r794, %bb70 ]
  %r947 = phi i32 [ %r1081, %bb62 ], [ %r795, %bb70 ]
  %r948 = phi i32 [ %r1082, %bb62 ], [ %r796, %bb70 ]
  %r949 = phi i32 [ %r1083, %bb62 ], [ %r797, %bb70 ]
  %r950 = phi i32 [ %r1084, %bb62 ], [ %r798, %bb70 ]
  %r951 = phi i32 [ %r1085, %bb62 ], [ %r799, %bb70 ]
  %r952 = phi i32 [ %r1086, %bb62 ], [ %r800, %bb70 ]
  %r953 = phi i32 [ %r1087, %bb62 ], [ %r801, %bb70 ]
  %r337 = add i32 %r949, 0
  %r338 = add i32 %r949, 1
  %r954 = add i32 %r338, 0
  %r339 = add i32 %r954, 0
  %r340 = add i32 %r779, 0
  %r341 = icmp sge i32 %r954, %r779
  br i1 %r341, label %bb72, label %bb73

bb72:
  %r955 = phi i32 [ %r946, %bb64 ]
  %r956 = phi i32 [ %r947, %bb64 ]
  %r957 = phi i32 [ %r948, %bb64 ]
  %r958 = phi i32 [ %r954, %bb64 ]
  %r959 = phi i32 [ %r950, %bb64 ]
  %r960 = phi i32 [ %r951, %bb64 ]
  %r961 = phi i32 [ %r952, %bb64 ]
  %r962 = phi i32 [ %r953, %bb64 ]
  br label %bb61

bb73:
  %r963 = phi i32 [ %r946, %bb64 ]
  %r964 = phi i32 [ %r947, %bb64 ]
  %r965 = phi i32 [ %r948, %bb64 ]
  %r966 = phi i32 [ %r954, %bb64 ]
  %r967 = phi i32 [ %r950, %bb64 ]
  %r968 = phi i32 [ %r951, %bb64 ]
  %r969 = phi i32 [ %r952, %bb64 ]
  %r970 = phi i32 [ %r953, %bb64 ]
  br label %bb59

bb61:
  %r861 = phi i32 [ %r845, %bb59 ], [ %r955, %bb72 ]
  %r862 = phi i32 [ %r846, %bb59 ], [ %r956, %bb72 ]
  %r863 = phi i32 [ %r847, %bb59 ], [ %r957, %bb72 ]
  %r864 = phi i32 [ %r848, %bb59 ], [ %r958, %bb72 ]
  %r865 = phi i32 [ %r849, %bb59 ], [ %r959, %bb72 ]
  %r866 = phi i32 [ %r850, %bb59 ], [ %r960, %bb72 ]
  %r867 = phi i32 [ %r851, %bb59 ], [ %r961, %bb72 ]
  %r868 = phi i32 [ %r852, %bb59 ], [ %r962, %bb72 ]
  %r342 = add i32 %r862, 0
  %r343 = add i32 %r862, 1
  %r869 = add i32 %r343, 0
  %r344 = add i32 %r869, 0
  %r345 = add i32 %r777, 0
  %r346 = icmp sge i32 %r869, %r777
  br i1 %r346, label %bb74, label %bb75

bb74:
  %r980 = phi i32 [ %r861, %bb61 ]
  %r981 = phi i32 [ %r869, %bb61 ]
  %r982 = phi i32 [ %r863, %bb61 ]
  %r983 = phi i32 [ %r864, %bb61 ]
  %r984 = phi i32 [ %r865, %bb61 ]
  %r985 = phi i32 [ %r866, %bb61 ]
  %r986 = phi i32 [ %r867, %bb61 ]
  %r987 = phi i32 [ %r868, %bb61 ]
  br label %bb58

bb75:
  %r1022 = phi i32 [ %r861, %bb61 ]
  %r1023 = phi i32 [ %r869, %bb61 ]
  %r1024 = phi i32 [ %r863, %bb61 ]
  %r1025 = phi i32 [ %r864, %bb61 ]
  %r1026 = phi i32 [ %r865, %bb61 ]
  %r1027 = phi i32 [ %r866, %bb61 ]
  %r1028 = phi i32 [ %r867, %bb61 ]
  %r1029 = phi i32 [ %r868, %bb61 ]
  br label %bb56

bb58:
  %r904 = phi i32 [ %r870, %bb56 ], [ %r980, %bb74 ]
  %r905 = phi i32 [ %r871, %bb56 ], [ %r981, %bb74 ]
  %r906 = phi i32 [ %r872, %bb56 ], [ %r982, %bb74 ]
  %r907 = phi i32 [ %r873, %bb56 ], [ %r983, %bb74 ]
  %r908 = phi i32 [ %r874, %bb56 ], [ %r984, %bb74 ]
  %r909 = phi i32 [ %r875, %bb56 ], [ %r985, %bb74 ]
  %r910 = phi i32 [ %r876, %bb56 ], [ %r986, %bb74 ]
  %r911 = phi i32 [ %r877, %bb56 ], [ %r987, %bb74 ]
  %r347 = add i32 %r904, 0
  %r348 = add i32 %r904, 1
  %r912 = add i32 %r348, 0
  %r349 = add i32 %r912, 0
  %r350 = add i32 %r775, 0
  %r351 = icmp sge i32 %r912, %r775
  br i1 %r351, label %bb76, label %bb77

bb76:
  %r1038 = phi i32 [ %r912, %bb58 ]
  %r1039 = phi i32 [ %r905, %bb58 ]
  %r1040 = phi i32 [ %r906, %bb58 ]
  %r1041 = phi i32 [ %r907, %bb58 ]
  %r1042 = phi i32 [ %r908, %bb58 ]
  %r1043 = phi i32 [ %r909, %bb58 ]
  %r1044 = phi i32 [ %r910, %bb58 ]
  %r1045 = phi i32 [ %r911, %bb58 ]
  br label %bb55

bb77:
  %r1055 = phi i32 [ %r912, %bb58 ]
  %r1056 = phi i32 [ %r905, %bb58 ]
  %r1057 = phi i32 [ %r906, %bb58 ]
  %r1058 = phi i32 [ %r907, %bb58 ]
  %r1059 = phi i32 [ %r908, %bb58 ]
  %r1060 = phi i32 [ %r909, %bb58 ]
  %r1061 = phi i32 [ %r910, %bb58 ]
  %r1062 = phi i32 [ %r911, %bb58 ]
  br label %bb53

bb55:
  %r878 = phi i32 [ %r1030, %bb53 ], [ %r1038, %bb76 ]
  %r879 = phi i32 [ %r1031, %bb53 ], [ %r1039, %bb76 ]
  %r880 = phi i32 [ %r1032, %bb53 ], [ %r1040, %bb76 ]
  %r881 = phi i32 [ %r1033, %bb53 ], [ %r1041, %bb76 ]
  %r882 = phi i32 [ %r1034, %bb53 ], [ %r1042, %bb76 ]
  %r883 = phi i32 [ %r1035, %bb53 ], [ %r1043, %bb76 ]
  %r884 = phi i32 [ %r1036, %bb53 ], [ %r1044, %bb76 ]
  %r885 = phi i32 [ %r1037, %bb53 ], [ %r1045, %bb76 ]
  %r352 = add i32 %r884, 0
  %r353 = add i32 %r884, 1
  %r886 = add i32 %r353, 0
  %r354 = add i32 %r886, 0
  %r355 = add i32 %r773, 0
  %r356 = icmp sge i32 %r886, %r773
  br i1 %r356, label %bb78, label %bb79

bb78:
  %r896 = phi i32 [ %r878, %bb55 ]
  %r897 = phi i32 [ %r879, %bb55 ]
  %r898 = phi i32 [ %r880, %bb55 ]
  %r899 = phi i32 [ %r881, %bb55 ]
  %r900 = phi i32 [ %r882, %bb55 ]
  %r901 = phi i32 [ %r883, %bb55 ]
  %r902 = phi i32 [ %r886, %bb55 ]
  %r903 = phi i32 [ %r885, %bb55 ]
  br label %bb52

bb79:
  %r913 = phi i32 [ %r878, %bb55 ]
  %r914 = phi i32 [ %r879, %bb55 ]
  %r915 = phi i32 [ %r880, %bb55 ]
  %r916 = phi i32 [ %r881, %bb55 ]
  %r917 = phi i32 [ %r882, %bb55 ]
  %r918 = phi i32 [ %r883, %bb55 ]
  %r919 = phi i32 [ %r886, %bb55 ]
  %r920 = phi i32 [ %r885, %bb55 ]
  br label %bb50

bb52:
  %r929 = phi i32 [ %r1005, %bb50 ], [ %r896, %bb78 ]
  %r930 = phi i32 [ %r1006, %bb50 ], [ %r897, %bb78 ]
  %r931 = phi i32 [ %r1007, %bb50 ], [ %r898, %bb78 ]
  %r932 = phi i32 [ %r1008, %bb50 ], [ %r899, %bb78 ]
  %r933 = phi i32 [ %r1009, %bb50 ], [ %r900, %bb78 ]
  %r934 = phi i32 [ %r1010, %bb50 ], [ %r901, %bb78 ]
  %r935 = phi i32 [ %r1011, %bb50 ], [ %r902, %bb78 ]
  %r936 = phi i32 [ %r1012, %bb50 ], [ %r903, %bb78 ]
  %r357 = add i32 %r931, 0
  %r358 = add i32 %r931, 1
  %r937 = add i32 %r358, 0
  %r359 = add i32 %r937, 0
  %r360 = add i32 %r771, 0
  %r361 = icmp sge i32 %r937, %r771
  br i1 %r361, label %bb80, label %bb81

bb80:
  %r819 = phi i32 [ %r929, %bb52 ]
  %r820 = phi i32 [ %r930, %bb52 ]
  %r821 = phi i32 [ %r937, %bb52 ]
  %r822 = phi i32 [ %r932, %bb52 ]
  %r823 = phi i32 [ %r933, %bb52 ]
  %r824 = phi i32 [ %r934, %bb52 ]
  %r825 = phi i32 [ %r935, %bb52 ]
  %r826 = phi i32 [ %r936, %bb52 ]
  br label %bb49

bb81:
  %r802 = phi i32 [ %r929, %bb52 ]
  %r803 = phi i32 [ %r930, %bb52 ]
  %r804 = phi i32 [ %r937, %bb52 ]
  %r805 = phi i32 [ %r932, %bb52 ]
  %r806 = phi i32 [ %r933, %bb52 ]
  %r807 = phi i32 [ %r934, %bb52 ]
  %r808 = phi i32 [ %r935, %bb52 ]
  %r809 = phi i32 [ %r936, %bb52 ]
  br label %bb47

bb49:
  %r921 = phi i32 [ %r853, %bb47 ], [ %r819, %bb80 ]
  %r922 = phi i32 [ %r854, %bb47 ], [ %r820, %bb80 ]
  %r923 = phi i32 [ %r855, %bb47 ], [ %r821, %bb80 ]
  %r924 = phi i32 [ %r856, %bb47 ], [ %r822, %bb80 ]
  %r925 = phi i32 [ %r857, %bb47 ], [ %r823, %bb80 ]
  %r926 = phi i32 [ %r858, %bb47 ], [ %r824, %bb80 ]
  %r927 = phi i32 [ %r859, %bb47 ], [ %r825, %bb80 ]
  %r928 = phi i32 [ %r860, %bb47 ], [ %r826, %bb80 ]
  %r362 = add i32 %r925, 0
  ret i32 %r925
}

define i32 @main( ) {
bb82:
  call void @_sysy_starttime(i32 97)
  %r1097 = add i32 0, 0
  %r364 = call i32 @getint()
  %r1098 = add i32 %r364, 0
  %r1099 = add i32 0, 0
  %r366 = call i32 @getint()
  %r1100 = add i32 %r366, 0
  %r1101 = add i32 0, 0
  %r368 = call i32 @getint()
  %r1102 = add i32 %r368, 0
  %r1103 = add i32 0, 0
  %r370 = call i32 @getint()
  %r1104 = add i32 %r370, 0
  %r1105 = add i32 0, 0
  %r372 = call i32 @getint()
  %r1106 = add i32 %r372, 0
  %r1107 = add i32 0, 0
  %r374 = call i32 @getint()
  %r1108 = add i32 %r374, 0
  %r1109 = add i32 0, 0
  %r376 = call i32 @getint()
  %r1110 = add i32 %r376, 0
  %r1111 = add i32 0, 0
  %r378 = call i32 @getint()
  %r1112 = add i32 %r378, 0
  %r1113 = add i32 0, 0
  %r380 = call i32 @getint()
  %r1114 = add i32 %r380, 0
  %r381 = add i32 %r1098, 0
  %r382 = add i32 %r1100, 0
  call void @loop1(i32 %r1098, i32 %r1100)
  call void @loop2()
  %r383 = add i32 %r1102, 0
  %r384 = add i32 %r1104, 0
  %r385 = add i32 %r1106, 0
  %r386 = add i32 %r1108, 0
  %r387 = add i32 %r1110, 0
  %r388 = add i32 %r1112, 0
  %r389 = add i32 %r1114, 0
  %r390 = call i32 @loop3(i32 %r1102, i32 %r1104, i32 %r1106, i32 %r1108, i32 %r1110, i32 %r1112, i32 %r1114)
  %r1115 = add i32 %r390, 0
  call void @_sysy_stoptime(i32 117)
  %r391 = add i32 %r1115, 0
  ret i32 %r1115
}

