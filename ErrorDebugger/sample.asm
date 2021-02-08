SampleLevelDebugger:
   Console.WriteLine "Camera (FG): %<.w Camera_X_pos>-%<.w Camera_Y_pos>"
   Console.WriteLine "Camera (BG): %<.w Camera_BG_X_pos>-%<.w Camera_BG_Y_pos>"
   Console.BreakLine

   Console.WriteLine "%<pal1>Objects IDs in slots:%<pal0>"
   Console.Write "%<setw>%<39>"   ; format slots table nicely ...

   lea      $FFFFB000, a0
   move.w   #$2600/next_object-1, d0

-  Console.Write "%<.b (a0)> "
   lea       next_object(a0), a0
   dbf       d0, -

   rts