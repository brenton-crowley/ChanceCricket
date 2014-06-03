//
//  Match+Validation.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Match+Validation.h"
#import "Match+Summary.h"
#import "MatchSettings.h"
#import "Inning+Factory.h"
#import "Over+Factory.h"
#import "Delivery+Factory.h"

@implementation Match (Validation)

- (BOOL) isMaxWicketsReachedInInning:(Inning *)inning {
    if (inning.wickets.count == self.matchSettings.wicketLimit.intValue) return YES; //Team was bowled out;
    return NO;
}

- (BOOL) isMaxOversReachedInInning:(Inning *)inning {
    Over *currentOver = [inning.overs lastObject];
    if (inning.overs.count == self.matchSettings.inningOverLimit.intValue && currentOver.deliveries.count == self.matchSettings.deliveriesPerOver.intValue) return YES;
    return NO;
}

- (BOOL) isTargetScoreSurpassed:(Inning *)inning {
    
    if((self.innings.count == self.matchSettings.inningsLimit.intValue && [inning isEqual:[self.innings lastObject]]) && inning.inningRuns.intValue > self.targetScore) return YES;
    return NO;
}

- (BOOL) isComplete {
    if(self.innings.count == self.matchSettings.inningsLimit.intValue) return YES;
    return NO;
}

- (BOOL) isInningComplete:(Inning *)inning {
    if([self isMaxWicketsReachedInInning:inning] || [self isMaxOversReachedInInning:inning] || [self isTargetScoreSurpassed:inning]) return YES;
    return NO;
}

@end
