//
//  DieEngine.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DieEngine.h"

@interface DieEngine()

@property (nonatomic) int lastBall;

- (void) handleDelivery;
- (void) handleBoundaryRoll;
- (void) handleWicketRoll;

@end

@implementation DieEngine

NSString * const DIE_ENGINE_CURRENT_ROLL_MODE = @"dieEngineCurrentRollMode";
NSString * const DIE_ENGINE_LAST_ROLLED_NUMBER = @"dieEngineLastRolledNumber";

int const MAX_DIE_NUMBER = 6;
int const DELIVERY_MODE = 0;
int const BOUNDARY_MODE = 1;
int const WICKET_MODE = 2;

@synthesize rolledNumber = _rolledNumber;
@synthesize lastBall = _lastBall;
@synthesize rollMode = _rollMode;
@synthesize delegate = _delegate;

- (void) dieStateSetRollMode:(NSNumber *)rollMode andLastRolledNumber:(NSNumber *)lastRolledNumber {
    self.rollMode = rollMode.intValue ? rollMode.intValue : 0;
    self.rolledNumber = lastRolledNumber.intValue ? lastRolledNumber.intValue : 0;
    
    NSLog(@"SET DIE STATE - rollMode: %i, lastRolledNumber: %i", self.rollMode, self.rolledNumber);
}

- (int) rollMode {
    if(!_rollMode) _rollMode = DELIVERY_MODE;
    return _rollMode;
}

- (void) rollDie {
    
    self.rolledNumber = (arc4random() % MAX_DIE_NUMBER) + 1;
    
    if(self.rollMode == DELIVERY_MODE){
        [self handleDelivery];
    }else if(self.rollMode == BOUNDARY_MODE){
        [self handleBoundaryRoll];
    }else if(self.rollMode == WICKET_MODE){
        [self handleWicketRoll];
    }
    
}

- (void) handleDelivery {
    
    int rolledNumber = self.rolledNumber;
    self.lastBall = rolledNumber;
    
    switch(rolledNumber){
        case 4:
        case 6:
            self.rollMode = BOUNDARY_MODE;
            [self.delegate dieEngineDidRollBoundaryChance];
            break;
        case 5:
            self.rollMode = WICKET_MODE;
            [self.delegate dieEngineDidRollWicketChance];
            break;
        default:
            [self.delegate dieEngineDidRollRuns:self.lastBall];
    }
    
}

- (void) handleBoundaryRoll {
    
    self.rollMode = DELIVERY_MODE;
    
    if(self.rolledNumber % 2 != 0) {
        self.lastBall = 0;
        [self.delegate dieEngineDidRollDot];
    }else [self.delegate dieEngineDidRollRuns:self.lastBall];    
}

- (void) handleWicketRoll {
    
    self.rollMode = DELIVERY_MODE;
    
    self.lastBall = 0;
    //    if(self.rolledNumber % 2 != 0){
    if(self.rolledNumber == 5 || self.rolledNumber == 3 || self.rolledNumber == 1) [self.delegate dieEngineDidRollWicket];
    else [self.delegate dieEngineDidRollDot];
}

@end
