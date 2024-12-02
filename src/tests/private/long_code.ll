declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@n = global i32 0
define i32 @bubblesort( i32* %r100 ) {
bb1:
  %r556 = add i32 0, 0
  %r557 = add i32 0, 0
  %r558 = add i32 0, 0
  %r559 = add i32 0, 0
  %r560 = add i32 0, 0
  %r561 = add i32 0, 0
  br label %bb2

bb2:
  %r603 = phi i32 [ %r561, %bb1 ], [ %r572, %bb7 ]
  %r604 = phi i32 [ %r560, %bb1 ], [ %r568, %bb7 ]
  %r605 = phi i32 [ %r557, %bb1 ], [ %r569, %bb7 ]
  %r606 = phi i32 [ %r556, %bb1 ], [ %r570, %bb7 ]
  %r607 = phi i32 [ %r558, %bb1 ], [ %r571, %bb7 ]
  %r103 = add i32 %r603, 0
  %r104 = load i32, i32* @n
  %r105 = sub i32 %r104, 1
  %r106 = icmp slt i32 %r603, %r105
  br i1 %r106, label %bb3, label %bb4

bb3:
  %r591 = phi i32 [ %r603, %bb2 ]
  %r592 = phi i32 [ %r604, %bb2 ]
  %r593 = phi i32 [ %r605, %bb2 ]
  %r594 = phi i32 [ %r606, %bb2 ]
  %r595 = phi i32 [ %r607, %bb2 ]
  %r596 = add i32 0, 0
  br label %bb5

bb5:
  %r586 = phi i32 [ %r591, %bb3 ], [ %r573, %bb9 ]
  %r587 = phi i32 [ %r596, %bb3 ], [ %r578, %bb9 ]
  %r588 = phi i32 [ %r593, %bb3 ], [ %r575, %bb9 ]
  %r589 = phi i32 [ %r594, %bb3 ], [ %r576, %bb9 ]
  %r590 = phi i32 [ %r595, %bb3 ], [ %r577, %bb9 ]
  %r107 = add i32 %r587, 0
  %r108 = load i32, i32* @n
  %r109 = add i32 %r586, 0
  %r110 = sub i32 %r108, %r586
  %r111 = sub i32 %r110, 1
  %r112 = icmp slt i32 %r587, %r111
  br i1 %r112, label %bb6, label %bb7

bb6:
  %r597 = phi i32 [ %r586, %bb5 ]
  %r598 = phi i32 [ %r587, %bb5 ]
  %r599 = phi i32 [ %r588, %bb5 ]
  %r600 = phi i32 [ %r589, %bb5 ]
  %r601 = phi i32 [ %r590, %bb5 ]
  %r114 = add i32 %r598, 0
  %r115 = add i32 %r598, 1
  %r602 = add i32 %r115, 0
  %r116 = add i32 %r598, 0
  %r117 = getelementptr i32, i32* %r100, i32 %r598
  %r118 = load i32, i32* %r117
  %r119 = add i32 %r602, 0
  %r120 = getelementptr i32, i32* %r100, i32 %r602
  %r121 = load i32, i32* %r120
  %r122 = icmp sgt i32 %r118, %r121
  br i1 %r122, label %bb8, label %bb9

bb8:
  %r579 = phi i32 [ %r597, %bb6 ]
  %r580 = phi i32 [ %r598, %bb6 ]
  %r581 = phi i32 [ %r599, %bb6 ]
  %r582 = phi i32 [ %r600, %bb6 ]
  %r583 = phi i32 [ %r602, %bb6 ]
  %r125 = add i32 %r580, 0
  %r126 = add i32 %r580, 1
  %r584 = add i32 %r126, 0
  %r127 = add i32 %r584, 0
  %r128 = getelementptr i32, i32* %r100, i32 %r584
  %r129 = load i32, i32* %r128
  %r585 = add i32 %r129, 0
  %r130 = add i32 %r584, 0
  %r131 = getelementptr i32, i32* %r100, i32 %r584
  %r132 = add i32 %r580, 0
  %r133 = getelementptr i32, i32* %r100, i32 %r580
  %r134 = load i32, i32* %r133
  store i32 %r134, i32* %r131
  %r135 = add i32 %r580, 0
  %r136 = getelementptr i32, i32* %r100, i32 %r580
  %r137 = add i32 %r585, 0
  store i32 %r137, i32* %r136
  br label %bb9

bb9:
  %r573 = phi i32 [ %r597, %bb6 ], [ %r579, %bb8 ]
  %r574 = phi i32 [ %r598, %bb6 ], [ %r580, %bb8 ]
  %r575 = phi i32 [ %r599, %bb6 ], [ %r585, %bb8 ]
  %r576 = phi i32 [ %r600, %bb6 ], [ %r584, %bb8 ]
  %r577 = phi i32 [ %r602, %bb6 ], [ %r583, %bb8 ]
  %r138 = add i32 %r574, 0
  %r139 = add i32 %r574, 1
  %r578 = add i32 %r139, 0
  br label %bb5

bb7:
  %r567 = phi i32 [ %r586, %bb5 ]
  %r568 = phi i32 [ %r587, %bb5 ]
  %r569 = phi i32 [ %r588, %bb5 ]
  %r570 = phi i32 [ %r589, %bb5 ]
  %r571 = phi i32 [ %r590, %bb5 ]
  %r140 = add i32 %r567, 0
  %r141 = add i32 %r567, 1
  %r572 = add i32 %r141, 0
  br label %bb2

bb4:
  %r562 = phi i32 [ %r603, %bb2 ]
  %r563 = phi i32 [ %r604, %bb2 ]
  %r564 = phi i32 [ %r605, %bb2 ]
  %r565 = phi i32 [ %r606, %bb2 ]
  %r566 = phi i32 [ %r607, %bb2 ]
  ret i32 0
}

