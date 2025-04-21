z:
CLS
DIM b$(9)
O$ = " O"
X$ = " X"
FOR i = 1 TO 9
  b$(i) = STR$(i)
NEXT i
move = 0
RANDOMIZE TIMER
COLOR 3
PRINT "you have won: "; win; " and lost: "; lose; " and tied: "; cat
COLOR 15
DO
  PRINT "PICK QUADRENT YOU PERFERRE"
  PRINT " "; b$(1); " | "; b$(2); " | "; b$(3)
  PRINT " "; b$(4); " | "; b$(5); " | "; b$(6)
  PRINT " "; b$(7); " | "; b$(8); " | "; b$(9)
  INPUT n
  IF n > 9 OR n < 1 THEN
    PRINT "Stick to the quadrents."
    GOTO g
  END IF
  IF b$(n) = O$ OR b$(n) = X$ THEN
     PRINT "Don't cheat!"
     PRINT "I can't believe you've got to cheat to"
     PRINT "win.  You're just a cheater."
     GOTO g
  END IF
  b$(n) = O$
  move = move + 1
  IF b$(1) = O$ AND b$(2) = O$ AND b$(3) = O$ OR b$(4) = O$ AND b$(5) = O$ AND b$(6) = O$ OR b$(7) = O$ AND b$(8) = O$ AND b$(9) = O$ THEN
    GOTO y
    END IF
  IF b$(1) = O$ AND b$(4) = O$ AND b$(7) = O$ OR b$(2) = O$ AND b$(5) = O$ AND b$(8) = O$ OR b$(3) = O$ AND b$(6) = O$ AND b$(9) = O$ THEN
    GOTO y
    END IF
  IF b$(1) = O$ AND b$(5) = O$ AND b$(9) = O$ OR b$(3) = O$ AND b$(5) = O$ AND b$(7) = O$ THEN
    GOTO y
    END IF
  IF (move = 5) THEN
    PRINT ""; b$(1); " | "; b$(2); " | "; b$(3)
    PRINT ""; b$(4); " | "; b$(5); " | "; b$(6)
    PRINT ""; b$(7); " | "; b$(8); " | "; b$(9)
    PRINT
    PRINT "cats"
    cat = cat + 1
    GOTO g
    END IF
REM ------------------ COMPUTERS FIRST MOVE -----------------
    IF b$(5) <> O$ AND b$(5) <> X$ THEN
      b$(5) = X$
      GOTO w
      END IF
REM------------ COMPUTERS SECOND MOVE ---------------------
  IF b$(5) = O$ AND b$(1) <> O$ AND b$(1) <> X$ AND b$(2) <> O$ AND b$(2) <> X$ AND b$(3) <> O$ AND b$(3) <> X$ AND b$(4) <> O$ AND b$(4) <> X$ AND b$(6) <> O$ AND b$(6) <> X$ AND b$(7) <> O$ AND b$(7) <> X$ AND b$(8) <> O$ AND b$(8) <> X$ AND b$(9) <> O$ AND b$(9) <> X$ THEN
    b$(1) = X$
    GOTO w
  END IF
REM------------ COMPUTER TRIES TO WIN -------------
  IF b$(1) <> O$ AND b$(1) <> X$ AND b$(2) = X$ AND b$(3) = X$ OR b$(1) <> O$ AND b$(1) <> X$ AND b$(4) = X$ AND b$(7) = X$ OR b$(1) <> O$ AND b$(1) <> X$ AND b$(5) = X$ AND b$(9) = X$ THEN
    b$(1) = X$
    GOTO w
    END IF
  IF b$(2) <> O$ AND b$(2) <> X$ AND b$(1) = X$ AND b$(3) = X$ OR b$(2) <> O$ AND b$(2) <> X$ AND b$(5) = X$ AND b$(8) = X$ THEN
    b$(2) = X$
    GOTO w
    END IF
  IF b$(3) <> O$ AND b$(3) <> X$ AND b$(2) = X$ AND b$(1) = X$ OR b$(3) <> O$ AND b$(3) <> X$ AND b$(5) = X$ AND b$(7) = X$ OR b$(3) <> O$ AND b$(3) <> X$ AND b$(6) = X$ AND b$(9) = X$ THEN
    b$(3) = X$
    GOTO w
    END IF
  IF b$(4) <> O$ AND b$(4) <> X$ AND b$(1) = X$ AND b$(7) = X$ OR b$(4) <> O$ AND b$(4) <> X$ AND b$(5) = X$ AND b$(6) = X$ THEN
    b$(4) = X$
    GOTO w
    END IF
  IF b$(5) <> O$ AND b$(5) <> X$ AND b$(1) = X$ AND b$(9) = X$ OR b$(5) <> O$ AND b$(5) <> X$ AND b$(3) = X$ AND b$(7) = X$ OR b$(5) <> O$ AND b$(5) <> X$ AND b$(2) = X$ AND b$(8) = X$ OR b$(5) <> O$ AND b$(5) <> X$ AND b$(4) = X$ AND b$(6) = X$ THEN
    b$(5) = X$
    GOTO w
    END IF
  IF b$(6) <> O$ AND b$(6) <> X$ AND b$(3) = X$ AND b$(9) = X$ OR b$(6) <> O$ AND b$(6) <> X$ AND b$(5) = X$ AND b$(4) = X$ THEN
    b$(6) = X$
    GOTO w
    END IF
  IF b$(7) <> O$ AND b$(7) <> X$ AND b$(4) = X$ AND b$(1) = X$ OR b$(7) <> O$ AND b$(7) <> X$ AND b$(5) = X$ AND b$(3) = X$ OR b$(7) <> O$ AND b$(7) <> X$ AND b$(8) = X$ AND b$(9) = X$ THEN
    b$(7) = X$
    GOTO w
    END IF
  IF b$(8) <> O$ AND b$(8) <> X$ AND b$(7) = X$ AND b$(9) = X$ OR b$(8) <> O$ AND b$(8) <> X$ AND b$(5) = X$ AND b$(2) = X$ THEN
    b$(8) = X$
    GOTO w
    END IF
  IF b$(9) <> O$ AND b$(9) <> X$ AND b$(8) = X$ AND b$(7) = X$ OR b$(9) <> O$ AND b$(9) <> X$ AND b$(5) = X$ AND b$(1) = X$ OR b$(9) <> O$ AND b$(9) <> X$ AND b$(6) = X$ AND b$(3) = X$ THEN
    b$(9) = X$
    GOTO w
    END IF
