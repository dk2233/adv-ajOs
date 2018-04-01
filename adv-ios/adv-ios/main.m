////////////////////////////////////////////////////////////////
//
//  main.m
//
//
//  Created by daniel on 01.07.2017.
//  Copyright © 2017 code masterss. All rights reserved.
//
//  simple adventure implementation
// for now I know how to walk between places
//items
//
//
/////////////////////////////////////////////////////////////////




/////////////////////////////////////////////////////////////////
// Include
/////////////////////////////////////////////////////////////////

#import     <Foundation/Foundation.h>
#include    "stdlib.h"
#import     "Adventure.h"
#import     "Game_Types.h"
#import "GameObjects.h"


//NSNumber            *nr_of_treasure;
NSNumber            *nr;
NSMutableArray      *AllExits;

/*
 this classs is for 
 finding all location description
 
 so methods of this class will be showing all
 :
 : desciption
 : exits from location
 
 for given property *location_number
 
 
 */

TextGameFunctions *LocationFunctions ;
ToolsForTextGame *ToolsForTexts;



@implementation  LocationItems
-(id)init
{
    self.ItemsInActualLocation = [[NSMutableArray alloc] init];
    return self;
}
@end

@implementation  GameObjects

-(id)init
{
    self.ObjectDescription = [[NSMutableArray alloc] init ];
    self.PropOfObject = INIT_PropOfObject;
    return self;
}
@end






int main(int argc, const char * argv[])
{
    NSInteger nr_int;
    //NSUInteger  var_i;
    NSUInteger  starting_nsu;
    NSMutableArray  *mutableArrayExits;
    
    @autoreleasepool {
        /*
         /REading all data in form of strings
         */
        
        //functions - super class
        LocationFunctions = [[TextGameFunctions alloc] initSuper];
               
        //tools
        ToolsForTexts = [[ToolsForTextGame alloc] initGame];
        
//        [LocationFunctions setDelegate:ToolsForTexts];
        LocationFunctions.delegate = ToolsForTexts;
        //[loc_main_func ShowAllData:AllItemsLocation ];
        
        NSLog(@" arguments %d ",argc);
        
        if (argc<2)
        {
            [ToolsForTextGame WriteMarkers:NR_OF_MARKERS];
            NSLog(@" You have to give an argument - if not starting in first location");
            [ToolsForTextGame WriteMarkers:NR_OF_MARKERS];
            starting_nsu = 1;
            LocationFunctions.location_number = [NSNumber numberWithInt:starting_nsu];
        }
        else
        {
            
            NSString *starting_location =[NSString stringWithFormat:@"%s",argv[1]];
            NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
            format.numberStyle = NSNumberFormatterDecimalStyle;
            LocationFunctions.location_number = [format numberFromString:starting_location];
            starting_nsu = [starting_location integerValue]-0;
        }
        
        initializeGame();
        
        [LocationFunctions ShowDescription:[NSNumber numberWithInteger:starting_nsu]];
                
        //NSLog(@"%@",[[loc_main_func.LocationClassInstancesArray objectAtIndex:starting_nsu] LocationDescription]);
        mutableArrayExits = [LocationFunctions findExits:[NSNumber numberWithInteger:starting_nsu]];
        
        NSScanner *mainScanner;
        NSString *word = @"";
        NSString *str2 ;
        boolean_t marker_IcanGO;
        marker_IcanGO = false;
        while(![word  isEqual: @"exit"])
        {
            
            //[loc1 findExits];
            //printf(">");
            word = [ToolsForTextGame WaitForCommand];
            
            [LocationFunctions.delegate sendActualCommand:word];
            
            //NSLog(@"new => %@",word);
            
            if ([word containsString:@"dupa"])
            {
                NSLog(@"  such a bad word");
            }
            else if ([word containsString:@"location"])
            {
                [LocationFunctions ShowDescription:LocationFunctions.location_number];
                //NSLog([[LocationObjectsArray objectAtIndex:[loc_main_func.location_number integerValue]] LocationDescription]);
            }
            
            else if ([word containsString:@"go"])
            {
                mainScanner = [NSScanner scannerWithString:word  ];
                
                [mainScanner scanString:@"go"  intoString:&str2];
                
                //[LocationFunctions.]
                
                [mainScanner scanInteger:&nr_int ];
                
                if (nr_int)
                {
                    NSNumber  *loc_nr =[NSNumber numberWithInteger:nr_int];
                    (void)[LocationFunctions MoveToLocationIfThisIsPossible:loc_nr];
                    
                    [LocationFunctions ShowDescription:LocationFunctions.location_number];
                    mutableArrayExits = [LocationFunctions findExits:LocationFunctions.location_number];
                    //NSLog(@"%@" , mutableArrayExits);
                }
            }
            else if ([word containsString:@"exits"])
            {
                [LocationFunctions ShowAllExitData];
                
            }
            else if ([word containsString:@"help"])
            {
                printf("\n - exitcom \n - go <nr location> \n - exits \n - ");
            }
            else if ([word containsString:@"exitcom"])
            {
                mutableArrayExits = [LocationFunctions findExits:LocationFunctions.location_number];
                
                NSLog(@"%@" , mutableArrayExits);
            }
            else if ([word containsString:@"exit"])
            {
                break;
            }
            else
            {
                [ToolsForTexts AnalyzeCommandFromUser:word   tab_of_all_commandsForOut:mutableArrayExits actual_location:LocationFunctions];
                
                //MovingMethodFromOtherClass:@selector(MoveToLocationIfThisIsPossible:loc_nr:)];
                
                [LocationFunctions ShowDescription:LocationFunctions.location_number];
                mutableArrayExits = [LocationFunctions findExits:LocationFunctions.location_number];
            }
            
            //}
        }
        
        
        return 0;
    }
}

