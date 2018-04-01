//
//  Functions.h
//  adv-ios
//
//  Created by Daniel Kucharski on 01.04.2018.
//  Copyright © 2018 code masterss. All rights reserved.
//

#ifndef Functions_h
#define Functions_h
#import "Protocols.h"


@interface TextGameFunctions : NSObject <GameFunctionProtocol>
//actual location number
//it is superclass

@property NSNumber *location_number;
//all exits for location number
//all data exit for location number
@property NSMutableArray *DataForExitsForLocation;
@property NSMutableArray *LocationClassInstancesArray;
@property id<GameFunctionProtocol> delegate;


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




#endif /* Functions_h */
