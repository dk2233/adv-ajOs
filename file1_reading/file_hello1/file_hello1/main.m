//
//  main.m
//  file_hello1
//
//  Created by daniel on 01.07.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Foundation/Foundation.h>
//#import <Foundation/NSFileHandle.h>
//#import <Foundation/NSScanner.h>
#include "stdio.h"


NSString *fileName;
NSNumber *nr_of_treasure;
NSNumber *nr;


#define  EXITS_NUMBER_IN_FILES              @"3"
#define  DESTINATION_NUMBER_IN_FILES        1U
#define  TAB_NR_DESTINATION                 1U

/*
 this classs is for 
 finding all location description
 
 so methods of this class will be showing all
 :
 : desciption
 : exits from location
 
 for given property *location_number
 
 
 */




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


+(void)initialize;
+(void)sayHello;
-(NSNumber *)addTwoValues:(uint16_t)val1 withNumber:(uint16_t)val2;
-(void)WriteOtherWord;

-(id)init;

-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits;

-(void)findAllExitTable;
-(void)findAllCommandsTable;


-(void)ShowDescription;

-(void)ShowAllData;
-(NSString *)WaitForCommand;
-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr;
-(void)ShowAllExitData;
-(void)AnalyzeCommandFromUser:(NSString *)word  tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab;
-(NSMutableArray *)CheckAllExitsCommandForLocation;
@end



@implementation Location

+(void)initialize
{
    
    nr_of_treasure=@0;
//    _location_number = @0;
}
+(void)sayHello
{
    NSLog(@"\n\n\n shtg to say \n\n");
};


-(id)init
{
    NSNumber *internal = @0;
    _location_number = @0;
    _DataForExits=[[NSMutableArray alloc] init];
    _AllExits=[[NSMutableArray alloc] init];
    
    self.AllExitCommands = [[NSMutableArray alloc]init];
    
    
    
    return self;
}

-(NSNumber *)addTwoValues:(uint16_t)val1 withNumber:(uint16_t)val2
{
//    NSLog(@"%d",(val1+val2));
    NSNumber *ret = [NSNumber numberWithInt:(val1+val2)];
    //ret.init(3 );
    //[ret init(value: (Int)(val1+val2) )];
//    [ret num:(val1+val2) ];
    
    //[ret ]
    NSLog(@"methods adding %@",ret);
    //[ret ];
    return ret;
}


-(void)ShowDescription
{
    NSInteger nr_searched = [_location_number integerValue];
    //NSInteger nr_searched = [searchedString integerValue];
    NSScanner *theScanner;
    NSString *str1;
    NSInteger nr_int;
    int8_t a=0;
    //NSLog(@" I am searing for %d ",(int)nr_searched);
    theScanner = [NSScanner scannerWithString:_AllData ];
    NSScanner *minorScanner;
    
//    NSLog( @" a = %d ", a);

    while( [theScanner isAtEnd] == NO)
    {
        [theScanner scanUpToString:@"\n" intoString:&str1];
        
    
        minorScanner = [NSScanner scannerWithString:str1];
        //if information delimiter
        if ( ([minorScanner scanString:@"-1" intoString:NULL]) && ( a != 10) )
        {
            a++;
//            NSLog( @" a = %d ", a);
            //NSLog(@"%@",str1);
            break;
            //[theScanner scanUpToString:@"\n" intoString:&str1];
            //minorScanner = [NSScanner scannerWithString:str1];
            
            
            if ([minorScanner scanString:EXITS_NUMBER_IN_FILES  intoString:&str1])
            {
                
                //NSLog(@" I have found exits ");
                //NSLog(@"%@",str1);
                a = 10 ;
                
            }
        }

        
        if ( ([minorScanner  scanInteger:&nr_int]) && ([ minorScanner scanLocation]<4) && (0 == a))
        {
            
            if (nr_int  == nr_searched)
            {
                //NSLog(@" I have find  %@ in %@ ",searchedString, str1);
                
                //NSLog(@" comparing %d ",(int)(nr_int == nr_searched));
                //[minorScanner scanUpToString:searchedString intoString:&str1];
                [minorScanner scanUpToString:@"\n" intoString:&str1];
                NSLog(@"%@",str1);
                //a = 1;
                
                
            }
            
        }
        
        
    }
}


-(void)ShowAllExitData
{
    NSArray *tarray;
    
    for(tarray in _DataForExits)
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
    
    for(NSString *line in self.AllData )
    {
        NSLog(@"%@",line);
    }
}