define i32 @insertsort( i32* %r142 ) {
bb10:
  %r613 = add i32 0, 0
  %r614 = add i32 0, 0
  %r615 = add i32 0, 0
  %r616 = add i32 0, 0
  %r617 = add i32 0, 0
  %r618 = add i32 1, 0
  br label %bb11

bb11:
  %r655 = phi i32 [ %r618, %bb10 ], [ %r625, %bb16 ]
  %r656 = phi i32 [ %r613, %bb10 ], [ %r624, %bb16 ]
  %r657 = phi i32 [ %r615, %bb10 ], [ %r621, %bb16 ]
  %r658 = phi i32 [ %r616, %bb10 ], [ %r622, %bb16 ]
  %r659 = phi i32 [ %r614, %bb10 ], [ %r623, %bb16 ]
  %r144 = add i32 %r655, 0
  %r145 = load i32, i32* @n
  %r146 = icmp slt i32 %r655, %r145
  br i1 %r146, label %bb12, label %bb13

bb12:
  %r636 = phi i32 [ %r655, %bb11 ]
  %r637 = phi i32 [ %r656, %bb11 ]
  %r638 = phi i32 [ %r657, %bb11 ]
  %r639 = phi i32 [ %r658, %bb11 ]
  %r640 = phi i32 [ %r659, %bb11 ]
  %r148 = add i32 %r636, 0
  %r149 = getelementptr i32, i32* %r142, i32 %r636
  %r150 = load i32, i32* %r149
  %r641 = add i32 %r150, 0
  %r152 = add i32 %r636, 0
  %r153 = sub i32 %r636, 1
  %r642 = add i32 %r153, 0
  br label %bb14

bb14:
  %r650 = phi i32 [ %r636, %bb12 ], [ %r643, %bb15 ]
  %r651 = phi i32 [ %r637, %bb12 ], [ %r644, %bb15 ]
  %r652 = phi i32 [ %r642, %bb12 ], [ %r649, %bb15 ]
  %r653 = phi i32 [ %r641, %bb12 ], [ %r646, %bb15 ]
  %r654 = phi i32 [ %r640, %bb12 ], [ %r648, %bb15 ]
  %r154 = add i32 %r652, 0
  %r155 = icmp sgt i32 %r652, -1
  br i1 %r155, label %bb17, label %bb16

bb17:
  %r631 = phi i32 [ %r650, %bb14 ]
  %r632 = phi i32 [ %r651, %bb14 ]
  %r633 = phi i32 [ %r652, %bb14 ]
  %r634 = phi i32 [ %r653, %bb14 ]
  %r635 = phi i32 [ %r654, %bb14 ]
  %r156 = add i32 %r634, 0
  %r157 = add i32 %r633, 0
  %r158 = getelementptr i32, i32* %r142, i32 %r633
  %r159 = load i32, i32* %r158
  %r160 = icmp slt i32 %r634, %r159
  br i1 %r160, label %bb15, label %bb16

bb15:
  %r643 = phi i32 [ %r631, %bb17 ]
  %r644 = phi i32 [ %r632, %bb17 ]
  %r645 = phi i32 [ %r633, %bb17 ]
  %r646 = phi i32 [ %r634, %bb17 ]
  %r647 = phi i32 [ %r635, %bb17 ]
  %r162 = add i32 %r645, 0
  %r163 = add i32 %r645, 1
  %r648 = add i32 %r163, 0
  %r164 = add i32 %r648, 0
  %r165 = getelementptr i32, i32* %r142, i32 %r648
  %r166 = add i32 %r645, 0
  %r167 = getelementptr i32, i32* %r142, i32 %r645
  %r168 = load i32, i32* %r167
  store i32 %r168, i32* %r165
  %r169 = add i32 %r645, 0
  %r170 = sub i32 %r645, 1
  %r649 = add i32 %r170, 0
  br label %bb14

bb16:
  %r619 = phi i32 [ %r650, %bb14 ], [ %r631, %bb17 ]
  %r620 = phi i32 [ %r651, %bb14 ], [ %r632, %bb17 ]
  %r621 = phi i32 [ %r652, %bb14 ], [ %r633, %bb17 ]
  %r622 = phi i32 [ %r653, %bb14 ], [ %r634, %bb17 ]
  %r623 = phi i32 [ %r654, %bb14 ], [ %r635, %bb17 ]
  %r172 = add i32 %r621, 0
  %r173 = add i32 %r621, 1
  %r624 = add i32 %r173, 0
  %r174 = add i32 %r624, 0
  %r175 = getelementptr i32, i32* %r142, i32 %r624
  %r176 = add i32 %r622, 0
  store i32 %r176, i32* %r175
  %r177 = add i32 %r619, 0
  %r178 = add i32 %r619, 1
  %r625 = add i32 %r178, 0
  br label %bb11

bb13:
  %r626 = phi i32 [ %r655, %bb11 ]
  %r627 = phi i32 [ %r656, %bb11 ]
  %r628 = phi i32 [ %r657, %bb11 ]
  %r629 = phi i32 [ %r658, %bb11 ]
  %r630 = phi i32 [ %r659, %bb11 ]
  ret i32 0
}

