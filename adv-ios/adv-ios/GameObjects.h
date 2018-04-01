//
//  GameObjects.h
//  adv-ios
//
//  Created by Daniel Kucharski on 01.04.2018.
//  Copyright © 2018 code masterss. All rights reserved.
//

#ifndef GameObjects_h
#define GameObjects_h





@interface GameObjects: NSObject
// it is the class for one object properties, location, if it was taken,
// if it was used or destroyed
//LOC
@property NSUInteger LocationOfObject;
//PLAC - it is initial location of objects
@property NSUInteger InitialLocation_PLAC;
//adequte to PROP[]
@property NSInteger PropOfObject;
//it is PTEXT[]
@property  NSMutableArray* ObjectDescription;

//it is as FIXED[]
@property  boolean_t IsObjectMoveable;
@end


#endif /* GameObjects_h */
