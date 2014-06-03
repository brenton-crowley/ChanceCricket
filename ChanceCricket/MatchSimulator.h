//
//  MatchSimulator.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MatchEngine.h"
#import "DieEngine.h"
#import "MatchDatabase.h"
#import "Match+Factory.h"

@class MatchSimulator;

@protocol MatchSimulatorDelegate <NSObject>

- (void) matchSimulator:(MatchSimulator *)matchSimulator didFinishMatch:(Match *)match;

@end
@interface MatchSimulator : NSOperation <DieEngineDelegate, MatchEngineDelegate>

- (id) initWithMatchID:(NSString *)matchID setFilename:(NSString *)filename;

@property (nonatomic, strong) MatchEngine *matchEngine;
@property (nonatomic, strong) DieEngine *dieEngine;
@property (nonatomic, strong) NSString *matchID;
@property (nonatomic, strong) NSString *filename;
@property (nonatomic, strong) id <MatchSimulatorDelegate> delegate;

@property (nonatomic) BOOL isConcurrent;
@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isFinished;

@end
