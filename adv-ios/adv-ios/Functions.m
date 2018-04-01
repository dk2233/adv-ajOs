//
//  Functions.m
//  adv-ios
//
//  Created by daniel on 25.11.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//
// this module holds definitions of methods for TextGameFunctions
#import <Foundation/Foundation.h>
#import     "Adventure.h"
#import "Functions.h"
#import "GameObjects.h"

#define DARK(DUMMY)	((!CNDBIT(LOC,0)) && (PROP[LAMP] == 0 || !HERE(LAMP)))



@implementation  TextGameFunctions

-(id)initSuper
{
    if( (self = [super init]) )
    {
        _LocationClassInstancesArray = [[NSMutableArray alloc] init];
        NSLog(@"Initialize superclass for Locations ");
    }
    //self.LocationClassInstancesArray = [[NSMutableArray alloc] init];
    return self;
}


-(NSUInteger )SetBitInVar:(NSUInteger)bit_nr var:(NSUInteger)value
{
    NSUInteger temp, bit_set=1;
    temp = bit_set << bit_nr;
    
    return value || temp;
}

//obsolete
-(NSString *)findLocationDescription:(NSString *)StringWithAllData
{
    //NSString *description;
    NSScanner *scanner, *oneLineScanner;
    scanner = [NSScanner scannerWithString:StringWithAllData];
    //self.AllItems = [ [NSMutableArray alloc]init ];
    
    NSString *oneLine;
    NSInteger temp;
    uint8_t stateOfSearching = 0U;
    
    while(![scanner isAtEnd])
    {
        //first find -1 in next line 4
        
        [scanner scanUpToString:@"-1" intoString:NULL ];
        [scanner scanUpToString:@"\n" intoString:NULL];
        
        if ( [scanner  scanString:ITEMS_MESSAGES_IN_DATA_FILE intoString:NULL ] )
        {
            while(  RESET == stateOfSearching )
            {
                [scanner scanUpToString:@"\n" intoString:&oneLine ];
                oneLineScanner = [NSScanner scannerWithString:oneLine];
                
                //if ([oneLine containsString:@"-1"])
                //[oneLine characterAtIndex:0U];
                if ([oneLine isEqualToString:@"-1"])
                {
                    stateOfSearching = 1U;
                    break;
                    //[oneLine ]
                }
                
                [oneLineScanner scanInteger:&temp];
                
            }
            
            if (1 == stateOfSearching )
            {
                break;
            }
        }
    }
    return oneLine;
}



-(void)ShowDescription
{
ShowDescription: NULL;
}
-(void)ShowDescription: (NSNumber *)loc_nr
{
    NSInteger nr_searched;
    NSUInteger condition;
    uint8_t i;
    if (NULL == loc_nr)
    {
        nr_searched = [_location_number integerValue];
    }
    else
    {
        nr_searched = [loc_nr integerValue];
    }
    //printf("nr searched %d \n\n",nr_searched);
    
    condition = [[self.LocationClassInstancesArray  objectAtIndex:nr_searched] LocationConditions];
    
    
    
    if (NO_LIGHT_IN_LOCATION & condition)
    {
        NSLog(@"%@",[[self.LocationClassInstancesArray objectAtIndex:nr_searched] LocationDescription]);
    }
    else
    {
        printf("\n THere is no Light \n");
    }
    uint8_t item_id=0;
    //show item if in that location
    /*SECTION 7: OBJECT LOCATIONS.  EACH LINE CONTAINS AN OBJECT NUMBER AND ITS
     *	INITIAL LOCATION (ZERO (OR OMITTED) IF NONE).  IF THE OBJECT IS
     *	IMMOVABLE, THE LOCATION IS FOLLOWED BY A "-1".  IF IT HAS TWO LOCATIONS
     *	(E.G. THE GRATE) THE FIRST LOCATION IS FOLLOWED WITH THE SECOND, AND
     *	THE OBJECT IS ASSUMED TO BE IMMOVABLE.
     */
    //NSLog(@"%ld",nr_searched);
    for( NSMutableArray *OneArray in AllItemsLocation)
    {
        
        for(i=0U; i<OneArray.count ; i++)
        {
            
            if (nr_searched == [[OneArray objectAtIndex:i ] integerValue ] )
            {
                //NSLog(@"%d",item_id);
                //NSLog(@"%@ object nr %ld",array,a);
                
                //NSLog(@"%@",[[[AllItemMessage objectAtIndex:item_id] objectAtIndex:0] objectAtIndex:1]);
                
            }
        }
        
        
        item_id++;
        
    }
    NSMutableArray *array_items = [[self.LocationClassInstancesArray  objectAtIndex:nr_searched] ItemsInActualLocation];
    for(i=RESET; i< [array_items count]; i++)
    {
        
        NSUInteger item =   [[array_items objectAtIndex:i] integerValue];
        NSUInteger row_to_read = 0;
        if ([[AllItemMessage objectAtIndex:item] count] >1 )
        {
            row_to_read = 1;
        }
        
        NSLog(@"%@",[[[AllItemMessage objectAtIndex:item] objectAtIndex:row_to_read] objectAtIndex:1]  );
        if (TRUE == [[AllItemObjects_Array objectAtIndex:item] IsObjectMoveable])
        {
            NSLog(@"Object is immovable");
        }
    }
    
    //conditions
    NSLog(@"conditions %lu", (unsigned long)condition );
    
    NSLog(@"%@", [[self.LocationClassInstancesArray objectAtIndex:nr_searched] LocationShortDescription]);
    
}


