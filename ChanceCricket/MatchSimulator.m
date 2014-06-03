//
//  MatchSimulator.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 3/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchSimulator.h"
#import "Bowler.h"

@implementation MatchSimulator

@synthesize matchEngine = _matchEngine;
@synthesize dieEngine = _dieEngine;
@synthesize matchID = _matchID;
@synthesize delegate = _delegate;
@synthesize isConcurrent = _isConcurrent;
@synthesize isFinished = _isFinished;
@synthesize isExecuting = _isExecuting;
@synthesize filename = _filename;

- (id)init {
    self = [super init];
    if (self) {
        self.isExecuting = NO;
        self.isFinished = NO;
    }
    return self;
}

- (id) initWithMatchID:(NSString *)matchID setFilename:(NSString *)filename {
    self = [super init];
    self.matchID = matchID;
    self.filename = filename;
    
    if (self) {
        self.isExecuting = NO;
        self.isFinished = NO;
    }
    
    return self;
}

- (void) start {
    // code to start
    self.isExecuting = YES;
    
    [self.matchEngine openMatch:self.matchID inDocument:self.filename];
}


- (MatchEngine *) matchEngine {    
    if(!_matchEngine){
        _matchEngine = [[MatchEngine alloc] init];
        _matchEngine.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMatchEngineMatchOpened:) name:MATCH_ENGINE_MATCH_OPENED object:_matchEngine];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onMatchEngineUpdate:) name:MATCH_ENGINE_UPDATE object:_matchEngine];
    }
    return _matchEngine;
}

- (void) onMatchEngineMatchOpened:(NSNotification *)notification {
    NSLog(@"Start Simulating Match");
    [self rollDie];
}

- (void) onMatchEngineUpdate:(NSNotification *)notification {
    if(![self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_COMPLETED])[self rollDie];
    else{
//        [self.operationQueue cancelAllOperations];
        NSLog(@"Match Simulation Finished");
        self.isExecuting = NO;
        self.isFinished = YES;
        
        [self.delegate matchSimulator:self didFinishMatch:self.matchEngine.currentMatch];
        
//        self.matchEngine = nil;
//        self.dieEngine = nil;
    }
}

- (void) rollDie {
    
    if([self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_CREATED] || 
       [self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_SCHEDULED]) self.matchEngine.currentMatch.state = MATCH_STATE_IN_PROGRESS;
    
    if([self.matchEngine.currentMatch.state isEqualToString:MATCH_STATE_IN_PROGRESS]) [self.dieEngine rollDie]; 
}

- (DieEngine *) dieEngine {
    if (!_dieEngine){
        _dieEngine = [[DieEngine alloc] init];
        _dieEngine.delegate = self;
    }
    return _dieEngine;
}

- (void)dieEngineDidRollWicketChance {
    [self rollDie];
}

- (void)dieEngineDidRollBoundaryChance {
    [self rollDie];
}

- (void)dieEngineDidRollDot {
    [self.matchEngine addDelivery];
}

- (void)dieEngineDidRollRuns:(int)runs {
    [self.matchEngine addDeliveryWithRuns:runs];
}

- (void)dieEngineDidRollWicket {
    [self.matchEngine addDeliveryWithWicket];
}

- (void) selectBowler:(MatchEngine *)sender {
        
    NSOrderedSet *availableBowlers = [[self.matchEngine.currentInning eligibleBowlerSet] copy];
    Bowler *bowler = [availableBowlers lastObject];
    self.matchEngine.currentInning.currentRestingBowler = bowler;
    
    NSLog(@"Bowler needed. New Bowler: %@", bowler.bowlerName);
}

@end
