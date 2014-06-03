//
//  MatchDatabaseGenerator.h
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Settings.h"

@interface MatchDatabase : NSObject

typedef void (^completion_block_t)(UIManagedDocument *database);

+ (void)openFile:(NSString *)fileID usingBlock:(completion_block_t)completionBlock;

//+ (void) getDatabaseDocumentFromRequester:(id <MatchDatabaseDelegate>)requester;
+ (void) saveDatabase:(UIManagedDocument *)database usingCompletionBlock:(completion_block_t)completionBlock;

@end
