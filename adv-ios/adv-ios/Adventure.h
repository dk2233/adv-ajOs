//
//  Adventure.h
//  file_hello1
//
//  Created by daniel on 11.08.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//

#ifndef Adventure_h
#define Adventure_h
#include    "main.h"
#include    "misc.h"
#include    "funcs.h"
#include    "share.h"



extern void initializeGame(void);

#define ADV_FILE_WITH_DATA  "adventure.text"


#define INIT_PropOfObject -1

/////////////////////////////////////////////////////////////////
// Exported Tables
/////////////////////////////////////////////////////////////////

//all data from file
//extern
//all exits
extern NSMutableArray       *AllExitsTable;
extern NSMutableArray       *AllItems;
extern NSMutableArray       *AllItemsLocation;
extern NSMutableArray       *AllItemMessage;
//table with all commands that are for exit number
extern NSMutableArray       *AllExitCommands;
extern NSMutableArray       *AllExits;
//extern NSMutableArray       *AllLocationDescription;
//extern NSMutableArray       *AllShortLocationDescription;
extern NSMutableArray       *AllItemObjects_Array;










@interface TextGameFunctions : NSObject
//actual location number
//it is superclass

@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *DataForExitsForLocation;
@property NSMutableArray *LocationClassInstancesArray;

-(NSUInteger )SetBitInVar:(NSUInteger)bit_nr var:(NSUInteger)value;

-(id)initSuper;
-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits;
-(NSString *)findLocationDescription:(NSString *)StringWithAllData;
//-(void)findThisItemMessage:(NSNumber *)ItemNumber fromThatArray:(NSMutableArray *)ArrayWithItemMessage;
-(void)ShowDescription:(NSNumber *)loc_nr;
-(void)ShowDescription;
-(void)ShowAllData:(NSMutableArray *) MutableArray;
-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr;
-(void)ShowAllExitData;
//: (NSMutableArray *)ExitsForLocation;
-(NSMutableArray *)CheckAllExitsCommandForLocation;
-(NSUInteger)findConditionForLocation:(NSUInteger) Loc fromAllData:(NSString *)StringWithAllData;

@end


@interface LocationItems: TextGameFunctions

//@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *ExitsForLocation;
@property NSString  *LocationDescription;
@property NSString  *LocationShortDescription;
@property NSMutableArray *ItemsInActualLocation;
@property NSMutableArray *Persons;

@property NSUInteger LocationConditions;


//@property

//@property
-(id)init;

@end











@interface ToolsForTextGame : NSObject

@property NSString             *AllDataFromFile;
//LOCSIZ
@property NSUInteger NumberOfLocation;

//@property NSMutableArray        *AllItemMessage;
//@property NSMutableArray       *AllItemsLocation;

-(id)initGame;
-(NSMutableArray *)findAllLocationDescription: (NSString *)BigStringData;
-(NSMutableArray *)findAllShortLocationDescription: (NSString *)BigStringData;
-(NSUInteger)FindNumberOfLocation;
-(void)ReadDataFile;
-(void)findAllExitTable;
-(void)findAllCommandsTable;
-(void)findAllItemStartLocation;
-(void)findAllItemMessage;
+(NSString *)WaitForCommand;
-(void)AnalyzeCommandFromUser:(NSString *)wordFromUser tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab actual_location:(TextGameFunctions *)LocationActual;

+(void)WriteMarkers: (NSUInteger)nr_of_symbols;
//

//MovingMethodFromOtherClass:(SEL)WhenIWantMoving;

@end








@interface GameObjects: NSObject
// it is the class for one object properties, location, if it was taken,
// if it was used or destroyed
//LOC
@property NSUInteger LocationOfObject;
//adequte to PROP[]
@property NSInteger PropOfObject;
//it is PTEXT[]
@property  NSMutableArray* ObjectDescription;

@property  boolean_t IsObjectMoveable;
@end









/////////////////////////////////////////////////////////////////
// Exported   symbol defintions
/////////////////////////////////////////////////////////////////
#define  SHORT_DESCRIPTION_IN_FILES             2U
#define  EXITS_NUMBER_IN_FILES                  @"3"
#define  VOCABULARY_LOCATION_IN_FILES           @"4"

#define  ITEMS_MESSAGES_IN_DATA_FILE            @"5"
#define  ITEMS_LOCATION_IN_DATA_FILE            @"7"
#define  LOCATION_CONDITION_IN_DATA             @"9"


#define  DESTINATION_NUMBER_IN_FILES        1U
#define  TAB_NR_DESTINATION                 1U
#define  RESET                              0U
#define  NR_OF_MARKERS                      30U

#define  NO_LIGHT_IN_LOCATION               1

#endif /* Adventure_h */
