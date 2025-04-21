CLS
RANDOMIZE TIMER
REM ---- speed of box and ball -----
k = 2000
SCREEN 12
WINDOW (-100, -100)-(100, 100)
s = 1
GOSUB ranT
u:
xbox = 10
ybox = -10
xbox2 = 10
ybox2 = -10
DO
FOR i = 1 TO k
NEXT i
p$ = INKEY$
GOSUB choose     'choosen positions of boxes
GOSUB box        'actual position of boxes
GOSUB check      'ball check for walls
GOSUB lose       'paddle hitting ball
GOSUB ball       'actual position of ball
LOOP
check:
IF (x < -62) THEN
  count = count - 2
  PRINT "left player loses"
  CLS
  x = 0
  y = 0
  s = 1
  t = 1
  GOTO u
ELSEIF (x > 62) THEN
  count2 = count2 - 2
  PRINT "                                                      right player loses"
  CLS
  x = 0
  y = 0
  s = -1
  t = -1
  GOTO u
ELSEIF (y > 43) THEN
  s = s * -1
ELSEIF (y < -43) THEN
  s = s * -1
END IF
RETURN
lose:
IF (x <= -58) THEN
  IF (y <= xbox) AND (y >= ybox) THEN
    t = t * -1
    GOSUB ranS
    count = count + 1
    CLS
    PRINT count; "number of hits                                   "; count2
  END IF
END IF
IF (x >= 58) THEN
  IF (y <= xbox2) AND (y >= ybox2) THEN
    t = t * -1
    GOSUB ranS
    count2 = count2 + 1
    CLS
    PRINT count; "                                                 "; count2; "number of hits"
  END IF
END IF
RETURN
ball:
  LINE (-60, 45)-(60, 45), 3, B
  LINE (-60, -45)-(60, -45), 3, B
  CIRCLE (x, y), 1, 7
  y = y + s
  x = x + t
  CIRCLE (x, y), 1, 4
RETURN
ranT:
  DO
  t = INT(RND * 4) - 1
  LOOP UNTIL t <> 0
RETURN
ranS:
  s = INT(RND * 6) - 1
RETURN
DO
  FOR o = 1 TO i
  NEXT o
  p$ = INKEY$
  GOSUB choose
  GOSUB box
LOOP
choose:
SELECT CASE p$
CASE "e"
  h = 5
CASE "s"
  h = -5
CASE "a"
  h = 0
CASE "p"
  G = 5
CASE "l"
  G = -5
CASE "k"
  G = 0
CASE ELSE
  G = 0
  h = 0
END SELECT
RETURN
box:
  IF (xbox2 >= 44) THEN
    G = -2
  ELSEIF (ybox2 <= -44) THEN
    G = 2
  END IF
  IF (xbox >= 44) THEN
    h = -2
  ELSEIF (ybox <= -44) THEN
    h = 2
  END IF
  LINE (-60, 45)-(60, 45), 3, B
  LINE (-60, -45)-(60, -45), 3, B
  LINE (59, xbox2)-(61, ybox2), 0, BF
  LINE (-59, xbox)-(-61, ybox), 0, BF
  xbox = xbox + h
  ybox = ybox + h
  xbox2 = xbox2 + G
  ybox2 = ybox2 + G
  LINE (-59, xbox)-(-61, ybox), 5, BF
  LINE (59, xbox2)-(61, ybox2), 2, BF
RETURN

