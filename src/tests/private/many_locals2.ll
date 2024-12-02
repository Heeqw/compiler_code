declare i32 @getch( )
declare i32 @getint( )
declare void @putch( i32 )
declare void @putint( i32 )
declare void @putarray( i32, i32* )
declare void @_sysy_starttime( i32 )
declare void @_sysy_stoptime( i32 )
@n = global i32 0
define i32 @main( ) {
bb1:
  %r263 = add i32 0, 0
  call void @_sysy_starttime(i32 4)
  %r264 = add i32 0, 0
  %r265 = add i32 0, 0
  %r266 = add i32 0, 0
  %r267 = add i32 0, 0
  %r268 = add i32 0, 0
  %r269 = add i32 0, 0
  %r270 = add i32 0, 0
  %r271 = add i32 0, 0
  %r272 = add i32 0, 0
  %r273 = add i32 0, 0
  %r274 = add i32 0, 0
  %r275 = add i32 0, 0
  %r276 = add i32 0, 0
  %r277 = add i32 0, 0
  %r278 = add i32 0, 0
  %r279 = add i32 0, 0
  %r280 = add i32 0, 0
  %r281 = add i32 0, 0
  %r282 = add i32 0, 0
  %r283 = add i32 0, 0
  %r284 = add i32 0, 0
  %r285 = add i32 0, 0
  %r286 = add i32 0, 0
  %r287 = add i32 0, 0
  %r288 = add i32 0, 0
  %r289 = add i32 0, 0
  %r290 = add i32 0, 0
  %r291 = add i32 0, 0
  %r292 = add i32 0, 0
  %r293 = add i32 0, 0
  %r294 = add i32 0, 0
  %r131 = call i32 @getint()
  %r295 = add i32 %r131, 0
  br label %bb2

bb2:
  %r330 = phi i32 [ %r295, %bb1 ], [ %r329, %bb3 ]
  %r132 = add i32 %r330, 0
  %r133 = icmp eq i32 %r330, 5
  br i1 %r133, label %bb3, label %bb4

bb3:
  %r328 = phi i32 [ %r330, %bb2 ]
  %r134 = add i32 %r328, 0
  %r135 = add i32 %r328, 1
  %r329 = add i32 %r135, 0
  br label %bb2

bb4:
  %r296 = phi i32 [ %r330, %bb2 ]
  %r297 = add i32 0, 0
  %r136 = add i32 %r297, 0
  %r137 = add i32 %r297, 1
  %r298 = add i32 %r137, 0
  %r138 = add i32 %r298, 0
  %r139 = add i32 %r298, 1
  %r299 = add i32 %r139, 0
  %r140 = add i32 %r299, 0
  %r141 = add i32 %r299, 1
  %r300 = add i32 %r141, 0
  %r142 = add i32 %r300, 0
  %r143 = add i32 %r300, 1
  %r301 = add i32 %r143, 0
  %r144 = add i32 %r301, 0
  %r145 = add i32 %r301, 1
  %r302 = add i32 %r145, 0
  %r146 = add i32 %r302, 0
  %r147 = add i32 %r302, 1
  %r303 = add i32 %r147, 0
  %r148 = add i32 %r303, 0
  %r149 = add i32 %r303, 1
  %r304 = add i32 %r149, 0
  %r150 = add i32 %r304, 0
  %r151 = add i32 %r304, 1
  %r305 = add i32 %r151, 0
  %r152 = add i32 %r305, 0
  %r153 = add i32 %r305, 1
  %r306 = add i32 %r153, 0
  %r154 = add i32 %r306, 0
  %r155 = add i32 %r306, 1
  %r307 = add i32 %r155, 0
  %r156 = add i32 %r307, 0
  %r157 = add i32 %r307, 1
  %r308 = add i32 %r157, 0
  %r158 = add i32 %r308, 0
  %r159 = add i32 %r308, 1
  %r309 = add i32 %r159, 0
  %r160 = add i32 %r309, 0
  %r161 = add i32 %r309, 1
  %r310 = add i32 %r161, 0
  %r162 = add i32 %r310, 0
  %r163 = add i32 %r310, 1
  %r311 = add i32 %r163, 0
  %r164 = add i32 %r311, 0
  %r165 = add i32 %r311, 1
  %r312 = add i32 %r165, 0
  %r166 = add i32 %r312, 0
  %r167 = add i32 %r312, 1
  %r313 = add i32 %r167, 0
  %r168 = add i32 %r313, 0
  %r169 = add i32 %r313, 1
  %r314 = add i32 %r169, 0
  %r170 = add i32 %r314, 0
  %r171 = add i32 %r314, 1
  %r315 = add i32 %r171, 0
  %r172 = add i32 %r315, 0
  %r173 = add i32 %r315, 1
  %r316 = add i32 %r173, 0
  %r174 = add i32 %r316, 0
  %r175 = add i32 %r316, 1
  %r317 = add i32 %r175, 0
  %r176 = add i32 %r317, 0
  %r177 = add i32 %r317, 1
  %r318 = add i32 %r177, 0
  %r178 = add i32 %r318, 0
  %r179 = add i32 %r318, 1
  %r319 = add i32 %r179, 0
  %r180 = add i32 %r319, 0
  %r181 = add i32 %r319, 1
  %r320 = add i32 %r181, 0
  %r182 = add i32 %r320, 0
  %r183 = add i32 %r320, 1
  %r321 = add i32 %r183, 0
  %r184 = add i32 %r321, 0
  %r185 = add i32 %r321, 1
  %r322 = add i32 %r185, 0
  %r186 = add i32 %r322, 0
  %r187 = add i32 %r322, 1
  %r323 = add i32 %r187, 0
  %r188 = add i32 %r323, 0
  %r189 = add i32 %r323, 1
  %r324 = add i32 %r189, 0
  %r190 = add i32 %r324, 0
  %r191 = add i32 %r324, 1
  %r325 = add i32 %r191, 0
  %r192 = add i32 %r325, 0
  %r193 = add i32 %r325, 1
  %r326 = add i32 %r193, 0
  %r195 = add i32 %r297, 0
  call void @putint(i32 %r297)
  %r196 = add i32 %r298, 0
  call void @putint(i32 %r298)
  %r197 = add i32 %r299, 0
  call void @putint(i32 %r299)
  %r198 = add i32 %r300, 0
  call void @putint(i32 %r300)
  %r199 = add i32 %r301, 0
  call void @putint(i32 %r301)
  %r200 = add i32 %r302, 0
  call void @putint(i32 %r302)
  %r201 = add i32 %r303, 0
  call void @putint(i32 %r303)
  %r202 = add i32 %r304, 0
  call void @putint(i32 %r304)
  %r203 = add i32 %r305, 0
  call void @putint(i32 %r305)
  %r204 = add i32 %r306, 0
  call void @putint(i32 %r306)
  %r205 = add i32 %r307, 0
  call void @putint(i32 %r307)
  %r206 = add i32 %r308, 0
  call void @putint(i32 %r308)
  %r207 = add i32 %r309, 0
  call void @putint(i32 %r309)
  %r208 = add i32 %r310, 0
  call void @putint(i32 %r310)
  %r209 = add i32 %r311, 0
  call void @putint(i32 %r311)
  %r210 = add i32 %r312, 0
  call void @putint(i32 %r312)
  %r211 = add i32 %r313, 0
  call void @putint(i32 %r313)
  %r212 = add i32 %r314, 0
  call void @putint(i32 %r314)
  %r213 = add i32 %r315, 0
  call void @putint(i32 %r315)
  %r214 = add i32 %r316, 0
  call void @putint(i32 %r316)
  %r215 = add i32 %r317, 0
  call void @putint(i32 %r317)
  %r216 = add i32 %r318, 0
  call void @putint(i32 %r318)
  %r217 = add i32 %r319, 0
  call void @putint(i32 %r319)
  %r218 = add i32 %r320, 0
  call void @putint(i32 %r320)
  %r219 = add i32 %r321, 0
  call void @putint(i32 %r321)
  %r220 = add i32 %r322, 0
  call void @putint(i32 %r322)
  %r221 = add i32 %r323, 0
  call void @putint(i32 %r323)
  %r222 = add i32 %r324, 0
  call void @putint(i32 %r324)
  %r223 = add i32 %r325, 0
  call void @putint(i32 %r325)
  %r224 = add i32 %r326, 0
  call void @putint(i32 %r326)
  %r327 = add i32 10, 0
  %r226 = add i32 %r327, 0
  call void @putch(i32 %r327)
  %r227 = add i32 %r296, 0
  call void @putint(i32 %r296)
  %r228 = add i32 %r327, 0
  call void @putch(i32 %r327)
  call void @_sysy_stoptime(i32 312)
  %r229 = add i32 %r322, 0
  ret i32 %r322
}

