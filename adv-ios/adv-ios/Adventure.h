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
extern NSMutableArray       *AllLocationDescription;

@interface TextGameFunctions : NSObject
//actual location number
//it is superclass

@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *DataForExitsForLocation;

@property NSMutableArray *LocationClassInstancesArray;

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

@end



@interface LocationItems: TextGameFunctions

//@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *ExitsForLocation;
@property NSString  *LocationDescription;
@property NSMutableArray *ItemsInActualLocation;
@property NSMutableArray *Persons;

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

/////////////////////////////////////////////////////////////////
// Exported   symbol defintions
/////////////////////////////////////////////////////////////////
#define  EXITS_NUMBER_IN_FILES                  @"3"
#define  VOCABULARY_LOCATION_IN_FILES           @"4"

#define  ITEMS_MESSAGES_IN_DATA_FILE            @"5"
#define  ITEMS_LOCATION_IN_DATA_FILE            @"7"


#define  DESTINATION_NUMBER_IN_FILES        1U
#define  TAB_NR_DESTINATION                 1U
#define  RESET                              0U
#define  NR_OF_MARKERS                      30U

#endif /* Adventure_h */
