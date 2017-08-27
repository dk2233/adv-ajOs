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
NSString             *AllDataFromFile;
//all exits
NSMutableArray       *AllExitsTable;
NSMutableArray       *AllItems;
NSMutableArray       *AllItemsLocation;
NSMutableArray       *AllItemMessage;
//table with all commands that are for exit number
NSMutableArray       *AllExitCommands;
NSMutableArray       *AllExits;





@interface ToolsForLocation : NSObject

+(void)findAllExitTable;
+(void)findAllCommandsTable;
+(void)findAllItemStartLocation;
+(void)findAllItemMessage;
+(NSString *)WaitForCommand;
+(void)AnalyzeCommandFromUser:(NSString *)wordFromUser tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab actual_location:(id)LocationActual;
              //

   //MovingMethodFromOtherClass:(SEL)WhenIWantMoving;

@end



@interface Location : NSObject
//actual location number
@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *DataForExitsForLocation;

-(id)init;
-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits;
-(void)findThisItemMessage:(NSNumber *)ItemNumber;
-(void)ShowDescription;
-(void)ShowAllData;
-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr;
-(void)ShowAllExitData;
-(NSMutableArray *)CheckAllExitsCommandForLocation;

@end

/////////////////////////////////////////////////////////////////
// Exported   symbol defintions
/////////////////////////////////////////////////////////////////
#define  EXITS_NUMBER_IN_FILES                  @"3"
#define  VOCABULARY_LOCATION_IN_FILES           @"4"
#define  ITEMS_LOCATION_IN_DATA_FILE            @"7"
#define  ITEMS_MESSAGES_IN_DATA_FILE            @"5"

#define  DESTINATION_NUMBER_IN_FILES        1U
#define  TAB_NR_DESTINATION                 1U
#define  RESET                              0U


#endif /* Adventure_h */