REM -------------COMPUTER TRIES TO STOP A WIN ----------------------
  IF b$(1) <> O$ AND b$(1) <> X$ AND b$(2) = O$ AND b$(3) = O$ OR b$(1) <> O$ AND b$(1) <> X$ AND b$(4) = O$ AND b$(7) = O$ OR b$(1) <> O$ AND b$(1) <> X$ AND b$(5) = O$ AND b$(9) = O$ THEN
    b$(1) = X$
    GOTO w
    END IF
  IF b$(2) <> O$ AND b$(2) <> X$ AND b$(1) = O$ AND b$(3) = O$ OR b$(2) <> O$ AND b$(2) <> X$ AND b$(5) = O$ AND b$(8) = O$ THEN
    b$(2) = X$
    GOTO w
    END IF
  IF b$(3) <> O$ AND b$(3) <> X$ AND b$(2) = O$ AND b$(1) = O$ OR b$(3) <> O$ AND b$(3) <> X$ AND b$(5) = O$ AND b$(7) = O$ OR b$(3) <> O$ AND b$(3) <> X$ AND b$(6) = O$ AND b$(9) = O$ THEN
    b$(3) = X$
    GOTO w
    END IF
  IF b$(4) <> O$ AND b$(4) <> X$ AND b$(1) = O$ AND b$(7) = O$ OR b$(4) <> O$ AND b$(4) <> X$ AND b$(5) = O$ AND b$(6) = O$ THEN
    b$(4) = X$
    GOTO w
    END IF
  IF b$(5) <> O$ AND b$(5) <> X$ AND b$(1) = O$ AND b$(9) = O$ OR b$(5) <> O$ AND b$(5) <> X$ AND b$(3) = O$ AND b$(7) = O$ OR b$(5) <> O$ AND b$(5) <> X$ AND b$(2) = O$ AND b$(8) = O$ OR b$(5) <> O$ AND b$(5) <> X$ AND b$(4) = O$ AND b$(6) = O$ THEN
    b$(5) = X$
    GOTO w
    END IF
  IF b$(6) <> O$ AND b$(6) <> X$ AND b$(3) = O$ AND b$(9) = O$ OR b$(6) <> O$ AND b$(6) <> X$ AND b$(5) = O$ AND b$(4) = O$ THEN
    b$(6) = X$
    GOTO w
    END IF
  IF b$(7) <> O$ AND b$(7) <> X$ AND b$(4) = O$ AND b$(1) = O$ OR b$(7) <> O$ AND b$(7) <> X$ AND b$(5) = O$ AND b$(3) = O$ OR b$(7) <> O$ AND b$(7) <> X$ AND b$(8) = O$ AND b$(9) = O$ THEN
    b$(7) = X$
    GOTO w
    END IF
  IF b$(8) <> O$ AND b$(8) <> X$ AND b$(7) = O$ AND b$(9) = O$ OR b$(8) <> O$ AND b$(8) <> X$ AND b$(5) = O$ AND b$(2) = O$ THEN
    b$(8) = X$
    GOTO w
    END IF
  IF b$(9) <> O$ AND b$(9) <> X$ AND b$(8) = O$ AND b$(7) = O$ OR b$(9) <> O$ AND b$(9) <> X$ AND b$(5) = O$ AND b$(1) = O$ OR b$(9) <> O$ AND b$(9) <> X$ AND b$(6) = O$ AND b$(3) = O$ THEN
    b$(9) = X$
    GOTO w
    END IF
