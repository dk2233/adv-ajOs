//
//  init.m
//  adv-ios
//
//  Created by daniel on 19.11.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Adventure.h"
#import "Game_Types.h"


NSMutableArray       *AllLocationDescription;
NSMutableArray  *AllItemObjects;

/*
 * INITIALISATION
 */

/*  CURRENT LIMITS:
 *     12500 WORDS OF MESSAGE TEXT (LINES, LINSIZ).
 *	885 TRAVEL OPTIONS (TRAVEL, TRVSIZ).
 *	330 VOCABULARY WORDS (KTAB, ATAB, TABSIZ).
 *	185 LOCATIONS (LTEXT, STEXT, KEY, COND, ABB, ATLOC, LOCSND, LOCSIZ).
 *	100 OBJECTS (PLAC, PLACE, FIXD, FIXED, LINK (TWICE), PTEXT, PROP,
 *                    OBJSND, OBJTXT).
 *	 35 "ACTION" VERBS (ACTSPK, VRBSIZ).
 *	277 RANDOM MESSAGES (RTEXT, RTXSIZ).
 *	 12 DIFFERENT PLAYER CLASSIFICATIONS (CTEXT, CVAL, CLSMAX).
 *	 20 HINTS (HINTLC, HINTED, HINTS, HNTSIZ).
 *         5 "# OF TURNS" THRESHHOLDS (TTEXT, TRNVAL, TRNSIZ).
 *  THERE ARE ALSO LIMITS WHICH CANNOT BE EXCEEDED DUE TO THE STRUCTURE OF
 *  THE DATABASE.  (E.G., THE VOCABULARY USES N/1000 TO DETERMINE WORD TYPE,
 *  SO THERE CAN'T BE MORE THAN 1000 WORDS.)  THESE UPPER LIMITS ARE:
 *	1000 NON-SYNONYMOUS VOCABULARY WORDS
 *	300 LOCATIONS
 *	100 OBJECTS */