-(void)ShowAllExitData
//: (NSMutableArray *)ExitsForLocation
{
    NSArray *tarray;
    
    for(tarray in _DataForExitsForLocation)
    {
        NSString *exits_string = @" " ;
        exits_string = [exits_string stringByAppendingString:@" all exit are: "];
        NSNumber *i;
        for( ( i) in tarray)
        {
            exits_string = [exits_string stringByAppendingString:[i stringValue] ];
            exits_string = [exits_string stringByAppendingString:@" "];
            
        }
        NSLog(@" %@",exits_string);
    }
    
}


-(void)ShowAllData:(NSMutableArray *) MutableArray
//(NSArray *)data
{
    
    for(NSMutableArray *line in MutableArray )
    {
        NSLog(@"%@",line);
    }
}


-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits
{
    self.DataForExitsForLocation=[[NSMutableArray alloc] init];
    
    NSMutableArray *OneRowOfTab=[[NSMutableArray alloc] init];
    
    NSMutableArray *OneRowOfTab_2=[[NSMutableArray alloc] init];
    NSMutableArray *tab_exits = [[NSMutableArray alloc] init];
    AllExits = [ [NSMutableArray alloc] init ];
    
    //NSLog(@"  exits for %@ ",locNumberToFindExits );
    
    NSInteger nr_searched = [locNumberToFindExits integerValue];
    NSInteger temp;
    
    NSNumber *temp_nsn;
    //NSString *temp_string;
    //NSLog(@"%@",_AllExitCommands);
    for(NSMutableArray *oneArray in AllExitsTable)
    {
        temp_nsn =(NSNumber *)[oneArray objectAtIndex:0];
        
        temp = [temp_nsn integerValue ];
        
        if (  temp == nr_searched)
        {
            
            //If I have found searched number of location in exit line
            OneRowOfTab=[[NSMutableArray alloc] init];
            OneRowOfTab_2 = [[NSMutableArray alloc] init];
            [self.DataForExitsForLocation addObject:OneRowOfTab];
            [tab_exits addObject:OneRowOfTab_2];
            
            for(uint8_t i=0; i<oneArray.count; i++)
            {
                temp_nsn =(NSNumber *)[oneArray objectAtIndex:i];
                [self.DataForExitsForLocation.lastObject addObject:temp_nsn ];
                
                if ( DESTINATION_NUMBER_IN_FILES == i)
                {
                    [tab_exits.lastObject addObject:temp_nsn ];
                }
                else if ( i> DESTINATION_NUMBER_IN_FILES )
                {
                    for( NSMutableArray *rowArray in AllExitCommands)
                    {
                        //NSLog(@"%@",rowArray[0]);
                        if ([rowArray containsObject:temp_nsn])
                        {
                            //NSLog(@"commands %@",[rowArray objectAtIndex:1]);
                            [tab_exits.lastObject addObject:[rowArray objectAtIndex:1] ];
                        }
                    }
                    
                    
                    
                }
            }
            
            [AllExits addObject:[_DataForExitsForLocation.lastObject objectAtIndex:TAB_NR_DESTINATION]];
        }
    }
    NSString *exits_string = @" " ;
    exits_string = [exits_string stringByAppendingString:@" all exit are: "];
    NSNumber *i;
    
    for( i in AllExits)
    {
        exits_string = [exits_string stringByAppendingString:[i stringValue] ];
        exits_string = [exits_string stringByAppendingString:@" "];
        
    }
    NSLog(@" %@",exits_string);
    //break;
    
    /* once it return exit_tab but now i have moved this to property
     *return exit_tab;
     */
    return tab_exits;
};



