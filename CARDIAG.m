CARDIAG ; Car Diagnosis Expert System in MUMPS/M
 ; Version 1.1 - CORRECTED VERSION
 ;
 ;------------------------------------------
 ; MAIN ENTRY POINT
 ;------------------------------------------
START ;
 D INIT
 D BANNER
 D DIAG
 D ASKAGAIN
 Q
 ;
 ;------------------------------------------
 ; INITIALIZATION
 ;------------------------------------------
INIT ;
 K KNOWN,RESULT
 S RESCNT=0
 Q
 ;
 ;------------------------------------------
 ; WELCOME BANNER
 ;------------------------------------------
BANNER ;
 W !!,"============================================"
 W !,"   CAR DIAGNOSIS EXPERT SYSTEM v1.1"
 W !,"============================================"
 W !,"   Answer questions with: Y or N"
 W !,"============================================",!!
 Q
 ;
 ;------------------------------------------
 ; MAIN DIAGNOSIS LOGIC
 ;------------------------------------------
DIAG ;
 W !,"Analyzing your car problem...",!
 W "Please answer the following questions:",!!
 ;
 ; Test all hypotheses
 D DEADBATT
 D WEAKBATT
 D BADSTART
 D BADSOLEN
 D BADIGNIT
 D BLWNFUSE
 D NOFUEL
 D BADPUMP
 D CLOGFILT
 D FLOODED
 D BADSPARK
 D ELECSHRT
 ;
 ; Display results
 D SHOWRES
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Dead Battery (Complete)
 ; FIX: Added differentiation from ignition switch
 ;------------------------------------------
DEADBATT ;
 N OK,A S OK=1
 D ASK("no_sound","Is there complete silence when turning key",.A)
 I A'="Y" S OK=0 G DEADBX
 D ASK("dash_on","Do dashboard lights turn on",.A)
 I A="Y" S OK=0 G DEADBX
 D ASK("heads_on","Do headlights work normally",.A)
 I A="Y" S OK=0 G DEADBX
 ; Additional check - if battery is old, more likely battery issue
 D ASK("bat_old","Is battery more than 3-4 years old",.A)
 I A="Y",OK D ADDREC("DEAD BATTERY","Jump-start or replace battery")
DEADBX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Weak Battery
 ;------------------------------------------
WEAKBATT ;
 N OK,A S OK=1
 D ASK("slow_crank","Does engine crank slowly/weakly",.A)
 I A'="Y" S OK=0 G WEAKBX
 D ASK("dim_dash","Are dashboard lights dim or flickering",.A)
 I A'="Y" S OK=0 G WEAKBX
 I OK D ADDREC("WEAK BATTERY","Test battery and charging system")
WEAKBX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Faulty Starter Motor
 ;------------------------------------------
BADSTART ;
 N OK,A S OK=1
 D ASK("one_click","Do you hear single click but nothing else",.A)
 I A'="Y" S OK=0 G BADSTX
 D ASK("dash_on","Do dashboard lights turn on",.A)
 I A'="Y" S OK=0 G BADSTX
 D ASK("heads_on","Do headlights work normally",.A)
 I A'="Y" S OK=0 G BADSTX
 I OK D ADDREC("FAULTY STARTER","Starter motor needs replacement")
BADSTX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Bad Starter Solenoid
 ;------------------------------------------
BADSOLEN ;
 N OK,A S OK=1
 D ASK("clicking","Do you hear rapid clicking when turning key",.A)
 I A'="Y" S OK=0 G BADSLX
 D ASK("dash_on","Do dashboard lights turn on",.A)
 I A'="Y" S OK=0 G BADSLX
 D ASK("cranks","Does engine crank/turn over",.A)
 I A="Y" S OK=0 G BADSLX
 I OK D ADDREC("BAD SOLENOID","Starter solenoid needs replacement")
BADSLX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Faulty Ignition Switch
 ; FIX: Differentiated from dead battery
 ;------------------------------------------