/*  DESCRIPTION OF THE DATABASE FORMAT
 *
 *
 *  THE DATA FILE CONTAINS SEVERAL SECTIONS.  EACH BEGINS WITH A LINE CONTAINING
 *  A NUMBER IDENTIFYING THE SECTION, AND ENDS WITH A LINE CONTAINING "-1".
 *
 *  SECTION 1: LONG FORM DESCRIPTIONS.  EACH LINE CONTAINS A LOCATION NUMBER,
 *	A TAB, AND A LINE OF TEXT.  THE SET OF (NECESSARILY ADJACENT) LINES
 *	WHOSE NUMBERS ARE X FORM THE LONG DESCRIPTION OF LOCATION X.
 *  SECTION 2: SHORT FORM DESCRIPTIONS.  SAME FORMAT AS LONG FORM.  NOT ALL
 *	PLACES HAVE SHORT DESCRIPTIONS.
 *  SECTION 3: TRAVEL TABLE.  EACH LINE CONTAINS A LOCATION NUMBER (X), A SECOND
 *	LOCATION NUMBER (Y), AND A LIST OF MOTION NUMBERS (SEE SECTION 4).
 *	EACH MOTION REPRESENTS A VERB WHICH WILL GO TO Y IF CURRENTLY AT X.
 *	Y, IN TURN, IS INTERPRETED AS FOLLOWS.  LET M=Y/1000, N=Y MOD 1000.
 *		IF N<=300	IT IS THE LOCATION TO GO TO.
 *		IF 300<N<=500	N-300 IS USED IN A COMPUTED GOTO TO
 *					A SECTION OF SPECIAL CODE.
 *		IF N>500	MESSAGE N-500 FROM SECTION 6 IS PRINTED,
 *					AND HE STAYS WHEREVER HE IS.
 *	MEANWHILE, M SPECIFIES THE CONDITIONS ON THE MOTION.
 *		IF M=0		IT'S UNCONDITIONAL.
 *		IF 0<M<100	IT IS DONE WITH M% PROBABILITY.
 *		IF M=100	UNCONDITIONAL, BUT FORBIDDEN TO DWARVES.
 *		IF 100<M<=200	HE MUST BE CARRYING OBJECT M-100.
 *		IF 200<M<=300	MUST BE CARRYING OR IN SAME ROOM AS M-200.
 *		IF 300<M<=400	PROP(M MOD 100) MUST *NOT* BE 0.
 *		IF 400<M<=500	PROP(M MOD 100) MUST *NOT* BE 1.
 *		IF 500<M<=600	PROP(M MOD 100) MUST *NOT* BE 2, ETC.
 *	IF THE CONDITION (IF ANY) IS NOT MET, THEN THE NEXT *DIFFERENT*
 *	"DESTINATION" VALUE IS USED (UNLESS IT FAILS TO MEET *ITS* CONDITIONS,
 *	IN WHICH CASE THE NEXT IS FOUND, ETC.).  TYPICALLY, THE NEXT DEST WILL
 *	BE FOR ONE OF THE SAME VERBS, SO THAT ITS ONLY USE IS AS THE ALTERNATE
 *	DESTINATION FOR THOSE VERBS.  FOR INSTANCE:
 *		15	110022	29	31	34	35	23	43
 *		15	14	29
 *	THIS SAYS THAT, FROM LOC 15, ANY OF THE VERBS 29, 31, ETC., WILL TAKE
 *	HIM TO 22 IF HE'S CARRYING OBJECT 10, AND OTHERWISE WILL GO TO 14.
 *		11	303008	49
 *		11	9	50
 *	THIS SAYS THAT, FROM 11, 49 TAKES HIM TO 8 UNLESS PROP(3)=0, IN WHICH
 *	CASE HE GOES TO 9.  VERB 50 TAKES HIM TO 9 REGARDLESS OF PROP(3).
 *
 *  SECTION 4: VOCABULARY.  EACH LINE CONTAINS A NUMBER (N), A TAB, AND A
 *	FIVE-LETTER WORD.  CALL M=N/1000.  IF M=0, THEN THE WORD IS A MOTION
 *	VERB FOR USE IN TRAVELLING (SEE SECTION 3).  ELSE, IF M=1, THE WORD IS
 *	AN OBJECT.  ELSE, IF M=2, THE WORD IS AN ACTION VERB (SUCH AS "CARRY"
 *	OR "ATTACK").  ELSE, IF M=3, THE WORD IS A SPECIAL CASE VERB (SUCH AS
 *	"DIG") AND N MOD 1000 IS AN INDEX INTO SECTION 6.  OBJECTS FROM 50 TO
 *	(CURRENTLY, ANYWAY) 79 ARE CONSIDERED TREASURES (FOR PIRATE, CLOSEOUT).
 *
 *  SECTION 5: OBJECT DESCRIPTIONS.  EACH LINE CONTAINS A NUMBER (N), A TAB,
 *	AND A MESSAGE.  IF N IS FROM 1 TO 100, THE MESSAGE IS THE "INVENTORY"
 *	MESSAGE FOR OBJECT N.  OTHERWISE, N SHOULD BE 000, 100, 200, ETC., AND
 *	THE MESSAGE SHOULD BE THE DESCRIPTION OF THE PRECEDING OBJECT WHEN ITS
 *	PROP VALUE IS N/100.  THE N/100 IS USED ONLY TO DISTINGUISH MULTIPLE
 *	MESSAGES FROM MULTI-LINE MESSAGES; THE PROP INFO ACTUALLY REQUIRES ALL
 *	MESSAGES FOR AN OBJECT TO BE PRESENT AND CONSECUTIVE.  PROPERTIES WHICH
 *	PRODUCE NO MESSAGE SHOULD BE GIVEN THE MESSAGE ">$<".
 *
 *  SECTION 6: ARBITRARY MESSAGES.  SAME FORMAT AS SECTIONS 1, 2, AND 5, EXCEPT
 *	THE NUMBERS BEAR NO RELATION TO ANYTHING (EXCEPT FOR SPECIAL VERBS
 *	IN SECTION 4).
 *
 *  SECTION 7: OBJECT LOCATIONS.  EACH LINE CONTAINS AN OBJECT NUMBER AND ITS
 *	INITIAL LOCATION (ZERO (OR OMITTED) IF NONE).  IF THE OBJECT IS
 *	IMMOVABLE, THE LOCATION IS FOLLOWED BY A "-1".  IF IT HAS TWO LOCATIONS
 *	(E.G. THE GRATE) THE FIRST LOCATION IS FOLLOWED WITH THE SECOND, AND
 *	THE OBJECT IS ASSUMED TO BE IMMOVABLE.
 *  SECTION 8: ACTION DEFAULTS.  EACH LINE CONTAINS AN "ACTION-VERB" NUMBER AND
 *	THE INDEX (IN SECTION 6) OF THE DEFAULT MESSAGE FOR THE VERB.
 *  SECTION 9: LOCATION ATTRIBUTES.  EACH LINE CONTAINS A NUMBER (N) AND UP TO
 *	20 LOCATION NUMBERS.  BIT N (WHERE 0 IS THE UNITS BIT) IS SET IN
 *	COND(LOC) FOR EACH LOC GIVEN.  THE COND BITS CURRENTLY ASSIGNED ARE:
 *		0	LIGHT
 *		1	IF BIT 2 IS ON: ON FOR OIL, OFF FOR WATER
 *		2	LIQUID ASSET, SEE BIT 1
 *		3	PIRATE DOESN'T GO HERE UNLESS FOLLOWING PLAYER
 *		4	CANNOT USE "BACK" TO MOVE AWAY
 *	BITS PAST 10 INDICATE AREAS OF INTEREST TO "HINT" ROUTINES:
 *		11	TRYING TO GET INTO CAVE
 *		12	TRYING TO CATCH BIRD
 *		13	TRYING TO DEAL WITH SNAKE
 *		14	LOST IN MAZE
 *		15	PONDERING DARK ROOM
 *		16	AT WITT'S END
 *		17	CLIFF WITH URN
 *		18	LOST IN FOREST
 *		19	TRYING TO DEAL WITH OGRE
 *		20	FOUND ALL TREASURES EXCEPT JADE
 *	COND(LOC) IS SET TO 2, OVERRIDING ALL OTHER BITS, IF LOC HAS FORCED
 *	MOTION.
 *  SECTION 10: CLASS MESSAGES.  EACH LINE CONTAINS A NUMBER (N), A TAB, AND A
 *	MESSAGE DESCRIBING A CLASSIFICATION OF PLAYER.  THE SCORING SECTION
 *	SELECTS THE APPROPRIATE MESSAGE, WHERE EACH MESSAGE IS CONSIDERED TO
 *	APPLY TO PLAYERS WHOSE SCORES ARE HIGHER THAN THE PREVIOUS N BUT NOT
 *	HIGHER THAN THIS N.  NOTE THAT THESE SCORES PROBABLY CHANGE WITH EVERY
 *	MODIFICATION (AND PARTICULARLY EXPANSION) OF THE PROGRAM.
 *  SECTION 11: HINTS.  EACH LINE CONTAINS A HINT NUMBER (ADD 10 TO GET COND
 *	BIT; SEE SECTION 9), THE NUMBER OF TURNS HE MUST BE AT THE RIGHT LOC(S)
 *	BEFORE TRIGGERING THE HINT, THE POINTS DEDUCTED FOR TAKING THE HINT,
 *	THE MESSAGE NUMBER (SECTION 6) OF THE QUESTION, AND THE MESSAGE NUMBER
 *	OF THE HINT.  THESE VALUES ARE STASHED IN THE "HINTS" ARRAY.  HNTMAX IS
 *	SET TO THE MAX HINT NUMBER (<= HNTSIZ).
 *  SECTION 12: UNUSED IN THIS VERSION.
 *  SECTION 13: SOUNDS AND TEXT.  EACH LINE CONTAINS EITHER 2 OR 3 NUMBERS.  IF
 *	2 (CALL THEM N AND S), N IS A LOCATION AND MESSAGE ABS(S) FROM SECTION
 *	6 IS THE SOUND HEARD THERE.  IF S<0, THE SOUND THERE DROWNS OUT ALL
 *	OTHER NOISES.  IF 3 NUMBERS (CALL THEM N, S, AND T), N IS AN OBJECT
 *	NUMBER AND S+PROP(N) IS THE PROPERTY MESSAGE (FROM SECTION 5) IF HE
 *	LISTENS TO THE OBJECT, AND T+PROP(N) IS THE TEXT IF HE READS IT.  IF
 *	S OR T IS -1, THE OBJECT HAS NO SOUND OR TEXT, RESPECTIVELY.  NEITHER
 *	S NOR T IS ALLOWED TO BE 0.
 *  SECTION 14: TURN THRESHHOLDS.  EACH LINE CONTAINS A NUMBER (N), A TAB, AND
 *	A MESSAGE BERATING THE PLAYER FOR TAKING SO MANY TURNS.  THE MESSAGES
 *	MUST BE IN THE PROPER (ASCENDING) ORDER.  THE MESSAGE GETS PRINTED IF
 *	THE PLAYER EXCEEDS N MOD 100000 TURNS, AT WHICH TIME N/100000 POINTS
 *	GET DEDUCTED FROM HIS SCORE.
 *  SECTION 0: END OF DATABASE. */