-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr
{
    boolean_t marker_IcanGO=false;
    //it was used previously to check whether I can go from current location
    //NSArray *tab_a=[loc1 findExits:loc1.location_number];
    NSArray *tarray;
    //value of N number if
    NSNumber *number_N;
    NSNumber *number_M;
    NSInteger varN;
    NSInteger varM;
    if (nr == _location_number)
    {
        NSLog(@" You are already there  %@  to %@",_location_number,nr);
        return marker_IcanGO;
    }
    for(tarray in self.DataForExitsForLocation)
    {
        number_N = [tarray objectAtIndex:TAB_NR_DESTINATION];
        varN =  [number_N integerValue] %1000  ;
        number_N = [NSNumber numberWithInteger:varN];
        
        number_M = [tarray objectAtIndex:TAB_NR_DESTINATION];
        varM =  [number_M integerValue]/1000  ;
        number_M = [NSNumber numberWithInteger:varM];
        
        /*		IF N<=300	IT IS THE LOCATION TO GO TO.
         *		IF 300<N<=500	N-300 IS USED IN A COMPUTED GOTO TO
         *					A SECTION OF SPECIAL CODE.
         *		IF N>500	MESSAGE N-500 FROM SECTION 6 IS PRINTED,
         *					AND HE STAYS WHEREVER HE IS.
         */
        //NSLog(@" nr = %@ and numberN %@ ",nr, number_N);
        if  ([nr isEqual:[tarray objectAtIndex:TAB_NR_DESTINATION]])
            //&&
        {
            NSLog(@" number M %@ number N %@",number_M, number_N);
            
            if ( (varN<=300) && (0 == varM) )
            {
                NSLog(@"exit possible : %@",number_N);
                
                
                _location_number = nr;
                
                marker_IcanGO =TRUE;
                break;
            }
            else if ((varM >0 ) && (varM<100))
            {
                
                NSLog(@" i can go with probablity %ld ",(long)varM);
                uint32_t rand_u32 = arc4random_uniform(100U);
                if (rand_u32 < varM)
                {
                    _location_number = nr;
                    
                    marker_IcanGO =TRUE;
                    break;
                    
                }
                else
                {
                    NSLog(@"probability was %d %%",rand_u32);
                }
            }
            
        }
        //else if
        else
        {
            //NSLog(@"not equal %@ =! %@",loc_nr,[tarray objectAtIndex:TAB_NO_DESTINATION]);
        }
    }
    if (false == marker_IcanGO)
    {
        NSLog(@" i can't go from  %@  to %@",_location_number,nr);
    }
    
    return marker_IcanGO;
}




-(NSMutableArray *)CheckAllExitsCommandForLocation
{
    //This method is for extracting from table with exits
    NSMutableArray *tab;
    
    return tab;
}


-(NSUInteger)findConditionForLocation:(NSUInteger) Loc fromAllData:(NSString *)StringWithAllData
{
    //NSString *description;
    NSScanner *scanner, *oneLineScanner;
    scanner = [NSScanner scannerWithString:StringWithAllData];
    //self.AllItems = [ [NSMutableArray alloc]init ];
    
    NSString *oneLine;
    NSUInteger temp, bit_nr, condition=0U;
    uint8_t stateOfSearching = 0U;
    
    while(![scanner isAtEnd])
    {
        //first find -1 in next line 4
        
        [scanner scanUpToString:@"-1" intoString:NULL ];
        [scanner scanUpToString:@"\n" intoString:NULL];
        
        if ( [scanner  scanString:LOCATION_CONDITION_IN_DATA intoString:NULL ] )
        {
            while(  RESET == stateOfSearching )
            {
                [scanner scanUpToString:@"\n" intoString:&oneLine ];
                oneLineScanner = [NSScanner scannerWithString:oneLine];
                
                if ([oneLine isEqualToString:@"-1"])
                {
                    stateOfSearching = 1U;
                    break;
                    //[oneLine ]
                }
                //bit nr
                [oneLineScanner scanInteger:&bit_nr];
                
                //now check if there is Loc in that line for that bit
                while( ![oneLineScanner isAtEnd]  )
                {
                    [oneLineScanner scanInteger:&temp];
                    if (temp == Loc)
                    {
                        // i am setting that bit
                        condition = [self SetBitInVar:temp var:condition];
                    }
                }
                
                
            }
            
            if (1 == stateOfSearching )
            {
                break;
            }
        }
    }
    return condition;
}



@end
