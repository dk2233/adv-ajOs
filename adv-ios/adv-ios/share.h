extern void score(long);
extern long ABBNUM, ACTSPK[], AMBER, ATTACK, AXE, BACK, BATTER, BEAR,
   BIRD, BLOOD, BONUS,
   BOTTLE, CAGE, CAVE, CAVITY, CHAIN, CHASM, CHEST,
CLAM, CLOCK1, CLOCK2;

//starting position of Pirate - to have reference
extern long CHLOC;
//holds id of dead end in inner maze
extern long CHLOC2;
//it says WHETHER WE'RE ALL THE WAY CLOSED
extern long CLOSED;
// CLOSNG SAYS WHETHER IT'S CLOSING TIME YET
extern long CLOSNG;
//  CLSHNT SAYS WHETHER HE'S READ THE CLUE IN THE ENDGAME
extern long CLSHNT;
//*	CONDS	MIN VALUE FOR COND(LOC) IF LOC HAS ANY HINTS

//array with conditions for all location
extern long COND[];
extern long CONDS;
//pointer to text about classification of player
extern long CTEXT[];
//DALTLC IS ALTERNATE INITIAL LOC FOR DWARF, IN CASE ONE OF THEM STARTS OUT ON TOP OF THE ADVENTURER.
extern long DALTLC;

//DETAIL	HOW OFTEN WE'VE SAID "NOT ALLOWED TO GIVE MORE DETAIL"
extern long DETAIL;

//number of dwarves killed
extern long DKILL;

//DSEEN IS TRUE IF DWARF HAS SEEN HIM.
extern long DSEEN[];
//how many times i use GO xxx rather then XXX
extern long IGO;
//*	KNFLOC	0 IF NO KNIFE HERE, LOC IF KNIFE HERE, -1 AFTER CAVEAT
extern long KNFLOC;
//*	LIMIT	LIFETIME OF LAMP (NOT SET HERE)
extern long LIMIT;

//LMWARN SAYS WHETHER HE'S BEEN WARNED ABOUT LAMP GOING DIM
extern long LMWARN;
//*  NOVICE SAYS WHETHER HE ASKED FOR INSTRUCTIONS AT START-UP
extern long NOVICE;
//prior location of each dwarf - to have possibility to go back
extern long ODLOC[];
//*  PANIC SAYS WHETHER HE'S FOUND OUT HE'S TRAPPED IN THE CAVE
extern long PANIC;
// starting location of objects
extern long PLAC[];

//property of each object, initially all has -1 when for the first time looked prop = 0
extern long PROP[];

//STEXT(N) IS SHORT DESCRIPTION OF LOCATION N
extern long STEXT[];

/*TALLY KEEPS TRACK OF HOW MANY ARE NOT YET FOUND, SO WE KNOW
*  WHEN TO CLOSE THE CAVE. */
extern long  TALLY;

//TTEXT IS FOR  SECTION 14 infos
extern long TTEXT[];
//number of turns -> TALLIES HOW MANY COMMANDS HE'S GIVEN (IGNORES YES/NO)
extern long TURNS;


//*  WZDARK SAYS WHETHER THE LOC HE'S LEAVING WAS DARK */
extern long WZDARK;

extern long CLSMAX, CLSSES,
   COINS,   CVAL[],
    DOOR, DPRSSN, DRAGON,  DTOTAL, DWARF, EGGS,
   EMRALD, ENTER_2, ENTRNC, FIND_2, FISSUR, FIXD[], FOOBAR, FOOD,
   GRATE, HINT, HINTED[], HINTLC[], HINTS[][5], HNTMAX,
   HNTSIZ, I, INVENT,  IWEST, J, JADE, K, K2, KEY[], KEYS, KK,
    KNIFE, KQ, L, LAMP,  LINSIZ, LINUSE, LL,
    LOC, LOCK, LOCSIZ, LOCSND[], LOOK, LTEXT[],
   MAGZIN, MAXDIE, MAXTRS, MESH, MESSAG, MIRROR, MXSCOR,
   NEWLOC, NUGGET, NUL, NUMDIE, OBJ, OBJSND[],
   OBJTXT[],  OGRE, OIL, OLDLC2, OLDLOC, OLDOBJ, OYSTER,
    PEARL, PILLOW,  PLANT, PLANT2,  PYRAM,
   RESER, ROD, ROD2, RTXSIZ, RUBY, RUG, SAPPH, SAVED, SAY,
   SCORE, SECT,  SIGN, SNAKE, SPK, STEPS,  STICK,
   STREAM, TABNDX, THRESH, THROW, TK[], TRAVEL[], TRIDNT,
   TRNDEX, TRNLUZ, TRNSIZ, TRNVAL[], TRNVLS, TROLL, TROLL2, TRVS,
   TRVSIZ,  URN, V1, V2, VASE, VEND, VERB,
   VOLCAN, VRBSIZ, VRSION, WATER, WD1, WD1X, WD2, WD2X,
   ZZWORD;

//only to mark that game was initialized
extern long SETUP;
