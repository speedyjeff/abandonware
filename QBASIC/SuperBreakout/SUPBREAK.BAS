REM            5   tall      
CLS
RANDOMIZE TIMER
SCREEN 12
WINDOW (-100, -100)-(100, 100)
rows = 6
colums = 10
DIM bar(rows, colums, 4)   'the array 2=rows  10=colums  4=info [x1,y1,x2,y2]
l = 200        'speed of ball
PRINT "Enter the speed of the ball you would like."
PRINT
PRINT "1000  slow  --   500 normal  --  0 fast"
PRINT "   Pick any number from 500 to 0."
INPUT l
DO
  CLS
  xbox3 = -10    'position of the pattle
  ybox3 = 10     'position of the pattle
  REM   *** ball information ***
  y = -10           'starting y position
  x = -45         'starting x position
  s = -1          'the x movable axis
  t = 1           'the y movable axis
  numballs = 0
  allgone = 0
  GOSUB BarValues
  GOSUB Walls
  DO
    IF (numballs <> 3) THEN
      FOR i = 1 TO l
      NEXT i
      GOSUB MovePattle       'the input for the pattle
      GOSUB Pattle           'the actual pattle
      GOSUB CheckBars
      IF (count = 1) THEN
        GOSUB BarsLeft
        GOSUB Walls
        count = 0
      END IF
      GOSUB BallOffPattle    'the ball hitting the pattle
      GOSUB BallOffWalls    'the balls check for the walls
      GOSUB ball             'the actual ball
    ELSE
      PRINT "you lose"
      SYSTEM
    END IF
  LOOP UNTIL (allgone = (rows * colums))
  PRINT "You Win!!!"
  PRINT "Would you like to play again [y,n]? ";
  INPUT a$
LOOP UNTIL (a$ = "n") OR (a$ = "N")
END

CheckBars:
FOR a = 1 TO rows
  IF (y > bar(a, 1, 2) - 1) AND (y < bar(a, 1, 4) + 1) THEN
    FOR b = 1 TO colums
      IF (x >= bar(a, b, 1)) AND (x < bar(a, b, 3)) THEN
        s = s * -1
        LINE (bar(a, b, 1), bar(a, b, 2))-(bar(a, b, 3), bar(a, b, 4)), 0, BF
        bar(a, b, 1) = 100
        bar(a, b, 3) = 100
        allgone = allgone + 1
      END IF
    NEXT b
  END IF
NEXT a
RETURN

BarsLeft:
tp = 0
FOR a = 1 TO rows
  tp = tp + 1
  FOR b = 1 TO colums
    LINE (bar(a, b, 1), bar(a, b, 2))-(bar(a, b, 3), bar(a, b, 4)), tp, BF
  NEXT b
NEXT a
RETURN

BarValues:
tp = 0
j = -60
h = 10
FOR a = 1 TO rows
  tp = tp + 1
  FOR b = 1 TO colums
    j = j + 10
    LINE (j, h)-(j + 10, h + 5), tp, BF
    bar(a, b, 1) = j
    bar(a, b, 2) = h
    bar(a, b, 3) = j + 10
    bar(a, b, 4) = h + 5
  NEXT b
  j = -60
  h = h + 7
NEXT a
RETURN

BallOffPattle:
IF (y = -59) THEN
  IF (x >= xbox3) AND (x <= ybox3) THEN
    s = s * -1
    GOSUB ranT
  END IF
END IF
RETURN

BallOffWalls:
IF (y <= -64) OR (y > 60) THEN
  IF (numballs <> 2) THEN
    PRINT "ready [enter]"
    INPUT a
    CLS
    x = -45
    y = -10
    s = -1
    t = 1
    xbox3 = -10
    ybox3 = 10
    count = 1
  END IF
  numballs = numballs + 1
  ELSEIF (x >= 48) THEN
    t = t * -1
  ELSEIF (x <= -48) THEN
    t = t * -1
  ELSEIF (y >= 58) THEN
    s = s * -1
END IF
RETURN

Walls:
LINE (-50, 60)-(50, 65), 4, BF
LINE (-50, -60)-(-55, 65), 4, BF
LINE (55, 65)-(50, -60), 4, BF
RETURN

ball:
  CIRCLE (x, y), 1, 0
  y = y + s
  x = x + t
  CIRCLE (x, y), 1, 14
RETURN

ranT:
  t = INT(RND * 5) - 1
RETURN

ranS:
  s = INT(RND * 5) - 1
RETURN

MovePattle:
t$ = INKEY$
SELECT CASE t$
  CASE "n"
    j = -5
  CASE "m"
    j = 5
  CASE ELSE
    j = 0
END SELECT
IF (xbox3 < -49) THEN
  j = 1
ELSEIF (ybox3 > 49) THEN
  j = -1
END IF
RETURN

Pattle:
LINE (xbox3, -61)-(ybox3, -59), 0, BF
xbox3 = xbox3 + j
ybox3 = ybox3 + j
LINE (xbox3, -61)-(ybox3, -59), 2, BF
RETURN


