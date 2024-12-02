declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@base = global i32 16
@a = global [ 30000010 x i32 ] zeroinitializer
@ans = global i32 0
define i32 @getMaxNum( i32 %r100, i32* %r102 ) {
bb1:
  %r377 = add i32 0, 0
  %r378 = add i32 %r100, 0
  %r379 = add i32 0, 0
  %r380 = add i32 0, 0
  %r381 = add i32 0, 0
  %r382 = add i32 0, 0
  br label %bb2

bb2:
  %r390 = phi i32 [ %r382, %bb1 ], [ %r387, %bb6 ]
  %r391 = phi i32 [ %r380, %bb1 ], [ %r386, %bb6 ]
  %r105 = add i32 %r390, 0
  %r106 = add i32 %r378, 0
  %r107 = icmp slt i32 %r390, %r378
  br i1 %r107, label %bb3, label %bb4

bb3:
  %r388 = phi i32 [ %r390, %bb2 ]
  %r389 = phi i32 [ %r391, %bb2 ]
  %r108 = add i32 %r388, 0
  %r109 = getelementptr i32, i32* %r102, i32 %r388
  %r110 = load i32, i32* %r109
  %r111 = add i32 %r389, 0
  %r112 = icmp sgt i32 %r110, %r389
  br i1 %r112, label %bb5, label %bb6

bb5:
  %r392 = phi i32 [ %r388, %bb3 ]
  %r393 = phi i32 [ %r389, %bb3 ]
  %r113 = add i32 %r392, 0
  %r114 = getelementptr i32, i32* %r102, i32 %r392
  %r115 = load i32, i32* %r114
  %r394 = add i32 %r115, 0
  br label %bb6

bb6:
  %r385 = phi i32 [ %r388, %bb3 ], [ %r392, %bb5 ]
  %r386 = phi i32 [ %r389, %bb3 ], [ %r394, %bb5 ]
  %r116 = add i32 %r385, 0
  %r117 = add i32 %r385, 1
  %r387 = add i32 %r117, 0
  br label %bb2

bb4:
  %r383 = phi i32 [ %r390, %bb2 ]
  %r384 = phi i32 [ %r391, %bb2 ]
  %r118 = add i32 %r384, 0
  ret i32 %r384
}

define i32 @getNumPos( i32 %r119, i32 %r121 ) {
bb7:
  %r399 = add i32 0, 0
  %r400 = add i32 %r119, 0
  %r401 = add i32 0, 0
  %r402 = add i32 %r121, 0
  %r403 = add i32 1, 0
  %r404 = add i32 0, 0
  %r405 = add i32 0, 0
  br label %bb8

bb8:
  %r412 = phi i32 [ %r405, %bb7 ], [ %r411, %bb9 ]
  %r413 = phi i32 [ %r400, %bb7 ], [ %r410, %bb9 ]
  %r125 = add i32 %r412, 0
  %r126 = add i32 %r402, 0
  %r127 = icmp slt i32 %r412, %r402
  br i1 %r127, label %bb9, label %bb10

bb9:
  %r408 = phi i32 [ %r412, %bb8 ]
  %r409 = phi i32 [ %r413, %bb8 ]
  %r128 = add i32 %r409, 0
  %r129 = load i32, i32* @base
  %r130 = sdiv i32 %r409, %r129
  %r410 = add i32 %r130, 0
  %r131 = add i32 %r408, 0
  %r132 = add i32 %r408, 1
  %r411 = add i32 %r132, 0
  br label %bb8

bb10:
  %r406 = phi i32 [ %r412, %bb8 ]
  %r407 = phi i32 [ %r413, %bb8 ]
  %r133 = add i32 %r407, 0
  %r134 = add i32 %r407, 0
  %r135 = load i32, i32* @base
  %r136 = sdiv i32 %r407, %r135
  %r137 = load i32, i32* @base
  %r138 = mul i32 %r136, %r137
  %r139 = sub i32 %r407, %r138
  ret i32 %r139
}

