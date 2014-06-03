//
//  MatchSettings.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Match;

@interface MatchSettings : NSManagedObject

@property (nonatomic, retain) NSNumber * bowlerOverLimit;
@property (nonatomic, retain) NSNumber * deliveriesPerOver;
@property (nonatomic, retain) NSNumber * inningOverLimit;
@property (nonatomic, retain) NSNumber * inningsLimit;
@property (nonatomic, retain) NSString * settingsName;
@property (nonatomic, retain) NSNumber * wicketLimit;
@property (nonatomic, retain) NSSet *match;
@end

@interface MatchSettings (CoreDataGeneratedAccessors)

- (void)addMatchObject:(Match *)value;
- (void)removeMatchObject:(Match *)value;
- (void)addMatch:(NSSet *)values;
- (void)removeMatch:(NSSet *)values;

@end
