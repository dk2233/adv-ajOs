////////////////////////////////////////////////////////////////
//
//  main.m
//  file_hello1
//
//  Created by daniel on 01.07.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//
//  simple adventure implementation
// for now I know how to walk between places
//items locatoin
//
//
/////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////
// Include
/////////////////////////////////////////////////////////////////

#import     <Foundation/Foundation.h>
#include    "stdlib.h"
#import     "Adventure.h"



NSNumber            *nr_of_treasure;
NSNumber            *nr;
NSMutableArray      *AllExits;
NSUInteger          NumberOfLocation;

/*
 this classs is for 
 finding all location description
 
 so methods of this class will be showing all
 :
 : desciption
 : exits from location
 
 for given property *location_number
 
 
 */









@implementation  LocationFunctions

-(id)init
{
    
    return self;
}



+(NSString *)findLocationDescription
{
    //NSString *description;
    NSScanner *scanner, *oneLineScanner;
    scanner = [NSScanner scannerWithString:AllDataFromFile];
    AllItemMessage = [ [NSMutableArray alloc]init ];
    //self.AllItems = [ [NSMutableArray alloc]init ];
    
    NSString *oneLine;
    NSInteger temp;
    uint8_t stateOfSearching = 0U;
    NSString *message;
    
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
                
                //if ((temp<100) && (temp != 0U))
                //{
                /* if there is a new object found I have to initialize new NSMutableArray
                 */
                [AllItemMessage addObject:[[ NSMutableArray alloc] init]];
                //}
                
                //NSLog(@"%@",oneLine);
                
                [oneLineScanner scanUpToString:@"\n" intoString:&message];
                
                [AllItemMessage.lastObject addObject:[NSNumber numberWithInteger:temp]];
                [AllItemMessage.lastObject addObject:message];
                
                
                //NSLog(@"number = %ld with \n %@",temp,message);
                
                
                //
                //                [scanner scanUpToString:@"\n" intoString:&oneLine ];
                //                oneLineScanner = [NSScanner scannerWithString:oneLine];
                //
                //                [oneLineScanner scanInteger:&temp];
                //
                //                NSLog(@"number = %ld",temp);
                
                
                
                
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
    if (NULL == loc_nr)
    {
        nr_searched = [_location_number integerValue];
    }
    else
    {
        nr_searched = [loc_nr integerValue];
    }
    
    NSScanner *theScanner;
    NSString *str1;
    NSInteger nr_int;
    int8_t a=0;
    boolean_t isFound = false;
    NSLog(@" I am searing for %d ",(int)nr_searched);
    theScanner = [NSScanner scannerWithString:AllDataFromFile ];
    NSScanner *minorScanner;
    
    
    while( NO == [theScanner isAtEnd] )
    {
        [theScanner scanUpToString:@"\n" intoString:&str1];
        
        minorScanner = [NSScanner scannerWithString:str1];
        //if information delimiter
        
        if ( ([minorScanner scanString:@"-1" intoString:NULL]) && ( a != 10) )
        {
            a++;
            break;
            }
        
        if ( ([minorScanner  scanInteger:&nr_int]) && ([ minorScanner scanLocation]<4))
            //&& (2 != a))
        {
            if (nr_int  == nr_searched)
            {
                [minorScanner scanUpToString:@"\n" intoString:&str1];
                NSLog(@"%@",str1);
                
                a = 1;
            }
            else if (1== a)
            {
                a=2;
                break;
            }
            
        }
    }
    
    //show item if in that location
    /*SECTION 7: OBJECT LOCATIONS.  EACH LINE CONTAINS AN OBJECT NUMBER AND ITS
     *	INITIAL LOCATION (ZERO (OR OMITTED) IF NONE).  IF THE OBJECT IS
     *	IMMOVABLE, THE LOCATION IS FOLLOWED BY A "-1".  IF IT HAS TWO LOCATIONS
     *	(E.G. THE GRATE) THE FIRST LOCATION IS FOLLOWED WITH THE SECOND, AND
     *	THE OBJECT IS ASSUMED TO BE IMMOVABLE.
     */
    
    a=1U;
    for( NSMutableArray *array in AllItemsLocation)
    {
        //NSLog(@"%@",array);
        for(uint8_t i=1U; i<array.count ; i++)
        {
            if ([loc_nr isEqual:[array objectAtIndex:i ] ])
            {
                //NSLog(@"%@ object nr %ld",array,a);
                [self findThisItemMessage:[NSNumber numberWithInteger:a]];
                //isFound = true;
                //break;
            }
        }
        if (isFound == true)
        {
            break;
        }
        
        a++;
        
    }
    
}