define void @radixSort( i32 %r140, i32* %r142, i32 %r143, i32 %r145 ) {
bb11:
  %r429 = add i32 0, 0
  %r430 = add i32 0, 0
  %r431 = add i32 0, 0
  %r432 = add i32 0, 0
  %r433 = add i32 0, 0
  %r434 = add i32 0, 0
  %r435 = add i32 0, 0
  %r436 = add i32 0, 0
  %r437 = add i32 0, 0
  %r438 = add i32 0, 0
  %r439 = add i32 0, 0
  %r440 = add i32 0, 0
  %r441 = add i32 %r140, 0
  %r442 = add i32 0, 0
  %r443 = add i32 %r143, 0
  %r444 = add i32 0, 0
  %r445 = add i32 %r145, 0
  %r147 = alloca [ 16 x i32 ]
  %r148 = alloca [ 16 x i32 ]
  %r149 = alloca [ 16 x i32 ]
  %r446 = add i32 0, 0
  %r447 = add i32 0, 0
  br label %bb12

bb12:
  %r475 = phi i32 [ %r447, %bb11 ], [ %r664, %bb13 ]
  %r151 = add i32 %r475, 0
  %r152 = load i32, i32* @base
  %r153 = icmp slt i32 %r475, %r152
  br i1 %r153, label %bb13, label %bb14

bb13:
  %r663 = phi i32 [ %r475, %bb12 ]
  %r154 = add i32 %r663, 0
  %r155 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r663
  store i32 0, i32* %r155
  %r156 = add i32 %r663, 0
  %r157 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r663
  store i32 0, i32* %r157
  %r158 = add i32 %r663, 0
  %r159 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r663
  store i32 0, i32* %r159
  %r160 = add i32 %r663, 0
  %r161 = add i32 %r663, 1
  %r664 = add i32 %r161, 0
  br label %bb12

bb14:
  %r474 = phi i32 [ %r475, %bb12 ]
  %r162 = add i32 %r441, 0
  %r163 = icmp eq i32 %r441, -1
  br i1 %r163, label %bb15, label %bb17

bb17:
  %r460 = phi i32 [ %r474, %bb14 ]
  %r164 = add i32 %r443, 0
  %r165 = add i32 %r443, 1
  %r166 = add i32 %r445, 0
  %r167 = icmp sge i32 %r165, %r445
  br i1 %r167, label %bb15, label %bb16

bb15:
  %r615 = phi i32 [ %r474, %bb14 ], [ %r460, %bb17 ]
  ret void
bb16:
  %r636 = phi i32 [ %r460, %bb17 ]
  %r169 = add i32 %r443, 0
  %r637 = add i32 %r443, 0
  br label %bb18

bb18:
  %r638 = phi i32 [ %r437, %bb16 ], [ %r634, %bb19 ]
  %r639 = phi i32 [ %r637, %bb16 ], [ %r635, %bb19 ]
  %r640 = phi i32 [ %r438, %bb16 ], [ %r633, %bb19 ]
  %r641 = phi i32 [ %r636, %bb16 ], [ %r632, %bb19 ]
  %r170 = add i32 %r639, 0
  %r171 = add i32 %r445, 0
  %r172 = icmp slt i32 %r639, %r445
  br i1 %r172, label %bb19, label %bb20

bb19:
  %r629 = phi i32 [ %r638, %bb18 ]
  %r630 = phi i32 [ %r639, %bb18 ]
  %r631 = phi i32 [ %r640, %bb18 ]
  %r632 = phi i32 [ %r641, %bb18 ]
  %r174 = add i32 %r630, 0
  %r175 = getelementptr i32, i32* %r142, i32 %r630
  %r176 = load i32, i32* %r175
  %r177 = add i32 %r441, 0
  %r178 = call i32 @getNumPos(i32 %r176, i32 %r441)
  %r633 = add i32 %r178, 0
  %r180 = add i32 %r630, 0
  %r181 = getelementptr i32, i32* %r142, i32 %r630
  %r182 = load i32, i32* %r181
  %r183 = add i32 %r441, 0
  %r184 = call i32 @getNumPos(i32 %r182, i32 %r441)
  %r634 = add i32 %r184, 0
  %r185 = add i32 %r634, 0
  %r186 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r634
  %r187 = add i32 %r633, 0
  %r188 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r633
  %r189 = load i32, i32* %r188
  %r190 = add i32 %r189, 1
  store i32 %r190, i32* %r186
  %r191 = add i32 %r630, 0
  %r192 = add i32 %r630, 1
  %r635 = add i32 %r192, 0
  br label %bb18

bb20:
  %r658 = phi i32 [ %r638, %bb18 ]
  %r659 = phi i32 [ %r639, %bb18 ]
  %r660 = phi i32 [ %r640, %bb18 ]
  %r661 = phi i32 [ %r641, %bb18 ]
  %r193 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 0
  %r194 = add i32 %r443, 0
  store i32 %r194, i32* %r193
  %r195 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 0
  %r196 = add i32 %r443, 0
  %r197 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 0
  %r198 = load i32, i32* %r197
  %r199 = add i32 %r443, %r198
  store i32 %r199, i32* %r195
  %r662 = add i32 1, 0
  br label %bb21

bb21:
  %r642 = phi i32 [ %r658, %bb20 ], [ %r578, %bb22 ]
  %r643 = phi i32 [ %r662, %bb20 ], [ %r584, %bb22 ]
  %r644 = phi i32 [ %r660, %bb20 ], [ %r580, %bb22 ]
  %r645 = phi i32 [ %r436, %bb20 ], [ %r583, %bb22 ]
  %r646 = phi i32 [ %r661, %bb20 ], [ %r582, %bb22 ]
  %r200 = add i32 %r643, 0
  %r201 = load i32, i32* @base
  %r202 = icmp slt i32 %r643, %r201
  br i1 %r202, label %bb22, label %bb23

bb22:
  %r578 = phi i32 [ %r642, %bb21 ]
  %r579 = phi i32 [ %r643, %bb21 ]
  %r580 = phi i32 [ %r644, %bb21 ]
  %r581 = phi i32 [ %r645, %bb21 ]
  %r582 = phi i32 [ %r646, %bb21 ]
  %r204 = add i32 %r579, 0
  %r205 = sub i32 %r579, 1
  %r583 = add i32 %r205, 0
  %r206 = add i32 %r579, 0
  %r207 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r579
  %r208 = add i32 %r583, 0
  %r209 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r583
  %r210 = load i32, i32* %r209
  store i32 %r210, i32* %r207
  %r211 = add i32 %r579, 0
  %r212 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r579
  %r213 = add i32 %r579, 0
  %r214 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r579
  %r215 = load i32, i32* %r214
  %r216 = add i32 %r579, 0
  %r217 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r579
  %r218 = load i32, i32* %r217
  %r219 = add i32 %r215, %r218
  store i32 %r219, i32* %r212
  %r220 = add i32 %r579, 0
  %r221 = add i32 %r579, 1
  %r584 = add i32 %r221, 0
  br label %bb21

bb23:
  %r597 = phi i32 [ %r642, %bb21 ]
  %r598 = phi i32 [ %r643, %bb21 ]
  %r599 = phi i32 [ %r644, %bb21 ]
  %r600 = phi i32 [ %r645, %bb21 ]
  %r601 = phi i32 [ %r646, %bb21 ]
  %r602 = add i32 0, 0
  br label %bb24

bb24:
  %r531 = phi i32 [ %r597, %bb23 ], [ %r542, %bb29 ]
  %r532 = phi i32 [ %r602, %bb23 ], [ %r553, %bb29 ]
  %r533 = phi i32 [ %r599, %bb23 ], [ %r544, %bb29 ]
  %r534 = phi i32 [ %r600, %bb23 ], [ %r545, %bb29 ]
  %r535 = phi i32 [ %r432, %bb23 ], [ %r546, %bb29 ]
  %r536 = phi i32 [ %r433, %bb23 ], [ %r547, %bb29 ]
  %r537 = phi i32 [ %r431, %bb23 ], [ %r548, %bb29 ]
  %r538 = phi i32 [ %r430, %bb23 ], [ %r549, %bb29 ]
  %r539 = phi i32 [ %r434, %bb23 ], [ %r550, %bb29 ]
  %r540 = phi i32 [ %r435, %bb23 ], [ %r551, %bb29 ]
  %r541 = phi i32 [ %r601, %bb23 ], [ %r552, %bb29 ]
  %r222 = add i32 %r532, 0
  %r223 = load i32, i32* @base
  %r224 = icmp slt i32 %r532, %r223
  br i1 %r224, label %bb25, label %bb26

bb25:
  %r554 = phi i32 [ %r531, %bb24 ]
  %r555 = phi i32 [ %r532, %bb24 ]
  %r556 = phi i32 [ %r533, %bb24 ]
  %r557 = phi i32 [ %r534, %bb24 ]
  %r558 = phi i32 [ %r535, %bb24 ]
  %r559 = phi i32 [ %r536, %bb24 ]
  %r560 = phi i32 [ %r537, %bb24 ]
  %r561 = phi i32 [ %r538, %bb24 ]
  %r562 = phi i32 [ %r539, %bb24 ]
  %r563 = phi i32 [ %r540, %bb24 ]
  %r564 = phi i32 [ %r541, %bb24 ]
  br label %bb27

bb27:
  %r476 = phi i32 [ %r554, %bb25 ], [ %r603, %bb32 ]
  %r477 = phi i32 [ %r555, %bb25 ], [ %r604, %bb32 ]
  %r478 = phi i32 [ %r556, %bb25 ], [ %r605, %bb32 ]
  %r479 = phi i32 [ %r557, %bb25 ], [ %r606, %bb32 ]
  %r480 = phi i32 [ %r558, %bb25 ], [ %r607, %bb32 ]
  %r481 = phi i32 [ %r559, %bb25 ], [ %r608, %bb32 ]
  %r482 = phi i32 [ %r560, %bb25 ], [ %r609, %bb32 ]
  %r483 = phi i32 [ %r561, %bb25 ], [ %r614, %bb32 ]
  %r484 = phi i32 [ %r562, %bb25 ], [ %r611, %bb32 ]
  %r485 = phi i32 [ %r563, %bb25 ], [ %r612, %bb32 ]
  %r486 = phi i32 [ %r564, %bb25 ], [ %r613, %bb32 ]
  %r225 = add i32 %r477, 0
  %r226 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r477
  %r227 = load i32, i32* %r226
  %r228 = add i32 %r477, 0
  %r229 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r477
  %r230 = load i32, i32* %r229
  %r231 = icmp slt i32 %r227, %r230
  br i1 %r231, label %bb28, label %bb29

bb28:
  %r499 = phi i32 [ %r476, %bb27 ]
  %r500 = phi i32 [ %r477, %bb27 ]
  %r501 = phi i32 [ %r478, %bb27 ]
  %r502 = phi i32 [ %r479, %bb27 ]
  %r503 = phi i32 [ %r480, %bb27 ]
  %r504 = phi i32 [ %r481, %bb27 ]
  %r505 = phi i32 [ %r482, %bb27 ]
  %r506 = phi i32 [ %r483, %bb27 ]
  %r507 = phi i32 [ %r484, %bb27 ]
  %r508 = phi i32 [ %r485, %bb27 ]
  %r509 = phi i32 [ %r486, %bb27 ]
  %r233 = add i32 %r500, 0
  %r234 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r500
  %r235 = load i32, i32* %r234
  %r510 = add i32 %r235, 0
  %r237 = add i32 %r510, 0
  %r238 = getelementptr i32, i32* %r142, i32 %r510
  %r239 = load i32, i32* %r238
  %r511 = add i32 %r239, 0
  br label %bb30

bb30:
  %r647 = phi i32 [ %r499, %bb28 ], [ %r512, %bb31 ]
  %r648 = phi i32 [ %r500, %bb28 ], [ %r513, %bb31 ]
  %r649 = phi i32 [ %r501, %bb28 ], [ %r514, %bb31 ]
  %r650 = phi i32 [ %r502, %bb28 ], [ %r515, %bb31 ]
  %r651 = phi i32 [ %r503, %bb28 ], [ %r529, %bb31 ]
  %r652 = phi i32 [ %r504, %bb28 ], [ %r523, %bb31 ]
  %r653 = phi i32 [ %r505, %bb28 ], [ %r530, %bb31 ]
  %r654 = phi i32 [ %r506, %bb28 ], [ %r519, %bb31 ]
  %r655 = phi i32 [ %r511, %bb28 ], [ %r526, %bb31 ]
  %r656 = phi i32 [ %r510, %bb28 ], [ %r521, %bb31 ]
  %r657 = phi i32 [ %r509, %bb28 ], [ %r522, %bb31 ]
  %r240 = add i32 %r655, 0
  %r241 = add i32 %r441, 0
  %r242 = call i32 @getNumPos(i32 %r655, i32 %r441)
  %r243 = add i32 %r648, 0
  %r244 = icmp ne i32 %r242, %r648
  br i1 %r244, label %bb31, label %bb32

bb31:
  %r512 = phi i32 [ %r647, %bb30 ]
  %r513 = phi i32 [ %r648, %bb30 ]
  %r514 = phi i32 [ %r649, %bb30 ]
  %r515 = phi i32 [ %r650, %bb30 ]
  %r516 = phi i32 [ %r651, %bb30 ]
  %r517 = phi i32 [ %r652, %bb30 ]
  %r518 = phi i32 [ %r653, %bb30 ]
  %r519 = phi i32 [ %r654, %bb30 ]
  %r520 = phi i32 [ %r655, %bb30 ]
  %r521 = phi i32 [ %r656, %bb30 ]
  %r522 = phi i32 [ %r657, %bb30 ]
  %r246 = add i32 %r520, 0
  %r523 = add i32 %r520, 0
  %r248 = add i32 %r523, 0
  %r249 = add i32 %r441, 0
  %r250 = call i32 @getNumPos(i32 %r523, i32 %r441)
  %r524 = add i32 %r250, 0
  %r251 = add i32 %r524, 0
  %r252 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r524
  %r253 = load i32, i32* %r252
  %r525 = add i32 %r253, 0
  %r254 = add i32 %r525, 0
  %r255 = getelementptr i32, i32* %r142, i32 %r525
  %r256 = load i32, i32* %r255
  %r526 = add i32 %r256, 0
  %r257 = add i32 %r523, 0
  %r258 = add i32 %r441, 0
  %r259 = call i32 @getNumPos(i32 %r523, i32 %r441)
  %r527 = add i32 %r259, 0
  %r260 = add i32 %r527, 0
  %r261 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r527
  %r262 = load i32, i32* %r261
  %r528 = add i32 %r262, 0
  %r263 = add i32 %r528, 0
  %r264 = getelementptr i32, i32* %r142, i32 %r528
  %r265 = add i32 %r523, 0
  store i32 %r265, i32* %r264
  %r266 = add i32 %r523, 0
  %r267 = add i32 %r441, 0
  %r268 = call i32 @getNumPos(i32 %r523, i32 %r441)
  %r529 = add i32 %r268, 0
  %r270 = add i32 %r523, 0
  %r271 = add i32 %r441, 0
  %r272 = call i32 @getNumPos(i32 %r523, i32 %r441)
  %r530 = add i32 %r272, 0
  %r273 = add i32 %r530, 0
  %r274 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r530
  %r275 = add i32 %r529, 0
  %r276 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r529
  %r277 = load i32, i32* %r276
  %r278 = add i32 %r277, 1
  store i32 %r278, i32* %r274
  br label %bb30

bb32:
  %r603 = phi i32 [ %r647, %bb30 ]
  %r604 = phi i32 [ %r648, %bb30 ]
  %r605 = phi i32 [ %r649, %bb30 ]
  %r606 = phi i32 [ %r650, %bb30 ]
  %r607 = phi i32 [ %r651, %bb30 ]
  %r608 = phi i32 [ %r652, %bb30 ]
  %r609 = phi i32 [ %r653, %bb30 ]
  %r610 = phi i32 [ %r654, %bb30 ]
  %r611 = phi i32 [ %r655, %bb30 ]
  %r612 = phi i32 [ %r656, %bb30 ]
  %r613 = phi i32 [ %r657, %bb30 ]
  %r280 = add i32 %r604, 0
  %r281 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r604
  %r282 = load i32, i32* %r281
  %r614 = add i32 %r282, 0
  %r283 = add i32 %r614, 0
  %r284 = getelementptr i32, i32* %r142, i32 %r614
  %r285 = add i32 %r611, 0
  store i32 %r285, i32* %r284
  %r286 = add i32 %r604, 0
  %r287 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r604
  %r288 = add i32 %r604, 0
  %r289 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r604
  %r290 = load i32, i32* %r289
  %r291 = add i32 %r290, 1
  store i32 %r291, i32* %r287
  br label %bb27

bb29:
  %r542 = phi i32 [ %r476, %bb27 ]
  %r543 = phi i32 [ %r477, %bb27 ]
  %r544 = phi i32 [ %r478, %bb27 ]
  %r545 = phi i32 [ %r479, %bb27 ]
  %r546 = phi i32 [ %r480, %bb27 ]
  %r547 = phi i32 [ %r481, %bb27 ]
  %r548 = phi i32 [ %r482, %bb27 ]
  %r549 = phi i32 [ %r483, %bb27 ]
  %r550 = phi i32 [ %r484, %bb27 ]
  %r551 = phi i32 [ %r485, %bb27 ]
  %r552 = phi i32 [ %r486, %bb27 ]
  %r292 = add i32 %r543, 0
  %r293 = add i32 %r543, 1
  %r553 = add i32 %r293, 0
  br label %bb24

bb26:
  %r565 = phi i32 [ %r531, %bb24 ]
  %r566 = phi i32 [ %r532, %bb24 ]
  %r567 = phi i32 [ %r533, %bb24 ]
  %r568 = phi i32 [ %r534, %bb24 ]
  %r569 = phi i32 [ %r535, %bb24 ]
  %r570 = phi i32 [ %r536, %bb24 ]
  %r571 = phi i32 [ %r537, %bb24 ]
  %r572 = phi i32 [ %r538, %bb24 ]
  %r573 = phi i32 [ %r539, %bb24 ]
  %r574 = phi i32 [ %r540, %bb24 ]
  %r575 = phi i32 [ %r541, %bb24 ]
  %r294 = add i32 %r443, 0
  %r576 = add i32 %r443, 0
  %r295 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 0
  %r296 = add i32 %r443, 0
  store i32 %r296, i32* %r295
  %r297 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 0
  %r298 = add i32 %r443, 0
  %r299 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 0
  %r300 = load i32, i32* %r299
  %r301 = add i32 %r443, %r300
  store i32 %r301, i32* %r297
  %r577 = add i32 0, 0
  br label %bb33

bb33:
  %r487 = phi i32 [ %r565, %bb26 ], [ %r461, %bb37 ]
  %r488 = phi i32 [ %r577, %bb26 ], [ %r473, %bb37 ]
  %r489 = phi i32 [ %r567, %bb26 ], [ %r463, %bb37 ]
  %r490 = phi i32 [ %r568, %bb26 ], [ %r464, %bb37 ]
  %r491 = phi i32 [ %r569, %bb26 ], [ %r465, %bb37 ]
  %r492 = phi i32 [ %r570, %bb26 ], [ %r466, %bb37 ]
  %r493 = phi i32 [ %r571, %bb26 ], [ %r467, %bb37 ]
  %r494 = phi i32 [ %r572, %bb26 ], [ %r468, %bb37 ]
  %r495 = phi i32 [ %r573, %bb26 ], [ %r469, %bb37 ]
  %r496 = phi i32 [ %r429, %bb26 ], [ %r470, %bb37 ]
  %r497 = phi i32 [ %r574, %bb26 ], [ %r471, %bb37 ]
  %r498 = phi i32 [ %r575, %bb26 ], [ %r472, %bb37 ]
  %r302 = add i32 %r488, 0
  %r303 = load i32, i32* @base
  %r304 = icmp slt i32 %r488, %r303
  br i1 %r304, label %bb34, label %bb35

bb34:
  %r585 = phi i32 [ %r487, %bb33 ]
  %r586 = phi i32 [ %r488, %bb33 ]
  %r587 = phi i32 [ %r489, %bb33 ]
  %r588 = phi i32 [ %r490, %bb33 ]
  %r589 = phi i32 [ %r491, %bb33 ]
  %r590 = phi i32 [ %r492, %bb33 ]
  %r591 = phi i32 [ %r493, %bb33 ]
  %r592 = phi i32 [ %r494, %bb33 ]
  %r593 = phi i32 [ %r495, %bb33 ]
  %r594 = phi i32 [ %r496, %bb33 ]
  %r595 = phi i32 [ %r497, %bb33 ]
  %r596 = phi i32 [ %r498, %bb33 ]
  %r305 = add i32 %r586, 0
  %r306 = icmp sgt i32 %r586, 0
  br i1 %r306, label %bb36, label %bb37

bb36:
  %r616 = phi i32 [ %r585, %bb34 ]
  %r617 = phi i32 [ %r586, %bb34 ]
  %r618 = phi i32 [ %r587, %bb34 ]
  %r619 = phi i32 [ %r588, %bb34 ]
  %r620 = phi i32 [ %r589, %bb34 ]
  %r621 = phi i32 [ %r590, %bb34 ]
  %r622 = phi i32 [ %r591, %bb34 ]
  %r623 = phi i32 [ %r592, %bb34 ]
  %r624 = phi i32 [ %r593, %bb34 ]
  %r625 = phi i32 [ %r594, %bb34 ]
  %r626 = phi i32 [ %r595, %bb34 ]
  %r627 = phi i32 [ %r596, %bb34 ]
  %r308 = add i32 %r617, 0
  %r309 = sub i32 %r617, 1
  %r628 = add i32 %r309, 0
  %r310 = add i32 %r617, 0
  %r311 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r617
  %r312 = add i32 %r628, 0
  %r313 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r628
  %r314 = load i32, i32* %r313
  store i32 %r314, i32* %r311
  %r315 = add i32 %r617, 0
  %r316 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r617
  %r317 = add i32 %r617, 0
  %r318 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r617
  %r319 = load i32, i32* %r318
  %r320 = add i32 %r617, 0
  %r321 = getelementptr [16 x i32 ], [16 x i32 ]* %r149, i32 0, i32 %r617
  %r322 = load i32, i32* %r321
  %r323 = add i32 %r319, %r322
  store i32 %r323, i32* %r316
  br label %bb37

bb37:
  %r461 = phi i32 [ %r585, %bb34 ], [ %r616, %bb36 ]
  %r462 = phi i32 [ %r586, %bb34 ], [ %r617, %bb36 ]
  %r463 = phi i32 [ %r587, %bb34 ], [ %r618, %bb36 ]
  %r464 = phi i32 [ %r588, %bb34 ], [ %r619, %bb36 ]
  %r465 = phi i32 [ %r589, %bb34 ], [ %r620, %bb36 ]
  %r466 = phi i32 [ %r590, %bb34 ], [ %r621, %bb36 ]
  %r467 = phi i32 [ %r591, %bb34 ], [ %r622, %bb36 ]
  %r468 = phi i32 [ %r592, %bb34 ], [ %r623, %bb36 ]
  %r469 = phi i32 [ %r593, %bb34 ], [ %r624, %bb36 ]
  %r470 = phi i32 [ %r594, %bb34 ], [ %r628, %bb36 ]
  %r471 = phi i32 [ %r595, %bb34 ], [ %r626, %bb36 ]
  %r472 = phi i32 [ %r596, %bb34 ], [ %r627, %bb36 ]
  %r324 = add i32 %r441, 0
  %r325 = sub i32 %r441, 1
  %r326 = add i32 %r462, 0
  %r327 = getelementptr [16 x i32 ], [16 x i32 ]* %r147, i32 0, i32 %r462
  %r328 = load i32, i32* %r327
  %r329 = add i32 %r462, 0
  %r330 = getelementptr [16 x i32 ], [16 x i32 ]* %r148, i32 0, i32 %r462
  %r331 = load i32, i32* %r330
  call void @radixSort(i32 %r325, i32* %r142, i32 %r328, i32 %r331)
  %r332 = add i32 %r462, 0
  %r333 = add i32 %r462, 1
  %r473 = add i32 %r333, 0
  br label %bb33

bb35:
  %r448 = phi i32 [ %r487, %bb33 ]
  %r449 = phi i32 [ %r488, %bb33 ]
  %r450 = phi i32 [ %r489, %bb33 ]
  %r451 = phi i32 [ %r490, %bb33 ]
  %r452 = phi i32 [ %r491, %bb33 ]
  %r453 = phi i32 [ %r492, %bb33 ]
  %r454 = phi i32 [ %r493, %bb33 ]
  %r455 = phi i32 [ %r494, %bb33 ]
  %r456 = phi i32 [ %r495, %bb33 ]
  %r457 = phi i32 [ %r496, %bb33 ]
  %r458 = phi i32 [ %r497, %bb33 ]
  %r459 = phi i32 [ %r498, %bb33 ]
  ret void
}

