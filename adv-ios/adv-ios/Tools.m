//
//  Tools.m
//  file_hello1
//
//  Created by daniel on 26.08.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Adventure.h"

NSString                *AllDataFromFile;
NSMutableArray          *AllExitsTable ;
NSMutableArray          *AllItems;
NSMutableArray          *AllItemsLocation;
NSMutableArray          *AllItemMessage;
NSMutableArray          *AllExitCommands;


@implementation ToolsForLocation

+(void)ReadDataFile
{
    
    NSString *fileName;
    fileName = [NSString stringWithUTF8String:"adventure.text"];
    AllDataFromFile =[NSString stringWithContentsOfFile:fileName
                                               encoding:NSASCIIStringEncoding
                                                  error:NULL];
}

+(NSMutableArray *)findAllLocationDescription: (NSString *)BigStringData
{
    NSMutableArray *array_descriptions = [[NSMutableArray alloc]init];
    
    //initialization of
    [array_descriptions addObject:@""];
    [array_descriptions addObject:@""];
     //[[NSString alloc]init]];
    
    NSString  *AllDescriptions = [[NSString alloc]init];
    NSString *oneLine;
    NSString *text_desc;
    NSString *temp_string;
    NSScanner *scanner, *oneLineScanner;
    
    NSInteger temp;
    NSInteger nr = 1U;
    
    scanner = [NSScanner scannerWithString:BigStringData];
    [scanner scanUpToString:@"-1" intoString:&AllDescriptions];
    
    scanner = [NSScanner scannerWithString:AllDescriptions];
    
    while(![scanner isAtEnd])
    {
        //All descriptions are at start in the data file
        [scanner scanUpToString:@"\n" intoString:&oneLine];
        //NSLog(oneLine);
        oneLineScanner = [NSScanner scannerWithString:oneLine];
        [oneLineScanner scanInteger:&temp];
        [oneLineScanner scanUpToString:@"\n" intoString:&text_desc];
        if (temp == nr)
        {
            if (text_desc != NULL)
            {
                //NSLog(array_descriptions.lastObject);
                temp_string = [array_descriptions.lastObject stringByAppendingString:text_desc];
                [array_descriptions replaceObjectAtIndex:(array_descriptions.count-1U)  withObject:temp_string];
            }
            
            
        }
        else
        {
            [array_descriptions addObject:text_desc];
            nr++;

        }
        
        //NSLog(@" %d -> %@",temp,oneLine);
        
    }
    return array_descriptions;
}


+(void)findAllItemMessage
{
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
}

+(void)findAllCommandsTable
{
    NSScanner *scannerExits, *oneLineScanner;
    scannerExits = [NSScanner scannerWithString:AllDataFromFile];
    AllExitCommands = [ [NSMutableArray alloc]init ];
    AllItems = [ [NSMutableArray alloc]init ];
    
    NSString *oneLine;
    NSInteger temp=0U;
    NSInteger number_of_item_previous=0U;
    NSString  *temp_string;
    NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    uint8_t stateOfSearching = 0;
    
    while(![scannerExits isAtEnd])
    {
        //first find -1 in next line 4
        
        [scannerExits scanUpToString:@"-1" intoString:NULL ];
        [scannerExits scanUpToString:@"\n" intoString:NULL];
        
        if ( [scannerExits  scanString:VOCABULARY_LOCATION_IN_FILES intoString:NULL ] )
        {
            while(  0 == stateOfSearching )
            {
                
                [scannerExits scanUpToString:@"\n" intoString:&oneLine];
                oneLineScanner =[NSScanner scannerWithString:oneLine];
                
                if ([oneLineScanner scanString:@"-1"  intoString:NULL  ])
                {
                    break;
                }
                //oneLineScanner.scanLocation = 0U;
                //NSLog(@"%@",oneLine);
                //NSLog(@"%@",_AllExitsTable);
                
                while(![oneLineScanner isAtEnd])
                {
                    [oneLineScanner scanInteger:&temp];
                    [oneLineScanner scanCharactersFromSet:letters intoString:&temp_string];
                    if (0 ==  (temp / 1000))
                    {
                        [AllExitCommands addObject:[[NSMutableArray alloc]init]];
                        [AllExitCommands.lastObject addObject:[NSNumber numberWithInteger:temp]];
                        [AllExitCommands.lastObject addObject:temp_string];
                        [oneLineScanner scanUpToString:@"\n" intoString:NULL];
                        
                        
                    }
                    else if (1 == (temp / 1000))
                    {
                        //value = temp /1000 ;
                        //NSLog(@"%@",oneLine);
                        
                        
                        if ([AllItems.lastObject count] > 0U)
                        {
                            //if ([[_AllItems.lastObject objectAtIndex:0U] isNotEqualTo: [NSNumber numberWithInteger:value]])
                            if ( number_of_item_previous != temp)
                            {
                                [AllItems addObject:[[NSMutableArray alloc] init]];
                                //[_AllItems.lastObject addObject:[NSNumber numberWithInteger:value]];
                            }
                            [AllItems.lastObject addObject:temp_string];
                        }
                        else
                        {
                            [AllItems addObject:[[NSMutableArray alloc] init]];
                            [AllItems.lastObject addObject:temp_string];
                        }
                        
                        
                        
                        [oneLineScanner scanUpToString:@"\n" intoString:NULL];
                        
                        number_of_item_previous = temp;
                    }
                    else
                    {
                        stateOfSearching = 1;
                    }
                    
                    //NSLog(@" nr = %ld  string %@", temp,temp_string );
                }
                
            }
            break;
        }
    }
    //NSLog(@"%@",_AllExitCommands);
    
}