-(void)findThisItemMessage:(NSNumber *)ItemNumber
{
    NSUInteger iter=0U;
    for(NSMutableArray *One_row in AllItemMessage)
    {
        //NSLog(@" %@ ",[One_row objectAtIndex:0U]);
        if ([[One_row objectAtIndex:0U] isEqual:ItemNumber] )
        {
            NSLog(@"%@",[[AllItemMessage objectAtIndex:iter] objectAtIndex:1U]);
        }
        iter++;
    }
    
    
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


-(void)ShowAllData
//(NSArray *)data
{
    
    for(NSMutableArray *line in AllItemMessage )
    {
        NSLog(@"%@",[line objectAtIndex:0U]);
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

@end





@implementation  LocationItems

@end


int main(int argc, const char * argv[])
{
    NSInteger nr_int;
    NSUInteger  var_i;
    NSUInteger  starting_nsu;
    //NSString *str1;
    
    //NSInteger nr_searched = [starting_location integerValue];
    //NSScanner *minorScanner;
    //NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    //NSCharacterSet *empty = [NSCharacterSet characterSetWithCharactersInString:@" "];
    
    
    
    NSMutableArray  *mutableArrayExits;
    NSMutableArray *LocationObjectsArray = [[NSMutableArray alloc] init];
    //AllExitsTable = [ [NSMutableArray alloc]init ];
    
    @autoreleasepool {
        /*
         /REading all data in form of strings
         */
        
        //AllDataFromFile =zStr;
        /*
         *
         */
        
        LocationFunctions *loc1 = [LocationFunctions alloc];
        //loc1.location_number=@10;
        
        NSLog(@" arguments %d ",argc);
        
        if (argc<2)
        {
            [ToolsForLocation WriteMarkers:NR_OF_MARKERS];
            NSLog(@" You have to give an argument");
            [ToolsForLocation WriteMarkers:NR_OF_MARKERS];
            //i have to exit
            return 0;
        }
        
        NSString *starting_location =[NSString stringWithFormat:@"%s",argv[1]];
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        loc1.location_number = [f numberFromString:starting_location];
        starting_nsu = [starting_location integerValue];
        
        
        [ToolsForLocation ReadDataFile];
        [ToolsForLocation findAllExitTable];
        [ToolsForLocation findAllCommandsTable];
        [ToolsForLocation findAllItemStartLocation];
        [ToolsForLocation findAllItemMessage];
        
        NSMutableArray *AllLocationDescription = [ToolsForLocation findAllLocationDescription:AllDataFromFile];
        
        
        //[ToolsForLocation WaitForCommand];
        
        
        NumberOfLocation = [ToolsForLocation FindNumberOfLocation];
        
        //NumberOfLocation = [AllExitsTable count];
        NSLog(@"Number of location %lu",(unsigned long)NumberOfLocation);
        //here i put a loop to create class instances for all location
        
        for(var_i = RESET; var_i < NumberOfLocation; var_i++)
        {
            LocationItems *loc_item = [LocationItems alloc];
            loc_item.LocationDescription =[AllLocationDescription objectAtIndex:var_i];
            
            [LocationObjectsArray addObject: loc_item];
            //[loc_item release];
            //LocationObjectsArray.lastObject.LocationDescription =[AllLocationDescription objectAtIndex:var_i];
        }
        
        
        
        
        //[loc1 ShowDescription];
        
        NSLog([[LocationObjectsArray objectAtIndex:starting_nsu] LocationDescription]);
        
        mutableArrayExits = [loc1 findExits:loc1.location_number];
        
        NSScanner *mainScanner;
        NSString *word = @"";
        NSString *str2 ;
        boolean_t marker_IcanGO;
        marker_IcanGO = false;
        while(![word  isEqual: @"exit"])
        {
            
            //[loc1 findExits];
            //printf(">");
            word = [ToolsForLocation WaitForCommand];
            //NSLog(@"new => %@",word);
            
            if ([word containsString:@"dupa"])
            {
                NSLog(@"  such a bad word");
            }
            else if ([word containsString:@"location"])
            {
                //[loc1 ShowDescription];
                NSLog([[LocationObjectsArray objectAtIndex:starting_nsu] LocationDescription]);
            }
            
            else if ([word containsString:@"go"])
            {
                mainScanner = [NSScanner scannerWithString:word  ];
                
                [mainScanner scanString:@"go"  intoString:&str2];
                
                [mainScanner scanInteger:&nr_int ];
                
                if (nr_int)
                {
                    NSNumber  *loc_nr =[NSNumber numberWithInteger:nr_int];
                    (void)[loc1 MoveToLocationIfThisIsPossible:loc_nr];
                    //[loc1 ShowDescription];
                    NSLog([[LocationObjectsArray objectAtIndex:starting_nsu] LocationDescription]);
                    mutableArrayExits = [loc1 findExits:loc1.location_number];
                    //NSLog(@"%@" , mutableArrayExits);
                }
            }
            else if ([word containsString:@"exits"])
            {
                [loc1 ShowAllExitData];
                
                
            }
            else if ([word containsString:@"help"])
            {
                printf("\n - exitcom \n - go <nr location> \n - exits \n - ");
            }
            else if ([word containsString:@"exitcom"])
            {
                mutableArrayExits = [loc1 findExits:loc1.location_number];
                
                NSLog(@"%@" , mutableArrayExits);
            }
            else if ([word containsString:@"exit"])
            {
                break;
            }
            else
            {
                [ToolsForLocation AnalyzeCommandFromUser:word   tab_of_all_commandsForOut:mutableArrayExits actual_location:loc1];
                
                //MovingMethodFromOtherClass:@selector(MoveToLocationIfThisIsPossible:loc_nr:)];
                
                //[loc1 ShowDescription];
                NSLog([[LocationObjectsArray objectAtIndex:starting_nsu] LocationDescription]);
                mutableArrayExits = [loc1 findExits:loc1.location_number];
            }
            
            //}
        }
        
        
        return 0;
    }
}