define i32 @QuickSort( i32* %r179, i32 %r180, i32 %r182 ) {
bb18:
  %r666 = add i32 0, 0
  %r667 = add i32 0, 0
  %r668 = add i32 0, 0
  %r669 = add i32 0, 0
  %r670 = add i32 0, 0
  %r671 = add i32 %r180, 0
  %r672 = add i32 0, 0
  %r673 = add i32 %r182, 0
  %r184 = add i32 %r671, 0
  %r185 = add i32 %r673, 0
  %r186 = icmp slt i32 %r671, %r673
  br i1 %r186, label %bb19, label %bb20

bb19:
  %r188 = add i32 %r671, 0
  %r722 = add i32 %r671, 0
  %r190 = add i32 %r673, 0
  %r723 = add i32 %r673, 0
  %r192 = add i32 %r671, 0
  %r193 = getelementptr i32, i32* %r179, i32 %r671
  %r194 = load i32, i32* %r193
  %r724 = add i32 %r194, 0
  br label %bb21

bb21:
  %r728 = phi i32 [ %r723, %bb19 ], [ %r715, %bb35 ]
  %r729 = phi i32 [ %r722, %bb19 ], [ %r716, %bb35 ]
  %r730 = phi i32 [ %r724, %bb19 ], [ %r717, %bb35 ]
  %r195 = add i32 %r729, 0
  %r196 = add i32 %r728, 0
  %r197 = icmp slt i32 %r729, %r728
  br i1 %r197, label %bb22, label %bb23

bb22:
  %r731 = phi i32 [ %r728, %bb21 ]
  %r732 = phi i32 [ %r729, %bb21 ]
  %r733 = phi i32 [ %r730, %bb21 ]
  br label %bb24

bb24:
  %r681 = phi i32 [ %r731, %bb22 ], [ %r691, %bb25 ]
  %r682 = phi i32 [ %r732, %bb22 ], [ %r689, %bb25 ]
  %r683 = phi i32 [ %r733, %bb22 ], [ %r690, %bb25 ]
  %r198 = add i32 %r682, 0
  %r199 = add i32 %r681, 0
  %r200 = icmp slt i32 %r682, %r681
  br i1 %r200, label %bb27, label %bb26

bb27:
  %r725 = phi i32 [ %r681, %bb24 ]
  %r726 = phi i32 [ %r682, %bb24 ]
  %r727 = phi i32 [ %r683, %bb24 ]
  %r201 = add i32 %r725, 0
  %r202 = getelementptr i32, i32* %r179, i32 %r725
  %r203 = load i32, i32* %r202
  %r204 = add i32 %r727, 0
  %r205 = sub i32 %r727, 1
  %r206 = icmp sgt i32 %r203, %r205
  br i1 %r206, label %bb25, label %bb26

bb25:
  %r688 = phi i32 [ %r725, %bb27 ]
  %r689 = phi i32 [ %r726, %bb27 ]
  %r690 = phi i32 [ %r727, %bb27 ]
  %r207 = add i32 %r688, 0
  %r208 = sub i32 %r688, 1
  %r691 = add i32 %r208, 0
  br label %bb24

bb26:
  %r678 = phi i32 [ %r681, %bb24 ], [ %r725, %bb27 ]
  %r679 = phi i32 [ %r682, %bb24 ], [ %r726, %bb27 ]
  %r680 = phi i32 [ %r683, %bb24 ], [ %r727, %bb27 ]
  %r209 = add i32 %r679, 0
  %r210 = add i32 %r678, 0
  %r211 = icmp slt i32 %r679, %r678
  br i1 %r211, label %bb28, label %bb29

bb28:
  %r674 = phi i32 [ %r678, %bb26 ]
  %r675 = phi i32 [ %r679, %bb26 ]
  %r676 = phi i32 [ %r680, %bb26 ]
  %r212 = add i32 %r675, 0
  %r213 = getelementptr i32, i32* %r179, i32 %r675
  %r214 = add i32 %r674, 0
  %r215 = getelementptr i32, i32* %r179, i32 %r674
  %r216 = load i32, i32* %r215
  store i32 %r216, i32* %r213
  %r217 = add i32 %r675, 0
  %r218 = add i32 %r675, 1
  %r677 = add i32 %r218, 0
  br label %bb29

bb29:
  %r712 = phi i32 [ %r678, %bb26 ], [ %r674, %bb28 ]
  %r713 = phi i32 [ %r679, %bb26 ], [ %r677, %bb28 ]
  %r714 = phi i32 [ %r680, %bb26 ], [ %r676, %bb28 ]
  br label %bb30

bb30:
  %r709 = phi i32 [ %r712, %bb29 ], [ %r684, %bb31 ]
  %r710 = phi i32 [ %r713, %bb29 ], [ %r687, %bb31 ]
  %r711 = phi i32 [ %r714, %bb29 ], [ %r686, %bb31 ]
  %r219 = add i32 %r710, 0
  %r220 = add i32 %r709, 0
  %r221 = icmp slt i32 %r710, %r709
  br i1 %r221, label %bb33, label %bb32

bb33:
  %r706 = phi i32 [ %r709, %bb30 ]
  %r707 = phi i32 [ %r710, %bb30 ]
  %r708 = phi i32 [ %r711, %bb30 ]
  %r222 = add i32 %r707, 0
  %r223 = getelementptr i32, i32* %r179, i32 %r707
  %r224 = load i32, i32* %r223
  %r225 = add i32 %r708, 0
  %r226 = icmp slt i32 %r224, %r708
  br i1 %r226, label %bb31, label %bb32

bb31:
  %r684 = phi i32 [ %r706, %bb33 ]
  %r685 = phi i32 [ %r707, %bb33 ]
  %r686 = phi i32 [ %r708, %bb33 ]
  %r227 = add i32 %r685, 0
  %r228 = add i32 %r685, 1
  %r687 = add i32 %r228, 0
  br label %bb30

bb32:
  %r696 = phi i32 [ %r709, %bb30 ], [ %r706, %bb33 ]
  %r697 = phi i32 [ %r710, %bb30 ], [ %r707, %bb33 ]
  %r698 = phi i32 [ %r711, %bb30 ], [ %r708, %bb33 ]
  %r229 = add i32 %r697, 0
  %r230 = add i32 %r696, 0
  %r231 = icmp slt i32 %r697, %r696
  br i1 %r231, label %bb34, label %bb35

bb34:
  %r718 = phi i32 [ %r696, %bb32 ]
  %r719 = phi i32 [ %r697, %bb32 ]
  %r720 = phi i32 [ %r698, %bb32 ]
  %r232 = add i32 %r718, 0
  %r233 = getelementptr i32, i32* %r179, i32 %r718
  %r234 = add i32 %r719, 0
  %r235 = getelementptr i32, i32* %r179, i32 %r719
  %r236 = load i32, i32* %r235
  store i32 %r236, i32* %r233
  %r237 = add i32 %r718, 0
  %r238 = sub i32 %r718, 1
  %r721 = add i32 %r238, 0
  br label %bb35

bb35:
  %r715 = phi i32 [ %r696, %bb32 ], [ %r721, %bb34 ]
  %r716 = phi i32 [ %r697, %bb32 ], [ %r719, %bb34 ]
  %r717 = phi i32 [ %r698, %bb32 ], [ %r720, %bb34 ]
  br label %bb21

bb23:
  %r699 = phi i32 [ %r728, %bb21 ]
  %r700 = phi i32 [ %r729, %bb21 ]
  %r701 = phi i32 [ %r730, %bb21 ]
  %r239 = add i32 %r700, 0
  %r240 = getelementptr i32, i32* %r179, i32 %r700
  %r241 = add i32 %r701, 0
  store i32 %r241, i32* %r240
  %r243 = add i32 %r700, 0
  %r244 = sub i32 %r700, 1
  %r702 = add i32 %r244, 0
  %r245 = add i32 %r671, 0
  %r246 = add i32 %r702, 0
  %r247 = call i32 @QuickSort(i32* %r179, i32 %r671, i32 %r702)
  %r703 = add i32 %r247, 0
  %r248 = add i32 %r700, 0
  %r249 = add i32 %r700, 1
  %r704 = add i32 %r249, 0
  %r250 = add i32 %r704, 0
  %r251 = add i32 %r673, 0
  %r252 = call i32 @QuickSort(i32* %r179, i32 %r704, i32 %r673)
  %r705 = add i32 %r252, 0
  br label %bb20

bb20:
  %r692 = phi i32 [ %r666, %bb18 ], [ %r705, %bb23 ]
  %r693 = phi i32 [ %r668, %bb18 ], [ %r699, %bb23 ]
  %r694 = phi i32 [ %r669, %bb18 ], [ %r700, %bb23 ]
  %r695 = phi i32 [ %r667, %bb18 ], [ %r701, %bb23 ]
  ret i32 0
}