/*  THE VARIOUS MESSAGES (SECTIONS 1, 2, 5, 6, ETC.) MAY INCLUDE CERTAIN
 *  SPECIAL CHARACTER SEQUENCES TO DENOTE THAT THE PROGRAM MUST PROVIDE
 *  PARAMETERS TO INSERT INTO A MESSAGE WHEN THE MESSAGE IS PRINTED.  THESE
 *  SEQUENCES ARE:
 *	%S = THE LETTER 'S' OR NOTHING (IF A GIVEN VALUE IS EXACTLY 1)
 *	%W = A WORD (UP TO 10 CHARACTERS)
 *	%L = A WORD MAPPED TO LOWER-CASE LETTERS
 *	%U = A WORD MAPPED TO UPPER-CASE LETTERS
 *	%C = A WORD MAPPED TO LOWER-CASE, FIRST LETTER CAPITALISED
 *	%T = SEVERAL WORDS OF TEXT, ENDING WITH A WORD OF -1
 *	%1 = A 1-DIGIT NUMBER
 *	%2 = A 2-DIGIT NUMBER
 *	...
 *	%9 = A 9-DIGIT NUMBER
 *	%B = VARIABLE NUMBER OF BLANKS
 *	%! = THE ENTIRE MESSAGE SHOULD BE SUPPRESSED */

