
//control if abbreviated command will be used
extern long ABB[];
//AND FIXD ARRAYS ARE USED TO SET UP ATAB[] AS THE FIRST
//*  OBJECT AT LOCATION N
//keep all action words
extern long ATAB[];
//keep all keys - number that are for specific action word
extern long KTAB[];
extern long   ATLOC[];

extern long BLKLIN,  FIXED[], HOLDNG,
		 *LINES_ADV, LINK[], LNLENG, LNPOSN,
		PARMS[], PLACE[], TABSIZ;
extern signed char INLINE[], MAP1[], MAP2[];

//dwarf location array
extern long DLOC[];
/*
 *  DFLAG CONTROLS THE LEVEL OF ACTIVATION OF ALL THIS:
 *	0	NO DWARF STUFF YET (WAIT UNTIL REACHES HALL OF MISTS)
 *	1	REACHED HALL OF MISTS, BUT HASN'T MET FIRST DWARF
 *	2	MET FIRST DWARF, OTHERS START MOVING, NO KNIVES THROWN YET
 *	3	A KNIFE HAS BEEN THROWN (FIRST SET ALWAYS MISSES)
 *	3+	DWARVES ARE MAD (INCREASES THEIR ACCURACY)
 *  SIXTH DWARF IS SPECIAL (THE PIRATE).  HE ALWAYS STARTS AT HIS CHEST'S
 *  EVENTUAL LOCATION INSIDE THE MAZE.  THIS LOC IS SAVED IN CHLOC FOR REF.
 *  THE DEAD END IN THE OTHER MAZE HAS ITS LOC STORED IN CHLOC2. */
extern long DFLAG;

//responses text from section 6
extern long RTEXT[];

//POINTS TO MESSAGE FOR PROP(N)=0. - so message for objects
extern long PTEXT[];