define i32 @getMid( i32* %r253 ) {
bb36:
  %r736 = add i32 0, 0
  %r737 = add i32 0, 0
  %r255 = load i32, i32* @n
  %r256 = sdiv i32 %r255, 2
  %r257 = mul i32 %r256, 2
  %r258 = load i32, i32* @n
  %r259 = icmp eq i32 %r257, %r258
  br i1 %r259, label %bb37, label %bb38

bb37:
  %r260 = load i32, i32* @n
  %r261 = sdiv i32 %r260, 2
  %r739 = add i32 %r261, 0
  %r263 = add i32 %r739, 0
  %r264 = sub i32 %r739, 1
  %r740 = add i32 %r264, 0
  %r265 = add i32 %r739, 0
  %r266 = getelementptr i32, i32* %r253, i32 %r739
  %r267 = load i32, i32* %r266
  %r268 = add i32 %r740, 0
  %r269 = getelementptr i32, i32* %r253, i32 %r740
  %r270 = load i32, i32* %r269
  %r271 = add i32 %r267, %r270
  %r272 = sdiv i32 %r271, 2
  ret i32 %r272
bb38:
  %r273 = load i32, i32* @n
  %r274 = sdiv i32 %r273, 2
  %r738 = add i32 %r274, 0
  %r275 = add i32 %r738, 0
  %r276 = getelementptr i32, i32* %r253, i32 %r738
  %r277 = load i32, i32* %r276
  ret i32 %r277
}

define i32 @getMost( i32* %r278 ) {
bb40:
  %r745 = add i32 0, 0
  %r746 = add i32 0, 0
  %r747 = add i32 0, 0
  %r279 = alloca [ 1000 x i32 ]
  %r748 = add i32 0, 0
  %r749 = add i32 0, 0
  br label %bb41

bb41:
  %r779 = phi i32 [ %r749, %bb40 ], [ %r778, %bb42 ]
  %r281 = add i32 %r779, 0
  %r282 = icmp slt i32 %r779, 1000
  br i1 %r282, label %bb42, label %bb43

bb42:
  %r777 = phi i32 [ %r779, %bb41 ]
  %r283 = add i32 %r777, 0
  %r284 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r777
  store i32 0, i32* %r284
  %r285 = add i32 %r777, 0
  %r286 = add i32 %r777, 1
  %r778 = add i32 %r286, 0
  br label %bb41

bb43:
  %r770 = phi i32 [ %r779, %bb41 ]
  %r771 = add i32 0, 0
  %r772 = add i32 0, 0
  br label %bb44

bb44:
  %r773 = phi i32 [ %r771, %bb43 ], [ %r769, %bb48 ]
  %r774 = phi i32 [ %r746, %bb43 ], [ %r766, %bb48 ]
  %r775 = phi i32 [ %r772, %bb43 ], [ %r767, %bb48 ]
  %r776 = phi i32 [ %r745, %bb43 ], [ %r768, %bb48 ]
  %r289 = add i32 %r773, 0
  %r290 = load i32, i32* @n
  %r291 = icmp slt i32 %r773, %r290
  br i1 %r291, label %bb45, label %bb46

bb45:
  %r750 = phi i32 [ %r773, %bb44 ]
  %r751 = phi i32 [ %r774, %bb44 ]
  %r752 = phi i32 [ %r775, %bb44 ]
  %r753 = phi i32 [ %r776, %bb44 ]
  %r293 = add i32 %r750, 0
  %r294 = getelementptr i32, i32* %r278, i32 %r750
  %r295 = load i32, i32* %r294
  %r754 = add i32 %r295, 0
  %r296 = add i32 %r754, 0
  %r297 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r754
  %r298 = add i32 %r754, 0
  %r299 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r754
  %r300 = load i32, i32* %r299
  %r301 = add i32 %r300, 1
  store i32 %r301, i32* %r297
  %r302 = add i32 %r754, 0
  %r303 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r754
  %r304 = load i32, i32* %r303
  %r305 = add i32 %r752, 0
  %r306 = icmp sgt i32 %r304, %r752
  br i1 %r306, label %bb47, label %bb48

bb47:
  %r759 = phi i32 [ %r750, %bb45 ]
  %r760 = phi i32 [ %r751, %bb45 ]
  %r761 = phi i32 [ %r752, %bb45 ]
  %r762 = phi i32 [ %r754, %bb45 ]
  %r307 = add i32 %r762, 0
  %r308 = getelementptr [1000 x i32 ], [1000 x i32 ]* %r279, i32 0, i32 %r762
  %r309 = load i32, i32* %r308
  %r763 = add i32 %r309, 0
  %r310 = add i32 %r762, 0
  %r764 = add i32 %r762, 0
  br label %bb48

bb48:
  %r765 = phi i32 [ %r750, %bb45 ], [ %r759, %bb47 ]
  %r766 = phi i32 [ %r751, %bb45 ], [ %r764, %bb47 ]
  %r767 = phi i32 [ %r752, %bb45 ], [ %r763, %bb47 ]
  %r768 = phi i32 [ %r754, %bb45 ], [ %r762, %bb47 ]
  %r311 = add i32 %r765, 0
  %r312 = add i32 %r765, 1
  %r769 = add i32 %r312, 0
  br label %bb44

bb46:
  %r755 = phi i32 [ %r773, %bb44 ]
  %r756 = phi i32 [ %r774, %bb44 ]
  %r757 = phi i32 [ %r775, %bb44 ]
  %r758 = phi i32 [ %r776, %bb44 ]
  %r313 = add i32 %r756, 0
  ret i32 %r756
}

