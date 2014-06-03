//
//  MatchEngine.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchDatabase.h"
#import "Match+Factory.h"
#import "Inning+Factory.h"
#import "Over+Factory.h"
#import "Delivery+Factory.h"

@class MatchEngine;

@protocol MatchEngineDelegate <NSObject>

- (void) selectBowler:(MatchEngine *)sender;

@end

@interface MatchEngine : NSObject

extern NSString * const MATCH_ENGINE_UPDATE;
extern NSString * const MATCH_ENGINE_MATCH_OPENED;

@property (nonatomic, weak) id <MatchEngineDelegate> delegate;

@property (nonatomic, strong) UIManagedDocument *matchDatabase;
@property (nonatomic, strong) NSString *currentID;
@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) Match *currentMatch;
@property (nonatomic, strong) Inning *currentInning;
@property (nonatomic, strong) Over *currentOver;
@property (nonatomic, strong) Delivery *currentDelivery;
@property (nonatomic) BOOL isAutoSave;

- (void) saveMatch;
- (void) openMatch:(NSString *)matchID inDocument:(NSString *)fileName;
- (void) closeCurrentMatch;
- (void) resetCurrentGame;
- (void) addNewOverToCurrentInning;
- (void) addDelivery;
- (void) addDeliveryWithRuns:(int)runs;
- (void) addDeliveryWithWicket;


@end
