//
//  DieEngine.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DieEngine;

@protocol DieEngineDelegate <NSObject>

@optional

extern NSString * const DIE_ENGINE_CURRENT_ROLL_MODE;
extern NSString * const DIE_ENGINE_LAST_ROLLED_NUMBER;

- (void)dieEngineDidRollBoundaryChance ;
- (void)dieEngineDidRollWicketChance;
- (void)dieEngineDidRollWicket;
- (void)dieEngineDidRollDot;
- (void)dieEngineDidRollRuns:(int)runs;

@end

@interface DieEngine : NSObject

- (void) dieStateSetRollMode:(NSNumber *)rollMode andLastRolledNumber:(NSNumber *)lastRolledNumber;

@property (nonatomic) int rollMode;
@property (nonatomic) int rolledNumber; // returns a number between 0-5.
@property (nonatomic, strong) id <DieEngineDelegate> delegate;

- (void) rollDie;

@end