define i32 @main( ) {
bb38:
  %r668 = add i32 0, 0
  %r669 = add i32 0, 0
  %r335 = call i32 @getint()
  %r670 = add i32 %r335, 0
  %r671 = add i32 0, 0
  %r672 = add i32 0, 0
  br label %bb39

bb39:
  %r688 = phi i32 [ %r672, %bb38 ], [ %r685, %bb40 ]
  %r337 = add i32 %r688, 0
  %r338 = add i32 %r670, 0
  %r339 = icmp slt i32 %r688, %r670
  br i1 %r339, label %bb40, label %bb41

bb40:
  %r684 = phi i32 [ %r688, %bb39 ]
  %r340 = add i32 %r684, 0
  %r341 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r684
  %r342 = call i32 @getint()
  store i32 %r342, i32* %r341
  %r343 = add i32 %r684, 0
  %r344 = add i32 %r684, 1
  %r685 = add i32 %r344, 0
  br label %bb39

bb41:
  %r686 = phi i32 [ %r688, %bb39 ]
  call void @_sysy_starttime(i32 97)
  %r345 = add i32 %r670, 0
  call void @radixSort(i32 8, i32* @a, i32 0, i32 %r670)
  %r687 = add i32 0, 0
  br label %bb42

bb42:
  %r682 = phi i32 [ %r687, %bb41 ], [ %r675, %bb43 ]
  %r683 = phi i32 [ %r686, %bb41 ], [ %r674, %bb43 ]
  %r347 = add i32 %r682, 0
  %r348 = add i32 %r670, 0
  %r349 = icmp slt i32 %r682, %r670
  br i1 %r349, label %bb43, label %bb44

bb43:
  %r673 = phi i32 [ %r682, %bb42 ]
  %r674 = phi i32 [ %r683, %bb42 ]
  %r350 = load i32, i32* @ans
  %r351 = add i32 %r673, 0
  %r352 = add i32 %r673, 0
  %r353 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r673
  %r354 = load i32, i32* %r353
  %r355 = add i32 %r673, 0
  %r356 = getelementptr [30000010 x i32 ], [30000010 x i32 ]* @a, i32 0, i32 %r673
  %r357 = load i32, i32* %r356
  %r358 = add i32 %r673, 0
  %r359 = add i32 2, %r673
  %r360 = sdiv i32 %r357, %r359
  %r361 = add i32 %r673, 0
  %r362 = add i32 2, %r673
  %r363 = mul i32 %r360, %r362
  %r364 = sub i32 %r354, %r363
  %r365 = mul i32 %r673, %r364
  %r366 = add i32 %r350, %r365
  store i32 %r366, i32* @ans
  %r367 = add i32 %r673, 0
  %r368 = add i32 %r673, 1
  %r675 = add i32 %r368, 0
  br label %bb42

bb44:
  %r678 = phi i32 [ %r682, %bb42 ]
  %r679 = phi i32 [ %r683, %bb42 ]
  %r369 = load i32, i32* @ans
  %r370 = icmp slt i32 %r369, 0
  br i1 %r370, label %bb45, label %bb46

bb45:
  %r676 = phi i32 [ %r678, %bb44 ]
  %r677 = phi i32 [ %r679, %bb44 ]
  %r371 = load i32, i32* @ans
  %r372 = sub i32 0, %r371
  store i32 %r372, i32* @ans
  br label %bb46

bb46:
  %r680 = phi i32 [ %r678, %bb44 ], [ %r676, %bb45 ]
  %r681 = phi i32 [ %r679, %bb44 ], [ %r677, %bb45 ]
  call void @_sysy_stoptime(i32 117)
  %r373 = load i32, i32* @ans
  call void @putint(i32 %r373)
  call void @putch(i32 10)
  ret i32 0
}