+(void)findAllItemStartLocation
{
    /*SECTION 7: OBJECT LOCATIONS.  EACH LINE CONTAINS AN OBJECT NUMBER AND ITS
     *	INITIAL LOCATION (ZERO (OR OMITTED) IF NONE).  IF THE OBJECT IS
     *	IMMOVABLE, THE LOCATION IS FOLLOWED BY A "-1".  IF IT HAS TWO LOCATIONS
     *	(E.G. THE GRATE) THE FIRST LOCATION IS FOLLOWED WITH THE SECOND, AND
     *	THE OBJECT IS ASSUMED TO BE IMMOVABLE.
     */

    NSScanner *scannerItems, *oneLineScanner;
    scannerItems = [NSScanner scannerWithString:AllDataFromFile];
    AllItemsLocation = [ [NSMutableArray alloc]init ];
    
    
    NSString *oneLine;
    NSInteger temp=RESET;
    
    //NSInteger value=0U;
    //NSString  *temp_string;
    //NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    uint8_t stateOfSearching = RESET;
    while(![scannerItems isAtEnd] || ( RESET== stateOfSearching))
    {
        
        [scannerItems scanUpToString:@"-1" intoString:NULL ];
        [scannerItems scanUpToString:@"\n" intoString:NULL];
        
        if ( [scannerItems  scanString:ITEMS_LOCATION_IN_DATA_FILE intoString:NULL ] )
        {
            while(  RESET == stateOfSearching )
            {
                [scannerItems scanUpToString:@"\n" intoString:&oneLine];
                
                oneLineScanner =[NSScanner scannerWithString:oneLine];
                //NSLog(@"%@",oneLine);
                if ( [oneLine isEqualToString:@"-1"])
                {
                    stateOfSearching = 1;
                    break;
                }
                
                [AllItemsLocation  addObject:[[NSMutableArray alloc]init ] ];
                
                while( ![oneLineScanner isAtEnd])
                {
                    
                    [oneLineScanner scanInteger:&temp];
                    [AllItemsLocation.lastObject addObject:[NSNumber numberWithInteger:temp]];
                    
                    //temp = [ [AllItemsLocation.lastObject objectAtIndex:0U] integerValue]-1;
                }
                //NSLog(@" item: %@ is at location %@",[[_AllItems objectAtIndex:temp] objectAtIndex:0U],
                //     [_AllItemsLocation.lastObject objectAtIndex:1U]);
                
            }
        }
    }
    
}

