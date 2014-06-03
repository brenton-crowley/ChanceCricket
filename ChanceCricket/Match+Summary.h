//
//  Match+Validation.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Match.h"

@interface Match (Summary)

- (NSString *) matchSummary;
- (Team *) winningTeam;
- (int) targetScore;
- (double) runRate:(Inning *)inning;

@end