void initializeGame(void)
{
    NSUInteger   var_i, iter;
    NSString *temp;
    uint8_t item_id=0;
    AllLocationDescription = [ToolsForTexts findAllLocationDescription:ToolsForTexts.AllDataFromFile];
    
    NSLog(@"Number of location %lu",(unsigned long)ToolsForTexts.NumberOfLocation);
    //here i put a loop to create class instances for all location
    //loc_main_func.LocationClassInstancesArray = [[NSMutableArray alloc] init];
    for(var_i = RESET; var_i < ToolsForTexts.NumberOfLocation; var_i++)
    {
        LocationItems *loc_item = [[LocationItems alloc] init];
        
        loc_item.LocationDescription =[AllLocationDescription objectAtIndex:var_i];
        loc_item.ExitsForLocation = [AllExitsTable objectAtIndex:var_i];
        [loc_item setLocationConditions:[LocationFunctions findConditionForLocation:var_i fromAllData:[ToolsForTexts AllDataFromFile]]];
        
        //show item if in that location
        /*SECTION 7: OBJECT LOCATIONS.  EACH LINE CONTAINS AN OBJECT NUMBER AND ITS
         *	INITIAL LOCATION (ZERO (OR OMITTED) IF NONE).  IF THE OBJECT IS
         *	IMMOVABLE, THE LOCATION IS FOLLOWED BY A "-1".  IF IT HAS TWO LOCATIONS
         *	(E.G. THE GRATE) THE FIRST LOCATION IS FOLLOWED WITH THE SECOND, AND
         *	THE OBJECT IS ASSUMED TO BE IMMOVABLE.
         */
        item_id = 0U;
        for( NSMutableArray *OneArray in AllItemsLocation)
        {
            
            for(iter=0U; iter<OneArray.count ; iter++)
            {
                
                if (var_i == [[OneArray objectAtIndex:iter ] integerValue ] )
                {
                    [loc_item.ItemsInActualLocation addObject:[NSNumber numberWithInt:item_id]];
                    
                    //NSLog(@"%@",[[[AllItemMessage objectAtIndex:item_id] objectAtIndex:0] objectAtIndex:1]);
                    
                }
            }
            
            item_id++;
            
        }
        
        
        [LocationFunctions.LocationClassInstancesArray addObject: loc_item];
        //[loc_item release];
        //NSLog([[LocationFunctions.LocationClassInstancesArray lastObject] LocationDescription] );
        //NSLog([[LocationFunctions.LocationClassInstancesArray objectAtIndex:var_i] LocationDescription] );
    }
    
    NSMutableArray *AllItemObjects_Array = [[NSMutableArray alloc] init];
    
    for(var_i = RESET; var_i < AllItemMessage.count; var_i++)
    {
//        if ([[AllItemMessage objectAtIndex:var_i] count] == 0)
//        {
//            continue;
//        }
        GameObjects *objects_instance = [[GameObjects alloc] init] ;
        
        //NSLog(@"info %@",[AllItemMessage objectAtIndex:var_i]);
        
        for( iter = RESET; iter < [[AllItemMessage objectAtIndex:var_i] count]; iter++)
        {
         
            temp =[[AllItemMessage objectAtIndex:var_i] objectAtIndex:iter ];
            
            [[objects_instance ObjectDescription] addObject:temp];
            //NSLog(@"added : %@",[objects_instance.ObjectDescription lastObject]);
            
        }
        
        [objects_instance setPropOfObject:0];
        objects_instance.LocationOfObject = 0;
        
        
        
        [AllItemObjects_Array addObject:objects_instance];
        
        //NSLog(@"how many %ld",[[[AllItemObjects_Array objectAtIndex:var_i] ObjectDescription] count] );
        //NSLog(@"how many %ld",[objects_instance.ObjectDescription count]);
        if (0 != [[[AllItemObjects_Array objectAtIndex:var_i] ObjectDescription] count])
        {
            //NSLog(@"test %@",[[AllItemObjects_Array objectAtIndex:var_i] ObjectDescription]);
        }
    }
    
}