-(void)findAllCommandsTable
{
    NSScanner *scannerExits, *oneLineScanner;
    scannerExits = [NSScanner scannerWithString:_AllData];
    self.AllExitCommands = [ [NSMutableArray alloc]init ];
    NSString *oneLine;
    NSInteger temp=0U;
    NSString  *temp_string;
    NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    uint8_t stateOfSearching = 0;
    while(![scannerExits isAtEnd])
    {
        //first find -1 in next line 4
        
        [scannerExits scanUpToString:@"-1" intoString:NULL ];
        [scannerExits scanUpToString:@"\n" intoString:NULL];
        
        if ( [scannerExits  scanString:@"4" intoString:NULL ] )
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
                        [_AllExitCommands addObject:[[NSMutableArray alloc]init]];
                        [_AllExitCommands.lastObject addObject:[NSNumber numberWithInteger:temp]];
                        [_AllExitCommands.lastObject addObject:temp_string];
                        [oneLineScanner scanUpToString:@"\n" intoString:NULL];
                        
                        
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

    
    
    

-(void)findAllExitTable
{
    NSScanner *scannerExits, *oneLineScanner;
    scannerExits = [NSScanner scannerWithString:_AllData];
    _AllExitsTable = [ [NSMutableArray alloc]init ];
    _AllExitCommands= [ [NSMutableArray alloc]init ];
    NSString *oneLine;
    NSInteger temp=0;
    //NSString *temp_string;
    while(![scannerExits isAtEnd])
    {
        //first find -1 in next line 3
        
        [scannerExits scanUpToString:@"-1" intoString:NULL ];
        [scannerExits scanUpToString:@"\n" intoString:NULL];
        
        if ( [scannerExits  scanString:@"3" intoString:NULL ] )
        {
            
            //[scannerExits scanUpToString:@"\n" intoString:NULL];
            //uint8_t isItfound = 0;
            
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
                //NSLog(@"%@",_AllExitsTable);
                [_AllExitsTable addObject:[[NSMutableArray alloc]init]];
                while(![oneLineScanner isAtEnd])
                {
                    [oneLineScanner scanInteger:&temp];
                    [_AllExitsTable.lastObject addObject:[NSNumber numberWithInteger:temp]];
                }
                
            }
            break;
        }
        
    }

}

-(NSMutableArray *)findExits:(NSNumber *)locNumberToFindExits
{
    _DataForExits=[[NSMutableArray alloc] init];
    
    NSMutableArray *OneRowOfTab=[[NSMutableArray alloc] init];

    NSMutableArray *OneRowOfTab_2=[[NSMutableArray alloc] init];
NSMutableArray *tab_exits = [[NSMutableArray alloc] init];
    _AllExits = [ [NSMutableArray alloc] init ];
    
    //NSLog(@"  exits for %@ ",locNumberToFindExits );
  
    NSInteger nr_searched = [locNumberToFindExits integerValue];
    NSInteger temp;
    
    NSNumber *temp_nsn;
    NSString *temp_string;
    //NSLog(@"%@",_AllExitCommands);
    for(NSMutableArray *oneArray in self.AllExitsTable)
    {
        temp_nsn =(NSNumber *)[oneArray objectAtIndex:0];
     
        temp = [temp_nsn integerValue ];
     
        if (  temp == nr_searched)
        {
            
            //If I have found searched number of location in exit line
            OneRowOfTab=[[NSMutableArray alloc] init];
            OneRowOfTab_2 = [[NSMutableArray alloc] init];
            [_DataForExits addObject:OneRowOfTab];
            [tab_exits addObject:OneRowOfTab_2];
            
            for(uint8_t i=0; i<oneArray.count; i++)
            {
                temp_nsn =(NSNumber *)[oneArray objectAtIndex:i];
                [_DataForExits.lastObject addObject:temp_nsn ];
            
                
                if ( DESTINATION_NUMBER_IN_FILES == i)
                {
                    [tab_exits.lastObject addObject:temp_nsn ];
                }
                else if ( i> DESTINATION_NUMBER_IN_FILES )
                {
                    for( NSMutableArray *rowArray in _AllExitCommands)
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
            
           [_AllExits addObject:[_DataForExits.lastObject objectAtIndex:TAB_NR_DESTINATION]];
        }
    }
    NSString *exits_string = @" " ;
    exits_string = [exits_string stringByAppendingString:@" all exit are: "];
    NSNumber *i;
    
    for( i in _AllExits)
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


-(void)WriteOtherWord
{
    NSLog(@"\n\n\n other words like HELL-O \n\n");
    
}


-(NSString *)WaitForCommand
{
    NSString *command = [[[NSString alloc] initWithData:[[NSFileHandle fileHandleWithStandardInput] availableData] encoding:NSASCIIStringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet] ];
    
    NSLog(@"%@",command);
    
    
    //if there are space between letters then remove them
    
    
    if ([command containsString:@" "])
    {
        command = [command stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    
    //NSLog(command);
    
    
    
//    return [[[NSString alloc] initWithData:[[NSFileHandle fileHandleWithStandardInput] availableData] encoding:NSASCIIStringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    return command;
    
}

-(BOOL)MoveToLocationIfThisIsPossible:(NSNumber*)nr
{
    boolean_t marker_IcanGO=false;
    //it was used previously to check whether I can go from current location
    //NSArray *tab_a=[loc1 findExits:loc1.location_number];
    NSArray *tarray;
    //NSLog(@"%@",_DataForExits);
    if (nr == _location_number)
    {
        NSLog(@" You are already there  %@  to %@",_location_number,nr);
        return marker_IcanGO;
    }
    for(tarray in _DataForExits)
    {
        if ([nr isEqual:[tarray objectAtIndex:TAB_NR_DESTINATION]])
        {
            //[tarray ]
            NSLog(@"exit possible : %@",[tarray objectAtIndex:TAB_NR_DESTINATION]);
            _location_number = nr;
            
            marker_IcanGO =TRUE;
            break;
        }
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

-(void)AnalyzeCommandFromUser:(NSString *)wordFromUser  tab_of_all_commandsForOut:(NSMutableArray *)exitCommand_tab
{
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
                    (void)[self MoveToLocationIfThisIsPossible:[row1 objectAtIndex:0]];
                    return;
                }
                //but it can be longer
                if ( [ wordFromUser localizedCaseInsensitiveContainsString:DefinedWord])
                {
                    NSLog(@"%@ to == %@",DefinedWord, wordFromUser);
                    //check whether this word is in the beginning
                    loc =[wordFromUser rangeOfString:DefinedWord options:NSCaseInsensitiveSearch].location;
                    //loc = [wordFromUser r]
                    //NSLog(@"%lu",(unsigned long)
                    if (0 == loc)
                    {
                        NSLog(@" going %@ ",[row1 objectAtIndex:0]);
                        (void)[self MoveToLocationIfThisIsPossible:[row1 objectAtIndex:0]];
                        return;
                    }
                    
                    
                }
            }
        }
        
    }
}


@end



int main(int argc, const char * argv[]) {
    NSInteger nr_int;
    int  var_i;
    NSString *str1;
    
    //NSInteger nr_searched = [searchedString integerValue];
    //NSScanner *minorScanner;
    //NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    //NSCharacterSet *empty = [NSCharacterSet characterSetWithCharactersInString:@" "];
    NSMutableArray  *mutableArrayExits;
    
    @autoreleasepool {
        Location *loc1 = [Location alloc];
        //Location *loc2 = [[Location alloc] init];
        [Location sayHello];
        
        loc1.location_number=@10;
        
        
        NSLog(@" arguments %d ",argc);
        
        if (argc<2)
        {
            //i have to exit
            return 0;
        }
        
        fileName = [NSString stringWithUTF8String:"adventure.text"];
        //NSLog(@" arg %@ ",  [NSString stringWithFormat:@"%s",argv[1]]);
        //NSLog(@" arg 2 %@ ", fileName);
        
        
        NSString *searchedString =[NSString stringWithFormat:@"%s",argv[1]];
        NSScanner *theScanner;
        
        NSString *zStr =[NSString stringWithContentsOfFile:fileName
                                               encoding:NSASCIIStringEncoding
                                                  error:NULL];
        
        loc1.AllData =zStr;
        [loc1 findAllExitTable];
        [loc1 findAllCommandsTable];
        
        //NSString *str1;
        uint8_t var;
//        NSLog(@" show all data ");
//        for(NSMutableArray *line in loc1.AllExitsTable )
//        {
//            NSLog(@"%@",line);
//        }

    
       //[loc1 ShowAllData];
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        //NSNumber *myNumber = [f numberFromString:@"42"];
        loc1.location_number = [f numberFromString:searchedString];
        
        [loc1 ShowDescription];
        mutableArrayExits = [loc1 findExits:loc1.location_number];
        
        NSScanner *mainScanner;
        NSString *word = @"";
        NSString *str2 ;
        boolean_t marker_IcanGO;
        marker_IcanGO = false;
        while(![word  isEqual: @"exit"])
        {
            
            //[loc1 findExits];
            word = [loc1 WaitForCommand];
            //NSLog(@"new => %@",word);
            
            
            if ([word containsString:@"dupa"])
            {
                NSLog(@"  such a bad word");
            }
            else if ([word containsString:@"location"])
            {
                [loc1 ShowDescription];
            }

            else if ([word containsString:@"go "])
            {
                mainScanner = [NSScanner scannerWithString:word  ];
                
                [mainScanner scanString:@"go"  intoString:&str2];
                
                [mainScanner scanInteger:&nr_int ];
                
                if (nr_int)
                {
                    NSNumber  *loc_nr =[NSNumber numberWithInteger:nr_int];
                    (void)[loc1 MoveToLocationIfThisIsPossible:loc_nr];
                    //[loc1 ShowDescription];
                    mutableArrayExits = [loc1 findExits:loc1.location_number];
                    //NSLog(@"%@" , mutableArrayExits);
                }
            }
            else if ([word containsString:@"exits"])
            {
                [loc1 ShowAllExitData];
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
                [loc1 AnalyzeCommandFromUser:word   tab_of_all_commandsForOut:mutableArrayExits];
                
                [loc1 ShowDescription];
                mutableArrayExits = [loc1 findExits:loc1.location_number];
            }

            //}
        }
        
        
    return 0;
    }
}
