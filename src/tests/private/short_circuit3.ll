declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@a = global i32 0
@b = global i32 0
@d = global i32 0
define i32 @set_a( i32 %r100 ) {
bb1:
  %r177 = add i32 0, 0
  %r178 = add i32 %r100, 0
  %r102 = add i32 %r178, 0
  store i32 %r102, i32* @a
  %r103 = load i32, i32* @a
  ret i32 %r103
}

define i32 @set_b( i32 %r104 ) {
bb2:
  %r180 = add i32 0, 0
  %r181 = add i32 %r104, 0
  %r106 = add i32 %r181, 0
  store i32 %r106, i32* @b
  %r107 = load i32, i32* @b
  ret i32 %r107
}

define i32 @set_d( i32 %r108 ) {
bb3:
  %r183 = add i32 0, 0
  %r184 = add i32 %r108, 0
  %r110 = add i32 %r184, 0
  store i32 %r110, i32* @d
  %r111 = load i32, i32* @d
  ret i32 %r111
}

define i32 @main( ) {
bb4:
  %r191 = add i32 0, 0
  %r192 = add i32 0, 0
  %r193 = add i32 0, 0
  %r194 = add i32 0, 0
  %r195 = add i32 0, 0
  %r196 = add i32 0, 0
  call void @_sysy_starttime(i32 97)
  store i32 2, i32* @a
  store i32 3, i32* @b
  %r112 = call i32 @set_a(i32 0)
  %r113 = icmp ne i32 %r112, 0
  br i1 %r113, label %bb7, label %bb6

bb7:
  %r114 = call i32 @set_b(i32 1)
  %r115 = icmp ne i32 %r114, 0
  br i1 %r115, label %bb5, label %bb6

bb5:
  br label %bb6

bb6:
  %r116 = load i32, i32* @a
  call void @putint(i32 %r116)
  call void @putch(i32 32)
  %r117 = load i32, i32* @b
  call void @putint(i32 %r117)
  call void @putch(i32 32)
  store i32 2, i32* @a
  store i32 3, i32* @b
  %r118 = call i32 @set_a(i32 0)
  %r119 = icmp ne i32 %r118, 0
  br i1 %r119, label %bb10, label %bb9

bb10:
  %r120 = call i32 @set_b(i32 1)
  %r121 = icmp ne i32 %r120, 0
  br i1 %r121, label %bb8, label %bb9

bb8:
  br label %bb9

bb9:
  %r122 = load i32, i32* @a
  call void @putint(i32 %r122)
  call void @putch(i32 32)
  %r123 = load i32, i32* @b
  call void @putint(i32 %r123)
  call void @putch(i32 10)
  %r251 = add i32 1, 0
  store i32 2, i32* @d
  %r125 = add i32 %r251, 0
  %r126 = icmp sge i32 %r251, 1
  br i1 %r126, label %bb13, label %bb12

bb13:
  %r304 = phi i32 [ %r251, %bb9 ]
  %r127 = call i32 @set_d(i32 3)
  %r128 = icmp ne i32 %r127, 0
  br i1 %r128, label %bb11, label %bb12

bb11:
  %r303 = phi i32 [ %r304, %bb13 ]
  br label %bb12

bb12:
  %r252 = phi i32 [ %r251, %bb9 ], [ %r304, %bb13 ], [ %r303, %bb11 ]
  %r129 = load i32, i32* @d
  call void @putint(i32 %r129)
  call void @putch(i32 32)
  %r130 = add i32 %r252, 0
  %r131 = icmp sle i32 %r252, 1
  br i1 %r131, label %bb14, label %bb16

bb16:
  %r271 = phi i32 [ %r252, %bb12 ]
  %r132 = call i32 @set_d(i32 4)
  %r133 = icmp ne i32 %r132, 0
  br i1 %r133, label %bb14, label %bb15

bb14:
  %r302 = phi i32 [ %r252, %bb12 ], [ %r271, %bb16 ]
  br label %bb15

bb15:
  %r259 = phi i32 [ %r271, %bb16 ], [ %r302, %bb14 ]
  %r134 = load i32, i32* @d
  call void @putint(i32 %r134)
  call void @putch(i32 10)
  call void @putch(i32 10)
  %r260 = add i32 0, 0
  %r261 = add i32 1, 0
  %r262 = add i32 2, 0
  %r263 = add i32 3, 0
  %r264 = add i32 4, 0
  br label %bb17

bb17:
  %r227 = phi i32 [ %r264, %bb15 ], [ %r284, %bb18 ]
  %r228 = phi i32 [ %r263, %bb15 ], [ %r285, %bb18 ]
  %r229 = phi i32 [ %r262, %bb15 ], [ %r286, %bb18 ]
  %r230 = phi i32 [ %r261, %bb15 ], [ %r287, %bb18 ]
  %r231 = phi i32 [ %r260, %bb15 ], [ %r288, %bb18 ]
  %r232 = phi i32 [ %r259, %bb15 ], [ %r289, %bb18 ]
  %r140 = add i32 %r231, 0
  %r141 = icmp ne i32 %r231, 0
  br i1 %r141, label %bb20, label %bb19

bb20:
  %r311 = phi i32 [ %r227, %bb17 ]
  %r312 = phi i32 [ %r228, %bb17 ]
  %r313 = phi i32 [ %r229, %bb17 ]
  %r314 = phi i32 [ %r230, %bb17 ]
  %r315 = phi i32 [ %r231, %bb17 ]
  %r316 = phi i32 [ %r232, %bb17 ]
  %r142 = add i32 %r314, 0
  %r143 = icmp ne i32 %r314, 0
  br i1 %r143, label %bb18, label %bb19

bb18:
  %r284 = phi i32 [ %r311, %bb20 ]
  %r285 = phi i32 [ %r312, %bb20 ]
  %r286 = phi i32 [ %r313, %bb20 ]
  %r287 = phi i32 [ %r314, %bb20 ]
  %r288 = phi i32 [ %r315, %bb20 ]
  %r289 = phi i32 [ %r316, %bb20 ]
  call void @putch(i32 32)
  br label %bb17

bb19:
  %r305 = phi i32 [ %r227, %bb17 ], [ %r311, %bb20 ]
  %r306 = phi i32 [ %r228, %bb17 ], [ %r312, %bb20 ]
  %r307 = phi i32 [ %r229, %bb17 ], [ %r313, %bb20 ]
  %r308 = phi i32 [ %r230, %bb17 ], [ %r314, %bb20 ]
  %r309 = phi i32 [ %r231, %bb17 ], [ %r315, %bb20 ]
  %r310 = phi i32 [ %r232, %bb17 ], [ %r316, %bb20 ]
  %r144 = add i32 %r309, 0
  %r145 = icmp ne i32 %r309, 0
  br i1 %r145, label %bb21, label %bb23

bb23:
  %r329 = phi i32 [ %r305, %bb19 ]
  %r330 = phi i32 [ %r306, %bb19 ]
  %r331 = phi i32 [ %r307, %bb19 ]
  %r332 = phi i32 [ %r308, %bb19 ]
  %r333 = phi i32 [ %r309, %bb19 ]
  %r334 = phi i32 [ %r310, %bb19 ]
  %r146 = add i32 %r332, 0
  %r147 = icmp ne i32 %r332, 0
  br i1 %r147, label %bb21, label %bb22

bb21:
  %r278 = phi i32 [ %r305, %bb19 ], [ %r329, %bb23 ]
  %r279 = phi i32 [ %r306, %bb19 ], [ %r330, %bb23 ]
  %r280 = phi i32 [ %r307, %bb19 ], [ %r331, %bb23 ]
  %r281 = phi i32 [ %r308, %bb19 ], [ %r332, %bb23 ]
  %r282 = phi i32 [ %r309, %bb19 ], [ %r333, %bb23 ]
  %r283 = phi i32 [ %r310, %bb19 ], [ %r334, %bb23 ]
  call void @putch(i32 67)
  br label %bb22

bb22:
  %r203 = phi i32 [ %r329, %bb23 ], [ %r278, %bb21 ]
  %r204 = phi i32 [ %r330, %bb23 ], [ %r279, %bb21 ]
  %r205 = phi i32 [ %r331, %bb23 ], [ %r280, %bb21 ]
  %r206 = phi i32 [ %r332, %bb23 ], [ %r281, %bb21 ]
  %r207 = phi i32 [ %r333, %bb23 ], [ %r282, %bb21 ]
  %r208 = phi i32 [ %r334, %bb23 ], [ %r283, %bb21 ]
  %r148 = add i32 %r207, 0
  %r149 = add i32 %r206, 0
  %r150 = icmp sge i32 %r207, %r206
  br i1 %r150, label %bb24, label %bb26

bb26:
  %r197 = phi i32 [ %r203, %bb22 ]
  %r198 = phi i32 [ %r204, %bb22 ]
  %r199 = phi i32 [ %r205, %bb22 ]
  %r200 = phi i32 [ %r206, %bb22 ]
  %r201 = phi i32 [ %r207, %bb22 ]
  %r202 = phi i32 [ %r208, %bb22 ]
  %r151 = add i32 %r200, 0
  %r152 = add i32 %r201, 0
  %r153 = icmp sle i32 %r200, %r201
  br i1 %r153, label %bb24, label %bb25

bb24:
  %r296 = phi i32 [ %r203, %bb22 ], [ %r197, %bb26 ]
  %r297 = phi i32 [ %r204, %bb22 ], [ %r198, %bb26 ]
  %r298 = phi i32 [ %r205, %bb22 ], [ %r199, %bb26 ]
  %r299 = phi i32 [ %r206, %bb22 ], [ %r200, %bb26 ]
  %r300 = phi i32 [ %r207, %bb22 ], [ %r201, %bb26 ]
  %r301 = phi i32 [ %r208, %bb22 ], [ %r202, %bb26 ]
  call void @putch(i32 72)
  br label %bb25

bb25:
  %r233 = phi i32 [ %r197, %bb26 ], [ %r296, %bb24 ]
  %r234 = phi i32 [ %r198, %bb26 ], [ %r297, %bb24 ]
  %r235 = phi i32 [ %r199, %bb26 ], [ %r298, %bb24 ]
  %r236 = phi i32 [ %r200, %bb26 ], [ %r299, %bb24 ]
  %r237 = phi i32 [ %r201, %bb26 ], [ %r300, %bb24 ]
  %r238 = phi i32 [ %r202, %bb26 ], [ %r301, %bb24 ]
  %r154 = add i32 %r235, 0
  %r155 = add i32 %r236, 0
  %r156 = icmp sge i32 %r235, %r236
  br i1 %r156, label %bb29, label %bb28

bb29:
  %r239 = phi i32 [ %r233, %bb25 ]
  %r240 = phi i32 [ %r234, %bb25 ]
  %r241 = phi i32 [ %r235, %bb25 ]
  %r242 = phi i32 [ %r236, %bb25 ]
  %r243 = phi i32 [ %r237, %bb25 ]
  %r244 = phi i32 [ %r238, %bb25 ]
  %r157 = add i32 %r239, 0
  %r158 = add i32 %r240, 0
  %r159 = icmp ne i32 %r239, %r240
  br i1 %r159, label %bb27, label %bb28

bb27:
  %r253 = phi i32 [ %r239, %bb29 ]
  %r254 = phi i32 [ %r240, %bb29 ]
  %r255 = phi i32 [ %r241, %bb29 ]
  %r256 = phi i32 [ %r242, %bb29 ]
  %r257 = phi i32 [ %r243, %bb29 ]
  %r258 = phi i32 [ %r244, %bb29 ]
  call void @putch(i32 73)
  br label %bb28

bb28:
  %r209 = phi i32 [ %r233, %bb25 ], [ %r239, %bb29 ], [ %r253, %bb27 ]
  %r210 = phi i32 [ %r234, %bb25 ], [ %r240, %bb29 ], [ %r254, %bb27 ]
  %r211 = phi i32 [ %r235, %bb25 ], [ %r241, %bb29 ], [ %r255, %bb27 ]
  %r212 = phi i32 [ %r236, %bb25 ], [ %r242, %bb29 ], [ %r256, %bb27 ]
  %r213 = phi i32 [ %r237, %bb25 ], [ %r243, %bb29 ], [ %r257, %bb27 ]
  %r214 = phi i32 [ %r238, %bb25 ], [ %r244, %bb29 ], [ %r258, %bb27 ]
  %r160 = add i32 %r212, 0
  %r161 = icmp ne i32 %r212, 0
  br i1 %r161, label %bb32, label %bb33

bb33:
  %r317 = phi i32 [ %r209, %bb28 ]
  %r318 = phi i32 [ %r210, %bb28 ]
  %r319 = phi i32 [ %r211, %bb28 ]
  %r320 = phi i32 [ %r212, %bb28 ]
  %r321 = phi i32 [ %r213, %bb28 ]
  %r322 = phi i32 [ %r214, %bb28 ]
  %r162 = add i32 %r318, 0
  %r163 = add i32 %r318, 0
  %r164 = icmp slt i32 %r318, %r318
  br i1 %r164, label %bb30, label %bb32

bb32:
  %r323 = phi i32 [ %r209, %bb28 ], [ %r317, %bb33 ]
  %r324 = phi i32 [ %r210, %bb28 ], [ %r318, %bb33 ]
  %r325 = phi i32 [ %r211, %bb28 ], [ %r319, %bb33 ]
  %r326 = phi i32 [ %r212, %bb28 ], [ %r320, %bb33 ]
  %r327 = phi i32 [ %r213, %bb28 ], [ %r321, %bb33 ]
  %r328 = phi i32 [ %r214, %bb28 ], [ %r322, %bb33 ]
  %r165 = add i32 %r323, 0
  %r166 = add i32 %r323, 0
  %r167 = icmp sge i32 %r323, %r323
  br i1 %r167, label %bb30, label %bb31

bb30:
  %r245 = phi i32 [ %r317, %bb33 ], [ %r323, %bb32 ]
  %r246 = phi i32 [ %r318, %bb33 ], [ %r324, %bb32 ]
  %r247 = phi i32 [ %r319, %bb33 ], [ %r325, %bb32 ]
  %r248 = phi i32 [ %r320, %bb33 ], [ %r326, %bb32 ]
  %r249 = phi i32 [ %r321, %bb33 ], [ %r327, %bb32 ]
  %r250 = phi i32 [ %r322, %bb33 ], [ %r328, %bb32 ]
  call void @putch(i32 74)
  br label %bb31

bb31:
  %r290 = phi i32 [ %r323, %bb32 ], [ %r245, %bb30 ]
  %r291 = phi i32 [ %r324, %bb32 ], [ %r246, %bb30 ]
  %r292 = phi i32 [ %r325, %bb32 ], [ %r247, %bb30 ]
  %r293 = phi i32 [ %r326, %bb32 ], [ %r248, %bb30 ]
  %r294 = phi i32 [ %r327, %bb32 ], [ %r249, %bb30 ]
  %r295 = phi i32 [ %r328, %bb32 ], [ %r250, %bb30 ]
  %r168 = add i32 %r293, 0
  %r169 = icmp ne i32 %r293, 0
  br i1 %r169, label %bb36, label %bb34

bb36:
  %r221 = phi i32 [ %r290, %bb31 ]
  %r222 = phi i32 [ %r291, %bb31 ]
  %r223 = phi i32 [ %r292, %bb31 ]
  %r224 = phi i32 [ %r293, %bb31 ]
  %r225 = phi i32 [ %r294, %bb31 ]
  %r226 = phi i32 [ %r295, %bb31 ]
  %r170 = add i32 %r222, 0
  %r171 = add i32 %r222, 0
  %r172 = icmp slt i32 %r222, %r222
  br i1 %r172, label %bb37, label %bb35

bb37:
  %r215 = phi i32 [ %r221, %bb36 ]
  %r216 = phi i32 [ %r222, %bb36 ]
  %r217 = phi i32 [ %r223, %bb36 ]
  %r218 = phi i32 [ %r224, %bb36 ]
  %r219 = phi i32 [ %r225, %bb36 ]
  %r220 = phi i32 [ %r226, %bb36 ]
  %r173 = add i32 %r215, 0
  %r174 = add i32 %r215, 0
  %r175 = icmp sge i32 %r215, %r215
  br i1 %r175, label %bb34, label %bb35

bb34:
  %r272 = phi i32 [ %r290, %bb31 ], [ %r215, %bb37 ]
  %r273 = phi i32 [ %r291, %bb31 ], [ %r216, %bb37 ]
  %r274 = phi i32 [ %r292, %bb31 ], [ %r217, %bb37 ]
  %r275 = phi i32 [ %r293, %bb31 ], [ %r218, %bb37 ]
  %r276 = phi i32 [ %r294, %bb31 ], [ %r219, %bb37 ]
  %r277 = phi i32 [ %r295, %bb31 ], [ %r220, %bb37 ]
  call void @putch(i32 75)
  br label %bb35

bb35:
  %r265 = phi i32 [ %r221, %bb36 ], [ %r215, %bb37 ], [ %r272, %bb34 ]
  %r266 = phi i32 [ %r222, %bb36 ], [ %r216, %bb37 ], [ %r273, %bb34 ]
  %r267 = phi i32 [ %r223, %bb36 ], [ %r217, %bb37 ], [ %r274, %bb34 ]
  %r268 = phi i32 [ %r224, %bb36 ], [ %r218, %bb37 ], [ %r275, %bb34 ]
  %r269 = phi i32 [ %r225, %bb36 ], [ %r219, %bb37 ], [ %r276, %bb34 ]
  %r270 = phi i32 [ %r226, %bb36 ], [ %r220, %bb37 ], [ %r277, %bb34 ]
  call void @putch(i32 10)
  call void @_sysy_stoptime(i32 117)
  ret i32 0
}