define i32 @revert( i32* %r314 ) {
bb49:
  %r783 = add i32 0, 0
  %r784 = add i32 0, 0
  %r785 = add i32 0, 0
  %r786 = add i32 0, 0
  %r787 = add i32 0, 0
  br label %bb50

bb50:
  %r791 = phi i32 [ %r787, %bb49 ], [ %r799, %bb51 ]
  %r792 = phi i32 [ %r786, %bb49 ], [ %r798, %bb51 ]
  %r793 = phi i32 [ %r783, %bb49 ], [ %r797, %bb51 ]
  %r318 = add i32 %r792, 0
  %r319 = add i32 %r791, 0
  %r320 = icmp slt i32 %r792, %r791
  br i1 %r320, label %bb51, label %bb52

bb51:
  %r794 = phi i32 [ %r791, %bb50 ]
  %r795 = phi i32 [ %r792, %bb50 ]
  %r796 = phi i32 [ %r793, %bb50 ]
  %r321 = add i32 %r795, 0
  %r322 = getelementptr i32, i32* %r314, i32 %r795
  %r323 = load i32, i32* %r322
  %r797 = add i32 %r323, 0
  %r324 = add i32 %r795, 0
  %r325 = getelementptr i32, i32* %r314, i32 %r795
  %r326 = add i32 %r794, 0
  %r327 = getelementptr i32, i32* %r314, i32 %r794
  %r328 = load i32, i32* %r327
  store i32 %r328, i32* %r325
  %r329 = add i32 %r794, 0
  %r330 = getelementptr i32, i32* %r314, i32 %r794
  %r331 = add i32 %r797, 0
  store i32 %r331, i32* %r330
  %r332 = add i32 %r795, 0
  %r333 = add i32 %r795, 1
  %r798 = add i32 %r333, 0
  %r334 = add i32 %r794, 0
  %r335 = sub i32 %r794, 1
  %r799 = add i32 %r335, 0
  br label %bb50

bb52:
  %r788 = phi i32 [ %r791, %bb50 ]
  %r789 = phi i32 [ %r792, %bb50 ]
  %r790 = phi i32 [ %r793, %bb50 ]
  ret i32 0
}

define i32 @arrCopy( i32* %r336, i32* %r337 ) {
bb53:
  %r801 = add i32 0, 0
  %r802 = add i32 0, 0
  br label %bb54

bb54:
  %r806 = phi i32 [ %r802, %bb53 ], [ %r805, %bb55 ]
  %r339 = add i32 %r806, 0
  %r340 = load i32, i32* @n
  %r341 = icmp slt i32 %r806, %r340
  br i1 %r341, label %bb55, label %bb56

bb55:
  %r804 = phi i32 [ %r806, %bb54 ]
  %r342 = add i32 %r804, 0
  %r343 = getelementptr i32, i32* %r337, i32 %r804
  %r344 = add i32 %r804, 0
  %r345 = getelementptr i32, i32* %r336, i32 %r804
  %r346 = load i32, i32* %r345
  store i32 %r346, i32* %r343
  %r347 = add i32 %r804, 0
  %r348 = add i32 %r804, 1
  %r805 = add i32 %r348, 0
  br label %bb54

bb56:
  %r803 = phi i32 [ %r806, %bb54 ]
  ret i32 0
}

define i32 @calSum( i32* %r349, i32 %r350 ) {
bb57:
  %r810 = add i32 0, 0
  %r811 = add i32 %r350, 0
  %r812 = add i32 0, 0
  %r813 = add i32 0, 0
  %r814 = add i32 0, 0
  %r815 = add i32 0, 0
  br label %bb58

bb58:
  %r829 = phi i32 [ %r815, %bb57 ], [ %r820, %bb63 ]
  %r830 = phi i32 [ %r813, %bb57 ], [ %r819, %bb63 ]
  %r354 = add i32 %r829, 0
  %r355 = load i32, i32* @n
  %r356 = icmp slt i32 %r829, %r355
  br i1 %r356, label %bb59, label %bb60

bb59:
  %r826 = phi i32 [ %r829, %bb58 ]
  %r827 = phi i32 [ %r830, %bb58 ]
  %r357 = add i32 %r827, 0
  %r358 = add i32 %r826, 0
  %r359 = getelementptr i32, i32* %r349, i32 %r826
  %r360 = load i32, i32* %r359
  %r361 = add i32 %r827, %r360
  %r828 = add i32 %r361, 0
  %r362 = add i32 %r826, 0
  %r363 = add i32 %r826, 0
  %r364 = add i32 %r811, 0
  %r365 = sdiv i32 %r826, %r811
  %r366 = add i32 %r811, 0
  %r367 = mul i32 %r365, %r811
  %r368 = sub i32 %r826, %r367
  %r369 = add i32 %r811, 0
  %r370 = sub i32 %r811, 1
  %r371 = icmp ne i32 %r368, %r370
  br i1 %r371, label %bb61, label %bb62

bb61:
  %r824 = phi i32 [ %r826, %bb59 ]
  %r825 = phi i32 [ %r828, %bb59 ]
  %r372 = add i32 %r824, 0
  %r373 = getelementptr i32, i32* %r349, i32 %r824
  store i32 0, i32* %r373
  br label %bb63

bb62:
  %r821 = phi i32 [ %r826, %bb59 ]
  %r822 = phi i32 [ %r828, %bb59 ]
  %r374 = add i32 %r821, 0
  %r375 = getelementptr i32, i32* %r349, i32 %r821
  %r376 = add i32 %r822, 0
  store i32 %r376, i32* %r375
  %r823 = add i32 0, 0
  br label %bb63

bb63:
  %r818 = phi i32 [ %r824, %bb61 ], [ %r821, %bb62 ]
  %r819 = phi i32 [ %r825, %bb61 ], [ %r823, %bb62 ]
  %r377 = add i32 %r818, 0
  %r378 = add i32 %r818, 1
  %r820 = add i32 %r378, 0
  br label %bb58

bb60:
  %r816 = phi i32 [ %r829, %bb58 ]
  %r817 = phi i32 [ %r830, %bb58 ]
  ret i32 0
}

