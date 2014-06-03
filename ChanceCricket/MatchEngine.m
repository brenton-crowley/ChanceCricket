//
//  MatchEngine.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchEngine.h"
#import "MatchSettings.h"
#import "Match+Validation.h"
#import "Batsman+Factory.h"
#import "Bowler+Factory.h"

@interface MatchEngine()

@property (nonatomic, strong) Batsman *strikeBatsman;
@property (nonatomic, strong) Batsman *nonStrikeBatsman;

- (void) setupMatch;

@end

@implementation MatchEngine

NSString * const MATCH_ENGINE_MATCH_OPENED = @"MatchEngineMatchOpened";
NSString * const MATCH_ENGINE_UPDATE = @"MatchEngineUpdate";

@synthesize strikeBatsman = _strikeBatsman;
@synthesize nonStrikeBatsman = _nonStrikeBatsman;

@synthesize fileName = _fileName;
@synthesize matchDatabase = _matchDatabase;
@synthesize currentMatch = _currentMatch;
@synthesize currentInning = _currentInning;
@synthesize currentOver = _currentOver;
@synthesize currentDelivery = _currentDelivery;
@synthesize currentID = _currentID;
@synthesize delegate = _delegate;
@synthesize isAutoSave = _isAutoSave;

#define GENERATED_GAMES 1

- (void) closeCurrentMatch {
//    self.currentMatch = nil;
//    self.currentInning = nil;
//    self.currentOver = nil;
//    self.currentDelivery = nil;
}

- (void) resetCurrentGame {
    NSLog(@"MATCH DELETED");
    
    [self.matchDatabase.managedObjectContext deleteObject:self.currentMatch];
    self.currentMatch = nil;
    self.currentOver = nil;
    self.currentDelivery = nil;

    [self saveMatch];
    [self setupMatch];
}

- (void) dispatchNotification:(NSString *) identifier {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    NSNotification *notification = [NSNotification notificationWithName:identifier object:self];
    [notificationCenter postNotification: notification];
}

- (void) saveMatch {

#warning This is no longer saving, since the database has been restructured. Will need to replace a save action here.
//    if(self.isAutoSave){
//        if(self.matchDatabase && self.matchDatabase.fileURL) {
//    NSLog(@"State: %@", self.matchDatabase);
//            [self.matchDatabase saveToURL:self.matchDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
////                //        NSLog(@"Match Saved: %@", success ? @"YES" : @"NO");
//                
//            }];
//        }
//    }
    
}

-(void)matchOpened:(UIManagedDocument *)matchDatabase {
//    NSLog(@"My Match: %@", matchDatabase.description);
    self.matchDatabase = matchDatabase;
    [self setupMatch];
}

- (void) openMatch:(NSString *)matchID inDocument:(NSString *)fileName {
    self.currentID = matchID;
    self.fileName = fileName;
    
    // here I need to supply the context - either Exhibition Match or Tournament Match, or something else in the future
    [MatchDatabase openFile:self.fileName usingBlock:^(UIManagedDocument *database) {
        [self matchOpened:database];
    }];
    
    //[MatchDatabase getDatabaseDocumentFromRequester:self];
}

- (void)setupMatch // attaches an NSFetchRequest to this UITableViewController
{    
    
    // will need some better handling to define the currentInning
    self.currentMatch = [Match selectMatch:self.currentID inContext:self.matchDatabase.managedObjectContext];
    self.currentInning = [self.currentMatch.innings lastObject];
    self.currentOver = [self.currentInning.overs lastObject];
    self.currentDelivery = [self.currentOver.deliveries lastObject];
    
//    [self saveMatch];
    
    NSLog(@"Match: %@ successfully setup", self.currentMatch.matchID);
    
    [self dispatchNotification:MATCH_ENGINE_MATCH_OPENED];
    
}

- (Match *) currentMatch {
    if(!_currentMatch) {
        _currentMatch = [Match selectMatch:self.currentID inContext:self.matchDatabase.managedObjectContext];
    }
//    NSLog(@"Current MAtch: %@", _currentMatch.description);
    return _currentMatch;
}