REM -------------COMPUTER BECOMES INVINSIBLE ----------------
  IF b$(4) = X$ AND b$(5) = O$ AND b$(6) = O$ AND b$(7) <> O$ AND b$(7) <> X$ THEN
    b$(7) = X$
    GOTO w
    END IF
  IF b$(4) = O$ AND b$(5) = O$ AND b$(6) = X$ AND b$(3) <> O$ AND b$(3) <> X$ THEN
    b$(3) = X$
    GOTO w
    END IF
  IF b$(2) = O$ AND b$(5) = O$ AND b$(8) = X$ AND b$(1) <> O$ AND b$(1) <> X$ THEN
    b$(1) = X$
    GOTO w
    END IF
  IF b$(2) = O$ AND b$(5) = O$ AND b$(8) = X$ AND b$(9) <> O$ AND b$(9) <> X$ THEN
    b$(9) = X$
    GOTO w
    END IF
  IF b$(6) = O$ AND b$(7) = O$ AND b$(5) = X$ AND b$(9) <> O$ AND b$(9) <> X$ OR b$(6) = O$ AND b$(8) = O$ AND b$(5) = X$ AND b$(9) <> O$ AND b$(9) <> X$ THEN
    b$(9) = X$
    GOTO w
  END IF
  IF b$(7) <> O$ AND b$(7) <> X$ AND b$(5) = O$ AND b$(9) = O$ THEN
    b$(7) = X$
    GOTO w
    END IF
  IF b$(3) = O$ AND b$(4) = O$ AND b$(5) = X$ AND b$(1) <> O$ AND b$(1) <> X$ THEN
    b$(1) = X$
    GOTO w
  END IF
  IF b$(5) = O$ AND b$(9) = O$ AND b$(1) = X$ AND b$(7) <> O$ AND b$(7) <> X$ THEN
    b$(7) = X$
    GOTO w
  END IF
  IF b$(4) = O$ AND b$(8) = O$ AND b$(5) = X$ AND b$(7) <> O$ AND b$(7) <> X$ THEN
    b$(7) = X$
    GOTO w
  END IF
  IF b$(4) = O$ AND b$(9) = O$ AND b$(8) <> O$ AND b$(8) <> X$ THEN
    b$(8) = X$
    GOTO w
  END IF
  IF b$(4) = O$ AND b$(3) = O$ AND b$(2) <> O$ AND b$(2) <> X$ THEN
    b$(2) = X$
    GOTO w
  END IF
  IF b$(4) = X$ AND b$(5) = X$ AND b$(6) = O$ AND b$(7) = O$ AND b$(2) = O$ AND b$(3) <> X$ AND b$(3) <> O$ THEN
    b$(3) = X$
    GOTO w
  END IF
  IF b$(1) = O$ AND b$(6) = O$ AND b$(9) <> O$ AND b$(9) <> X$ THEN
    b$(9) = X$
    GOTO w
  END IF
  IF b$(2) = O$ AND b$(2) = O$ AND b$(1) <> O$ AND b$(1) <> X$ THEN
    b$(1) = X$
    GOTO w
  END IF
  DO
    m = 1 + INT(RND * 9)
  LOOP UNTIL b$(m) <> O$ AND b$(m) <> X$
  b$(m) = X$
REM --  PRINT "wait a minute"
REM --  INPUT a
w:
  IF b$(1) = X$ AND b$(2) = X$ AND b$(3) = X$ OR b$(4) = X$ AND b$(5) = X$ AND b$(6) = X$ OR b$(7) = X$ AND b$(8) = X$ AND b$(9) = X$ THEN
    GOTO h
    END IF
  IF b$(1) = X$ AND b$(4) = X$ AND b$(7) = X$ OR b$(2) = X$ AND b$(5) = X$ AND b$(8) = X$ OR b$(3) = X$ AND b$(6) = X$ AND b$(9) = X$ THEN
    GOTO h
    END IF
  IF b$(1) = X$ AND b$(5) = X$ AND b$(9) = X$ OR b$(3) = X$ AND b$(5) = X$ AND b$(7) = X$ THEN
    GOTO h
    END IF
LOOP
y:
  COLOR 30
  PRINT "you win!!"
  PRINT ""; b$(1); " | "; b$(2); " | "; b$(3)
  PRINT ""; b$(4); " | "; b$(5); " | "; b$(6)
  PRINT ""; b$(7); " | "; b$(8); " | "; b$(9)
  PRINT
  win = win + 1
  GOTO g
h:
  COLOR 12
  PRINT "you lose!!"
  COLOR 22
  PRINT ""; b$(1); " | "; b$(2); " | "; b$(3)
  PRINT ""; b$(4); " | "; b$(5); " | "; b$(6)
  PRINT ""; b$(7); " | "; b$(8); " | "; b$(9)
  PRINT
  lose = lose + 1
  GOTO g
g:
DO
  COLOR 10
  PRINT "Would you like to play again? [y,n]"
  INPUT a$
  IF a$ = "y" THEN
    CLS
    GOTO z
  END IF
LOOP UNTIL a$ = "n"
COLOR 3
PRINT "you have won: "; win; " and lost: "; lose; " and tied: "; cat
END

