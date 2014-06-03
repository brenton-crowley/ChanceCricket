//
//  MatchSettingT20+Factory.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchSettingsT20.h"

@interface MatchSettingsT20 (Factory)

+ (MatchSettingsT20 *) addSettingsMatch:(Match *) match inContext:(NSManagedObjectContext *)context;

@end