define i32 @avgPooling( i32* %r379, i32 %r380 ) {
bb64:
  %r836 = add i32 0, 0
  %r837 = add i32 0, 0
  %r838 = add i32 %r380, 0
  %r839 = add i32 0, 0
  %r840 = add i32 0, 0
  %r841 = add i32 0, 0
  %r842 = add i32 0, 0
  %r843 = add i32 0, 0
  br label %bb65

bb65:
  %r896 = phi i32 [ %r841, %bb64 ], [ %r881, %bb70 ]
  %r897 = phi i32 [ %r842, %bb64 ], [ %r878, %bb70 ]
  %r898 = phi i32 [ %r843, %bb64 ], [ %r879, %bb70 ]
  %r899 = phi i32 [ %r836, %bb64 ], [ %r880, %bb70 ]
  %r385 = add i32 %r896, 0
  %r386 = load i32, i32* @n
  %r387 = icmp slt i32 %r896, %r386
  br i1 %r387, label %bb66, label %bb67

bb66:
  %r882 = phi i32 [ %r896, %bb65 ]
  %r883 = phi i32 [ %r897, %bb65 ]
  %r884 = phi i32 [ %r898, %bb65 ]
  %r885 = phi i32 [ %r899, %bb65 ]
  %r388 = add i32 %r882, 0
  %r389 = add i32 %r838, 0
  %r390 = sub i32 %r838, 1
  %r391 = icmp slt i32 %r882, %r390
  br i1 %r391, label %bb68, label %bb69

bb68:
  %r886 = phi i32 [ %r882, %bb66 ]
  %r887 = phi i32 [ %r883, %bb66 ]
  %r888 = phi i32 [ %r884, %bb66 ]
  %r889 = phi i32 [ %r885, %bb66 ]
  %r392 = add i32 %r887, 0
  %r393 = add i32 %r886, 0
  %r394 = getelementptr i32, i32* %r379, i32 %r886
  %r395 = load i32, i32* %r394
  %r396 = add i32 %r887, %r395
  %r890 = add i32 %r396, 0
  br label %bb70

bb69:
  %r855 = phi i32 [ %r882, %bb66 ]
  %r856 = phi i32 [ %r883, %bb66 ]
  %r857 = phi i32 [ %r884, %bb66 ]
  %r858 = phi i32 [ %r885, %bb66 ]
  %r397 = add i32 %r855, 0
  %r398 = add i32 %r838, 0
  %r399 = sub i32 %r838, 1
  %r400 = icmp eq i32 %r855, %r399
  br i1 %r400, label %bb71, label %bb72

bb71:
  %r891 = phi i32 [ %r855, %bb69 ]
  %r892 = phi i32 [ %r856, %bb69 ]
  %r893 = phi i32 [ %r857, %bb69 ]
  %r894 = phi i32 [ %r858, %bb69 ]
  %r401 = getelementptr i32, i32* %r379, i32 0
  %r402 = load i32, i32* %r401
  %r895 = add i32 %r402, 0
  %r403 = getelementptr i32, i32* %r379, i32 0
  %r404 = add i32 %r892, 0
  %r405 = add i32 %r838, 0
  %r406 = sdiv i32 %r892, %r838
  store i32 %r406, i32* %r403
  br label %bb73

bb72:
  %r848 = phi i32 [ %r855, %bb69 ]
  %r849 = phi i32 [ %r856, %bb69 ]
  %r850 = phi i32 [ %r857, %bb69 ]
  %r851 = phi i32 [ %r858, %bb69 ]
  %r407 = add i32 %r849, 0
  %r408 = add i32 %r848, 0
  %r409 = getelementptr i32, i32* %r379, i32 %r848
  %r410 = load i32, i32* %r409
  %r411 = add i32 %r849, %r410
  %r412 = add i32 %r850, 0
  %r413 = sub i32 %r411, %r850
  %r852 = add i32 %r413, 0
  %r415 = add i32 %r848, 0
  %r416 = add i32 %r838, 0
  %r417 = sub i32 %r848, %r838
  %r418 = add i32 %r417, 1
  %r853 = add i32 %r418, 0
  %r419 = add i32 %r853, 0
  %r420 = getelementptr i32, i32* %r379, i32 %r853
  %r421 = load i32, i32* %r420
  %r854 = add i32 %r421, 0
  %r422 = add i32 %r853, 0
  %r423 = getelementptr i32, i32* %r379, i32 %r853
  %r424 = add i32 %r852, 0
  %r425 = add i32 %r838, 0
  %r426 = sdiv i32 %r852, %r838
  store i32 %r426, i32* %r423
  br label %bb73

bb73:
  %r868 = phi i32 [ %r891, %bb71 ], [ %r848, %bb72 ]
  %r869 = phi i32 [ %r892, %bb71 ], [ %r852, %bb72 ]
  %r870 = phi i32 [ %r895, %bb71 ], [ %r854, %bb72 ]
  %r871 = phi i32 [ %r894, %bb71 ], [ %r853, %bb72 ]
  br label %bb70

bb70:
  %r877 = phi i32 [ %r886, %bb68 ], [ %r868, %bb73 ]
  %r878 = phi i32 [ %r890, %bb68 ], [ %r869, %bb73 ]
  %r879 = phi i32 [ %r888, %bb68 ], [ %r870, %bb73 ]
  %r880 = phi i32 [ %r889, %bb68 ], [ %r871, %bb73 ]
  %r427 = add i32 %r877, 0
  %r428 = add i32 %r877, 1
  %r881 = add i32 %r428, 0
  br label %bb65

bb67:
  %r863 = phi i32 [ %r896, %bb65 ]
  %r864 = phi i32 [ %r897, %bb65 ]
  %r865 = phi i32 [ %r898, %bb65 ]
  %r866 = phi i32 [ %r899, %bb65 ]
  %r429 = load i32, i32* @n
  %r430 = add i32 %r838, 0
  %r431 = sub i32 %r429, %r838
  %r432 = add i32 %r431, 1
  %r867 = add i32 %r432, 0
  br label %bb74

bb74:
  %r859 = phi i32 [ %r867, %bb67 ], [ %r876, %bb75 ]
  %r860 = phi i32 [ %r864, %bb67 ], [ %r873, %bb75 ]
  %r861 = phi i32 [ %r865, %bb67 ], [ %r874, %bb75 ]
  %r862 = phi i32 [ %r866, %bb67 ], [ %r875, %bb75 ]
  %r433 = add i32 %r859, 0
  %r434 = load i32, i32* @n
  %r435 = icmp slt i32 %r859, %r434
  br i1 %r435, label %bb75, label %bb76

bb75:
  %r872 = phi i32 [ %r859, %bb74 ]
  %r873 = phi i32 [ %r860, %bb74 ]
  %r874 = phi i32 [ %r861, %bb74 ]
  %r875 = phi i32 [ %r862, %bb74 ]
  %r436 = add i32 %r872, 0
  %r437 = getelementptr i32, i32* %r379, i32 %r872
  store i32 0, i32* %r437
  %r438 = add i32 %r872, 0
  %r439 = add i32 %r872, 1
  %r876 = add i32 %r439, 0
  br label %bb74

bb76:
  %r844 = phi i32 [ %r859, %bb74 ]
  %r845 = phi i32 [ %r860, %bb74 ]
  %r846 = phi i32 [ %r861, %bb74 ]
  %r847 = phi i32 [ %r862, %bb74 ]
  ret i32 0
}

