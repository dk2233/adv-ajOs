//
//  Adventure.h
//  file_hello1
//
//  Created by daniel on 11.08.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//

#ifndef Adventure_h
#define Adventure_h



@interface Location : NSObject
//actual location number
@property NSNumber *location_number;
//all exits for location number
 //all data exit for location number
@property NSMutableArray *DataForExitsForLocation;

-(id)init;

-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits;

-(void)findAllExitTable;
-(void)findAllCommandsTable;
-(void)findAllItemStartLocation;
-(void)findAllItemMessage;


-(void)findThisItemMessage:(NSNumber *)ItemNumber;

-(void)ShowDescription;

-(void)ShowAllData;
-(NSString *)WaitForCommand;
-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr;
-(void)ShowAllExitData;
-(void)AnalyzeCommandFromUser:(NSString *)word  tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab;
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



#endif /* Adventure_h */
