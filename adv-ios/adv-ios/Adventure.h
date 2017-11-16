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




/////////////////////////////////////////////////////////////////
// Exported Tables
/////////////////////////////////////////////////////////////////

//all data from file
extern NSString             *AllDataFromFile;
//all exits
extern NSMutableArray       *AllExitsTable;
extern NSMutableArray       *AllItems;
extern NSMutableArray       *AllItemsLocation;
extern NSMutableArray       *AllItemMessage;
//table with all commands that are for exit number
extern NSMutableArray       *AllExitCommands;
extern NSMutableArray       *AllExits;
extern NSMutableArray       *AllLocationDescription;
extern NSMutableArray       *LocationClassInstancesArray;
extern NSUInteger           NumberOfLocation;



@interface LocationFunctions : NSObject
//actual location number

@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *DataForExitsForLocation;

@property NSMutableArray *LocationClassInstancesArray;

//@property NSMutableArray *LocationClassInstancesArray;

-(id)init;
-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits;
-(void)findThisItemMessage:(NSNumber *)ItemNumber;
-(void)ShowDescription:(NSNumber *)loc_nr;
-(void)ShowDescription;
-(void)ShowAllData;
-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr;
-(void)ShowAllExitData;
//: (NSMutableArray *)ExitsForLocation;
-(NSMutableArray *)CheckAllExitsCommandForLocation;

@end



@interface LocationItems: LocationFunctions

//@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *ExitsForLocation;
@property NSString  *LocationDescription;
@property NSMutableArray *LocationItems;
@property NSMutableArray *Persons;

//@property

//@property
-(id)init;

@end

@interface ToolsForLocation : NSObject

+(NSMutableArray *)findAllLocationDescription: (NSString *)BigStringData;
+(NSUInteger)FindNumberOfLocation;
+(void)ReadDataFile;
+(void)findAllExitTable;
+(void)findAllCommandsTable;
+(void)findAllItemStartLocation;
+(void)findAllItemMessage;
+(NSString *)WaitForCommand;
+(void)AnalyzeCommandFromUser:(NSString *)wordFromUser tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab actual_location:(LocationFunctions *)LocationActual;

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