BADIGNIT ;
 N OK,A S OK=1
 D ASK("no_sound","Is there complete silence when turning key",.A)
 I A'="Y" S OK=0 G BADIGX
 D ASK("dash_on","Do dashboard lights turn on",.A)
 I A'="Y" S OK=0 G BADIGX
 D ASK("heads_on","Do headlights work normally",.A)
 I A'="Y" S OK=0 G BADIGX
 ; Only diagnose if battery NOT old (else it's battery issue)
 D ASK("bat_old","Is battery more than 3-4 years old",.A)
 I A'="Y",OK D ADDREC("BAD IGNITION SWITCH","Ignition switch needs replacement")
BADIGX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Blown Fuse
 ; FIX: New hypothesis - headlights work but dash doesn't
 ;------------------------------------------
BLWNFUSE ;
 N OK,A S OK=1
 D ASK("no_sound","Is there complete silence when turning key",.A)
 I A'="Y" S OK=0 G BLWNFX
 D ASK("dash_on","Do dashboard lights turn on",.A)
 I A="Y" S OK=0 G BLWNFX
 D ASK("heads_on","Do headlights work normally",.A)
 I A'="Y" S OK=0 G BLWNFX
 I OK D ADDREC("BLOWN FUSE","Check ignition/starter fuse in fuse box")
BLWNFX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Out of Fuel
 ;------------------------------------------
NOFUEL ;
 N OK,A S OK=1
 D ASK("cranks","Does engine crank/turn over",.A)
 I A'="Y" S OK=0 G NOFUELX
 D ASK("fuel_low","Does fuel gauge show empty or very low",.A)
 I A'="Y" S OK=0 G NOFUELX
 I OK D ADDREC("OUT OF FUEL","Add gasoline to tank")
NOFUELX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Faulty Fuel Pump
 ;------------------------------------------
BADPUMP ;
 N OK,A S OK=1
 D ASK("cranks","Does engine crank/turn over",.A)
 I A'="Y" S OK=0 G BADPMPX
 D ASK("fuel_low","Does fuel gauge show empty or very low",.A)
 I A="Y" S OK=0 G BADPMPX
 D ASK("no_gas_smell","Is there NO gasoline smell when cranking",.A)
 I A'="Y" S OK=0 G BADPMPX
 D ASK("starts_dies","Does engine start briefly then die",.A)
 I A="Y" S OK=0 G BADPMPX
 I OK D ADDREC("FAULTY FUEL PUMP","Fuel pump needs testing/replacement")
BADPMPX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Clogged Fuel Filter
 ;------------------------------------------
CLOGFILT ;
 N OK,A S OK=1
 D ASK("cranks","Does engine crank/turn over",.A)
 I A'="Y" S OK=0 G CLOGFLX
 D ASK("starts_dies","Does engine start briefly then die",.A)
 I A'="Y" S OK=0 G CLOGFLX
 D ASK("fuel_low","Does fuel gauge show empty or very low",.A)
 I A="Y" S OK=0 G CLOGFLX
 I OK D ADDREC("CLOGGED FUEL FILTER","Replace fuel filter")
CLOGFLX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Flooded Engine
 ;------------------------------------------
FLOODED ;
 N OK,A S OK=1
 D ASK("cranks","Does engine crank/turn over",.A)
 I A'="Y" S OK=0 G FLOODX
 D ASK("gas_smell","Do you smell gasoline near engine",.A)
 I A'="Y" S OK=0 G FLOODX
 D ASK("many_tries","Has engine been cranked many times recently",.A)
 I A'="Y" S OK=0 G FLOODX
 I OK D ADDREC("FLOODED ENGINE","Wait 15 min then try with pedal fully pressed")
FLOODX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Bad Spark Plugs
 ;------------------------------------------
BADSPARK ;
 N OK,A S OK=1
 D ASK("cranks","Does engine crank/turn over",.A)
 I A'="Y" S OK=0 G BADSPX
 D ASK("backfire","Does engine backfire or pop",.A)
 I A'="Y" S OK=0 G BADSPX
 D ASK("fuel_low","Does fuel gauge show empty or very low",.A)
 I A="Y" S OK=0 G BADSPX
 I OK D ADDREC("BAD SPARK PLUGS","Inspect and replace spark plugs")
BADSPX ;
 Q
 ;
 ;------------------------------------------
 ; HYPOTHESIS: Electrical Short (DANGER)
 ;------------------------------------------
ELECSHRT ;
 N OK,A S OK=1
 D ASK("burn_smell","Do you notice burning or electrical smell",.A)
 I A'="Y" S OK=0 G ELECSHX
 D ASK("smoke","Is there visible smoke from engine area",.A)
 I A'="Y" S OK=0 G ELECSHX
 I OK D ADDREC("ELECTRICAL SHORT - DANGER!","Disconnect battery NOW! Call mechanic")
ELECSHX ;
 Q
 ;
 ;------------------------------------------
 ; ASK USER A QUESTION
 ; FIX: Proper validation loop, timeout handling
 ;------------------------------------------
ASK(KEY,QUEST,ANS) ;
 N VALID,RESP
 ; Check if already answered
 I $D(KNOWN(KEY)) S ANS=KNOWN(KEY) Q
 ;
 ; Ask until valid answer
 S VALID=0
 F  Q:VALID  D
 . W "  ",QUEST,"? (Y/N): "
 . R RESP:60
 . ; FIX: Handle timeout (empty response)
 . I RESP="" S RESP="N"
 . ; FIX: Normalize entire response
 . S RESP=$$UPPER(RESP)
 . ; FIX: Accept Y/N only
 . I RESP="Y" S ANS="Y",VALID=1 Q
 . I RESP="N" S ANS="N",VALID=1 Q
 . W !,"  Please enter Y or N.",!
 ;
 ; Store answer
 S KNOWN(KEY)=ANS
 Q
 ;
 ;------------------------------------------
 ; ADD DIAGNOSIS RESULT
 ;------------------------------------------
ADDREC(TITLE,ACTION) ;
 S RESCNT=RESCNT+1
 S RESULT(RESCNT,"T")=TITLE
 S RESULT(RESCNT,"A")=ACTION
 Q
 ;
 ;------------------------------------------
 ; DISPLAY RESULTS
 ; FIX: Declared loop variable as NEW
 ;------------------------------------------
SHOWRES ;
 N I
 W !!,"============================================"
 W !,"   DIAGNOSIS RESULT"
 W !,"============================================"
 ;
 I RESCNT=0 D  Q
 . W !,"   Unable to determine specific cause."
 . W !,"   Recommend: See a mechanic."
 . W !,"============================================",!
 ;
 I RESCNT=1 W !,"   Found 1 likely cause:",!
 I RESCNT>1 W !,"   Found ",RESCNT," possible causes:",!
 ;
 F I=1:1:RESCNT D
 . W !,"   ",I,") ",RESULT(I,"T")
 . W !,"      -> ",RESULT(I,"A")
 ;
 W !!,"============================================",!
 Q
 ;
 ;------------------------------------------
 ; ASK TO RUN AGAIN
 ; FIX: Proper validation loop
 ;------------------------------------------
ASKAGAIN ;
 N A,VALID,RESP
 S VALID=0
 F  Q:VALID  D
 . W !,"Run another diagnosis? (Y/N): "
 . R RESP:60
 . I RESP="" S RESP="N"
 . S RESP=$$UPPER(RESP)
 . I RESP="Y" S A="Y",VALID=1 Q
 . I RESP="N" S A="N",VALID=1 Q
 . W !,"Please enter Y or N.",!
 ;
 I A="Y" D INIT,DIAG,ASKAGAIN Q
 W !!,"Thank you! Drive safely.",!!
 Q
 ;
 ;------------------------------------------
 ; UTILITY: Uppercase entire string
 ; FIX: Handle all common responses properly
 ;------------------------------------------
UPPER(X) ;
 N RESULT
 S RESULT=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 ; Handle common variations
 I RESULT="YES" Q "Y"
 I RESULT="NO" Q "N"
 Q RESULT
 ;
 ;------------------------------------------
 ; HELP COMMAND (NEW)
 ;------------------------------------------
HELP ;
 W !!,"============================================"
 W !,"   CAR DIAGNOSIS EXPERT SYSTEM - HELP"
 W !,"============================================"
 W !,"  To start diagnosis: D START^CARDIAG"
 W !,"  Answer with Y or N (yes or no)"
 W !,"  System asks questions and provides"
 W !,"  diagnosis based on your answers."
 W !,"============================================",!!
 Q
 ;
 ;------------------------------------------
 ; END OF ROUTINE
 ;------------------------------------------