void initializeDwarfs(void)
{
    
    /*  INITIALISE THE DWARVES.  DLOC IS LOC OF DWARVES, HARD-WIRED IN.  ODLOC IS
     *  PRIOR LOC OF EACH DWARF, INITIALLY GARBAGE.  DALTLC IS ALTERNATE INITIAL LOC
     *  FOR DWARF, IN CASE ONE OF THEM STARTS OUT ON TOP OF THE ADVENTURER.  (NO 2
     *  OF THE 5 INITIAL LOCS ARE ADJACENT.)  DSEEN IS TRUE IF DWARF HAS SEEN HIM.
     *  DFLAG CONTROLS THE LEVEL OF ACTIVATION OF ALL THIS:
     *	0	NO DWARF STUFF YET (WAIT UNTIL REACHES HALL OF MISTS)
     *	1	REACHED HALL OF MISTS, BUT HASN'T MET FIRST DWARF
     *	2	MET FIRST DWARF, OTHERS START MOVING, NO KNIVES THROWN YET
     *	3	A KNIFE HAS BEEN THROWN (FIRST SET ALWAYS MISSES)
     *	3+	DWARVES ARE MAD (INCREASES THEIR ACCURACY)
     *  SIXTH DWARF IS SPECIAL (THE PIRATE).  HE ALWAYS STARTS AT HIS CHEST'S
     *  EVENTUAL LOCATION INSIDE THE MAZE.  THIS LOC IS SAVED IN CHLOC FOR REF.
     *  THE DEAD END IN THE OTHER MAZE HAS ITS LOC STORED IN CHLOC2. */

}