define i32 @main( ) {
bb77:
  call void @_sysy_starttime(i32 209)
  store i32 32, i32* @n
  %r440 = alloca [ 32 x i32 ]
  %r441 = alloca [ 32 x i32 ]
  %r442 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 0
  store i32 7, i32* %r442
  %r443 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 1
  store i32 23, i32* %r443
  %r444 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 2
  store i32 89, i32* %r444
  %r445 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 3
  store i32 26, i32* %r445
  %r446 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 4
  store i32 282, i32* %r446
  %r447 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 5
  store i32 254, i32* %r447
  %r448 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 6
  store i32 27, i32* %r448
  %r449 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 7
  store i32 5, i32* %r449
  %r450 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 8
  store i32 83, i32* %r450
  %r451 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 9
  store i32 273, i32* %r451
  %r452 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 10
  store i32 574, i32* %r452
  %r453 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 11
  store i32 905, i32* %r453
  %r454 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 12
  store i32 354, i32* %r454
  %r455 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 13
  store i32 657, i32* %r455
  %r456 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 14
  store i32 935, i32* %r456
  %r457 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 15
  store i32 264, i32* %r457
  %r458 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 16
  store i32 639, i32* %r458
  %r459 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 17
  store i32 459, i32* %r459
  %r460 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 18
  store i32 29, i32* %r460
  %r461 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 19
  store i32 68, i32* %r461
  %r462 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 20
  store i32 929, i32* %r462
  %r463 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 21
  store i32 756, i32* %r463
  %r464 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 22
  store i32 452, i32* %r464
  %r465 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 23
  store i32 279, i32* %r465
  %r466 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 24
  store i32 58, i32* %r466
  %r467 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 25
  store i32 87, i32* %r467
  %r468 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 26
  store i32 96, i32* %r468
  %r469 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 27
  store i32 36, i32* %r469
  %r470 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 28
  store i32 39, i32* %r470
  %r471 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 29
  store i32 28, i32* %r471
  %r472 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 30
  store i32 1, i32* %r472
  %r473 = getelementptr [32 x i32 ], [32 x i32 ]* %r440, i32 0, i32 31
  store i32 290, i32* %r473
  %r902 = add i32 0, 0
  %r475 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r903 = add i32 %r475, 0
  %r476 = call i32 @revert(i32* %r441)
  %r904 = add i32 %r476, 0
  %r905 = add i32 0, 0
  %r906 = add i32 0, 0
  br label %bb78

bb78:
  %r935 = phi i32 [ %r906, %bb77 ], [ %r940, %bb79 ]
  %r936 = phi i32 [ %r904, %bb77 ], [ %r939, %bb79 ]
  %r478 = add i32 %r935, 0
  %r479 = icmp slt i32 %r935, 32
  br i1 %r479, label %bb79, label %bb80

bb79:
  %r937 = phi i32 [ %r935, %bb78 ]
  %r938 = phi i32 [ %r936, %bb78 ]
  %r480 = add i32 %r937, 0
  %r481 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r937
  %r482 = load i32, i32* %r481
  %r939 = add i32 %r482, 0
  %r483 = add i32 %r939, 0
  call void @putint(i32 %r939)
  %r484 = add i32 %r937, 0
  %r485 = add i32 %r937, 1
  %r940 = add i32 %r485, 0
  br label %bb78

bb80:
  %r960 = phi i32 [ %r935, %bb78 ]
  %r961 = phi i32 [ %r936, %bb78 ]
  %r486 = call i32 @bubblesort(i32* %r441)
  %r962 = add i32 %r486, 0
  %r963 = add i32 0, 0
  br label %bb81

bb81:
  %r941 = phi i32 [ %r963, %bb80 ], [ %r946, %bb82 ]
  %r942 = phi i32 [ %r962, %bb80 ], [ %r945, %bb82 ]
  %r487 = add i32 %r941, 0
  %r488 = icmp slt i32 %r941, 32
  br i1 %r488, label %bb82, label %bb83

bb82:
  %r943 = phi i32 [ %r941, %bb81 ]
  %r944 = phi i32 [ %r942, %bb81 ]
  %r489 = add i32 %r943, 0
  %r490 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r943
  %r491 = load i32, i32* %r490
  %r945 = add i32 %r491, 0
  %r492 = add i32 %r945, 0
  call void @putint(i32 %r945)
  %r493 = add i32 %r943, 0
  %r494 = add i32 %r943, 1
  %r946 = add i32 %r494, 0
  br label %bb81

bb83:
  %r972 = phi i32 [ %r941, %bb81 ]
  %r973 = phi i32 [ %r942, %bb81 ]
  %r495 = call i32 @getMid(i32* %r441)
  %r974 = add i32 %r495, 0
  %r496 = add i32 %r974, 0
  call void @putint(i32 %r974)
  %r497 = call i32 @getMost(i32* %r441)
  %r975 = add i32 %r497, 0
  %r498 = add i32 %r975, 0
  call void @putint(i32 %r975)
  %r499 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r976 = add i32 %r499, 0
  %r500 = call i32 @bubblesort(i32* %r441)
  %r977 = add i32 %r500, 0
  %r978 = add i32 0, 0
  br label %bb84

bb84:
  %r968 = phi i32 [ %r978, %bb83 ], [ %r950, %bb85 ]
  %r969 = phi i32 [ %r977, %bb83 ], [ %r949, %bb85 ]
  %r501 = add i32 %r968, 0
  %r502 = icmp slt i32 %r968, 32
  br i1 %r502, label %bb85, label %bb86

bb85:
  %r947 = phi i32 [ %r968, %bb84 ]
  %r948 = phi i32 [ %r969, %bb84 ]
  %r503 = add i32 %r947, 0
  %r504 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r947
  %r505 = load i32, i32* %r504
  %r949 = add i32 %r505, 0
  %r506 = add i32 %r949, 0
  call void @putint(i32 %r949)
  %r507 = add i32 %r947, 0
  %r508 = add i32 %r947, 1
  %r950 = add i32 %r508, 0
  br label %bb84

bb86:
  %r955 = phi i32 [ %r968, %bb84 ]
  %r956 = phi i32 [ %r969, %bb84 ]
  %r509 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r957 = add i32 %r509, 0
  %r510 = call i32 @insertsort(i32* %r441)
  %r958 = add i32 %r510, 0
  %r959 = add i32 0, 0
  br label %bb87

bb87:
  %r928 = phi i32 [ %r959, %bb86 ], [ %r925, %bb88 ]
  %r929 = phi i32 [ %r958, %bb86 ], [ %r924, %bb88 ]
  %r511 = add i32 %r928, 0
  %r512 = icmp slt i32 %r928, 32
  br i1 %r512, label %bb88, label %bb89

bb88:
  %r922 = phi i32 [ %r928, %bb87 ]
  %r923 = phi i32 [ %r929, %bb87 ]
  %r513 = add i32 %r922, 0
  %r514 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r922
  %r515 = load i32, i32* %r514
  %r924 = add i32 %r515, 0
  %r516 = add i32 %r924, 0
  call void @putint(i32 %r924)
  %r517 = add i32 %r922, 0
  %r518 = add i32 %r922, 1
  %r925 = add i32 %r518, 0
  br label %bb87

bb89:
  %r916 = phi i32 [ %r928, %bb87 ]
  %r917 = phi i32 [ %r929, %bb87 ]
  %r519 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r918 = add i32 %r519, 0
  %r919 = add i32 0, 0
  %r920 = add i32 31, 0
  %r520 = add i32 %r919, 0
  %r521 = add i32 %r920, 0
  %r522 = call i32 @QuickSort(i32* %r441, i32 %r919, i32 %r920)
  %r921 = add i32 %r522, 0
  br label %bb90

bb90:
  %r914 = phi i32 [ %r919, %bb89 ], [ %r967, %bb91 ]
  %r915 = phi i32 [ %r921, %bb89 ], [ %r966, %bb91 ]
  %r523 = add i32 %r914, 0
  %r524 = icmp slt i32 %r914, 32
  br i1 %r524, label %bb91, label %bb92

bb91:
  %r964 = phi i32 [ %r914, %bb90 ]
  %r965 = phi i32 [ %r915, %bb90 ]
  %r525 = add i32 %r964, 0
  %r526 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r964
  %r527 = load i32, i32* %r526
  %r966 = add i32 %r527, 0
  %r528 = add i32 %r966, 0
  call void @putint(i32 %r966)
  %r529 = add i32 %r964, 0
  %r530 = add i32 %r964, 1
  %r967 = add i32 %r530, 0
  br label %bb90

bb92:
  %r930 = phi i32 [ %r914, %bb90 ]
  %r931 = phi i32 [ %r915, %bb90 ]
  %r531 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r932 = add i32 %r531, 0
  %r532 = call i32 @calSum(i32* %r441, i32 4)
  %r933 = add i32 %r532, 0
  %r934 = add i32 0, 0
  br label %bb93

bb93:
  %r970 = phi i32 [ %r934, %bb92 ], [ %r982, %bb94 ]
  %r971 = phi i32 [ %r933, %bb92 ], [ %r981, %bb94 ]
  %r533 = add i32 %r970, 0
  %r534 = icmp slt i32 %r970, 32
  br i1 %r534, label %bb94, label %bb95

bb94:
  %r979 = phi i32 [ %r970, %bb93 ]
  %r980 = phi i32 [ %r971, %bb93 ]
  %r535 = add i32 %r979, 0
  %r536 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r979
  %r537 = load i32, i32* %r536
  %r981 = add i32 %r537, 0
  %r538 = add i32 %r981, 0
  call void @putint(i32 %r981)
  %r539 = add i32 %r979, 0
  %r540 = add i32 %r979, 1
  %r982 = add i32 %r540, 0
  br label %bb93

bb95:
  %r909 = phi i32 [ %r970, %bb93 ]
  %r910 = phi i32 [ %r971, %bb93 ]
  %r541 = call i32 @arrCopy(i32* %r440, i32* %r441)
  %r911 = add i32 %r541, 0
  %r542 = call i32 @avgPooling(i32* %r441, i32 3)
  %r912 = add i32 %r542, 0
  %r913 = add i32 0, 0
  br label %bb96

bb96:
  %r926 = phi i32 [ %r913, %bb95 ], [ %r954, %bb97 ]
  %r927 = phi i32 [ %r912, %bb95 ], [ %r953, %bb97 ]
  %r543 = add i32 %r926, 0
  %r544 = icmp slt i32 %r926, 32
  br i1 %r544, label %bb97, label %bb98

bb97:
  %r951 = phi i32 [ %r926, %bb96 ]
  %r952 = phi i32 [ %r927, %bb96 ]
  %r545 = add i32 %r951, 0
  %r546 = getelementptr [32 x i32 ], [32 x i32 ]* %r441, i32 0, i32 %r951
  %r547 = load i32, i32* %r546
  %r953 = add i32 %r547, 0
  %r548 = add i32 %r953, 0
  call void @putint(i32 %r953)
  %r549 = add i32 %r951, 0
  %r550 = add i32 %r951, 1
  %r954 = add i32 %r550, 0
  br label %bb96

bb98:
  %r907 = phi i32 [ %r926, %bb96 ]
  %r908 = phi i32 [ %r927, %bb96 ]
  call void @_sysy_stoptime(i32 312)
  ret i32 0
}

