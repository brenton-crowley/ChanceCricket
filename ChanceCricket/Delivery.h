//
//  Delivery.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Batsman, Over;

@interface Delivery : NSManagedObject

@property (nonatomic, retain) NSNumber * deliveryID;
@property (nonatomic, retain) NSString * deliveryName;
@property (nonatomic, retain) NSNumber * deliveryRuns;
@property (nonatomic, retain) NSNumber * isLegal;
@property (nonatomic, retain) NSNumber * isWicket;
@property (nonatomic, retain) Batsman *batsman;
@property (nonatomic, retain) Over *over;

@end
