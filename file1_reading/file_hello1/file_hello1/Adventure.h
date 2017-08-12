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
@property NSMutableArray *AllExits;
//all data exit for location number
@property NSMutableArray *DataForExits;
//all data from file
@property NSString *AllData;
//table with all commands that are for exit number
@property NSMutableArray *AllExitCommands;
//all exits
@property NSMutableArray *AllExitsTable;

@property NSMutableArray *AllItems;
@property NSMutableArray *AllItemsLocation;

+(void)initialize;
+(void)sayHello;
-(NSNumber *)addTwoValues:(uint16_t)val1 withNumber:(uint16_t)val2;
-(void)WriteOtherWord;

-(id)init;

-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits;

-(void)findAllExitTable;
-(void)findAllCommandsTable;
-(void)findAllItemStartLocation;

-(void)ShowDescription;

-(void)ShowAllData;
-(NSString *)WaitForCommand;
-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr;
-(void)ShowAllExitData;
-(void)AnalyzeCommandFromUser:(NSString *)word  tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab;
-(NSMutableArray *)CheckAllExitsCommandForLocation;
@end




#endif /* Adventure_h */