+(void)findAllExitTable
{
    AllExitsTable = [[NSMutableArray alloc] init];
    NSScanner *scannerExits, *oneLineScanner;
    scannerExits = [NSScanner scannerWithString:AllDataFromFile];
    
    //AllExitCommands= [ [NSMutableArray alloc]init ];
    NSString *oneLine;
    NSInteger temp=0;
    //NSString *temp_string;
    while(![scannerExits isAtEnd])
    {
        //first find -1 in next line 3
        
        [scannerExits scanUpToString:@"-1" intoString:NULL ];
        [scannerExits scanUpToString:@"\n" intoString:NULL];
        
        if ( [scannerExits  scanString:EXITS_NUMBER_IN_FILES intoString:NULL ] )
        {
            
            while( 1 )
            {
                
                [scannerExits scanUpToString:@"\n" intoString:&oneLine];
                oneLineScanner =[NSScanner scannerWithString:oneLine];
                
                if ([oneLineScanner scanString:@"-1"  intoString:NULL  ])
                {
                    break;
                }
                //oneLineScanner.scanLocation = 0U;
                //NSLog(@"%@",oneLine);
                //NSLog(@"%@",AllExitsTable);
                [AllExitsTable addObject:[[NSMutableArray alloc]init]];
                
                while(![oneLineScanner isAtEnd])
                {
                    [oneLineScanner scanInteger:&temp];
                    [AllExitsTable.lastObject addObject:[NSNumber numberWithInteger:temp]];
                }
                
            }
            break;
        }
    }
}





+(NSString *)WaitForCommand
{
    
    fprintf(stderr,  ">");
    NSString *command = [[[NSString alloc] initWithData:[[NSFileHandle fileHandleWithStandardInput] availableData] encoding:NSASCIIStringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet] ];
    
    NSLog(@"%@",command);
    
    //if there are space between letters then remove them
    if ([command containsString:@" "])
    {
        command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    }

    return command;
}




+ (void) AnalyzeCommandFromUser:(NSString *)wordFromUser  tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab actual_location:(LocationFunctions *)LocationActual;
{
     //MovingMethodFromOtherClass:(SEL)WhenIWantMoving
              //
    NSUInteger loc;
    for( NSMutableArray *row1 in exitCommand_tab)
    {
        //NSLog(@"%@",row1);
        for(NSString *DefinedWord in row1)
        {
            //NSLog(@"%@ to == %@",DefinedWord, wordFromUser);
            if  ( [DefinedWord isKindOfClass:[NSString class] ] )
            {
                if ( NSOrderedSame == [DefinedWord caseInsensitiveCompare:wordFromUser])
                {
                    NSLog(@"%@ to == %@",DefinedWord, wordFromUser);
                    NSLog(@" going %@ ",[row1 objectAtIndex:0]);
                    (void)[LocationActual MoveToLocationIfThisIsPossible:[row1 objectAtIndex:0]];
                    return;
                }
                //but it can be longer
                if ( ( [ wordFromUser localizedCaseInsensitiveContainsString:DefinedWord]) &&
                    (DefinedWord.length >1U ) )
                {
                    NSLog(@"%ld", (long)DefinedWord.length);
                    NSLog(@"%@ to == %@",DefinedWord, wordFromUser);
                    //check whether this word is in the beginning
                    loc =[wordFromUser rangeOfString:DefinedWord options:NSCaseInsensitiveSearch].location;
                    //loc = [wordFromUser r]
                    //NSLog(@"%lu",(unsigned long)
                    if (0 == loc)
                    {
                        NSLog(@" going %@ ",[row1 objectAtIndex:0]);
                        (void)[LocationActual MoveToLocationIfThisIsPossible:[row1 objectAtIndex:0]];
                        return;
                    }
                }
            }
        }
    }
}



+(NSUInteger)FindNumberOfLocation
{
    NSUInteger number;
    NSMutableArray *oneLine = AllExitsTable.lastObject;
    number = [[oneLine objectAtIndex:0U] integerValue];
    return(number);
}



+(void)WriteMarkers: (NSUInteger)nr_of_symbols
{
    for(NSUInteger iter=0; iter < nr_of_symbols; iter++)
    {
        printf("*-*-");
        fflush(stdout);
    }
    printf("\n");
}



@end






//
//@implementation <#class#>
//
//<#methods#>
//
//@end GlobalValuesForLocation:NSObject
//@property NSNumber *NumberOfLocation;
//
//@end