- (Inning *) currentInning {
    if(!_currentInning){
        // if the currentMatch has no innings then we will create one and assign it
        if(![self.currentMatch.innings lastObject]) [self.currentMatch addInningBattingTeam:self.currentMatch.homeTeam setBowlingTeam:self.currentMatch.awayTeam];
        self.currentInning = [self.currentMatch.innings lastObject];
        
    }
    return _currentInning;
}

- (Over *) currentOver {
    if(!_currentOver) {
        // have taken this line out if nothing exists. We want the user to have the ability to be able to select a bowler when the over is complete and before it has commenced.
        //if(![self.currentInning.overs lastObject]) [self.currentInning addOver: self.matchDatabase.managedObjectContext];
        _currentOver = [self.currentInning.overs lastObject];
    }
        return _currentOver;
}

- (void) addNewInningToMatch {
    if(self.currentMatch.innings.count < self.currentMatch.matchSettings.inningsLimit.intValue){
        [self.currentMatch addInningBattingTeam:self.currentMatch.awayTeam setBowlingTeam:self.currentMatch.homeTeam];
        self.currentInning = [self.currentMatch.innings lastObject];
        [self.currentInning addOver];
        self.currentOver = [self.currentInning.overs lastObject];
    }
}

- (void) addNewOverToCurrentInning {
    [self.currentInning addOver];
    self.currentOver = [self.currentInning.overs lastObject];
}

- (void) updateEngine {
    
    if([self.currentMatch isInningComplete:self.currentInning]) {
        NSLog(@"Inning Complete");
        if([self.currentMatch isComplete]){
            NSLog(@"Match Complete");
            self.currentMatch.state = MATCH_STATE_COMPLETED;
            [MatchDatabase saveDatabase:self.matchDatabase usingCompletionBlock:^(UIManagedDocument *database) {
                [self dispatchNotification:MATCH_ENGINE_UPDATE];
            }];
            return;
        }else{
            [self addNewInningToMatch];
        }
        
    }else {
        if(self.currentOver.deliveries.count == self.currentMatch.matchSettings.deliveriesPerOver.intValue && 
           self.currentInning.currentRestingBowler.overs.count == self.currentMatch.matchSettings.bowlerOverLimit.intValue){
            // Run a check here to see if the delegate exists. If not set the delegate to itself and implement the select bowler method
            [self.delegate selectBowler:self];
        }
    }
    
//    NSLog(@"Match State: %@ Add Delivery ID: %i RUNS: %i SB: %@, NSB: %@", self.currentMatch.state, self.currentDelivery.deliveryID.intValue, self.currentDelivery.deliveryRuns.intValue, self.currentInning.currentStriker.batsmanRuns, self.currentInning.currentNonStriker.batsmanRuns);
    
//    NSLog(@"self.matchDatabase.managedObjectContext: %@", self.matchDatabase.description);
    
    [self dispatchNotification:MATCH_ENGINE_UPDATE];
    [self saveMatch];
        
}

- (void) validateNewOver {
    if(!self.currentOver || self.currentOver.deliveries.count == self.currentMatch.matchSettings.deliveriesPerOver.intValue) [self addNewOverToCurrentInning];
}

- (void) addDelivery:(Delivery *)delivery {
    @try {
        self.currentDelivery = delivery;
        [self updateEngine];
    }
    @catch (NSException *exception) {
        NSLog(@"Couldn't add a delivery, %@", exception.description);
    }
//    @finally {
//        
//    }
    
}
- (void) addDelivery {
    [self validateNewOver];
    [self addDelivery:[Delivery addDeliveryDotBallToOver:self.currentOver]];
}
- (void) addDeliveryWithRuns:(int)runs {
    [self validateNewOver];
    [self addDelivery:[Delivery addDeliveryToOver:self.currentOver withRuns:runs]];
}
- (void) addDeliveryWithWicket {
    [self validateNewOver];
    [self addDelivery:[Delivery addDeliveryWicketToOver:self.currentOver]];
}

@end
