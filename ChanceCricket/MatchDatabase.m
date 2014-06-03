//
//  MatchDatabaseGenerator.m
//  ChanceCricket
//
//  Created by Brenton Crowley on 2/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MatchDatabase.h"


//static UIManagedDocument *matchDatabase;

//static NSMutableDictionary *managedDocumentDictionary;

@implementation MatchDatabase

+ (void)openFile:(NSString *)fileID usingBlock:(completion_block_t)completionBlock {
    
    if(!fileID) [[NSException exceptionWithName:@"Invalid File ID in MatchDatabase" reason:@"The supplied file id was not supplied or equal to nil" userInfo:nil] raise];
    
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:fileID];
        UIManagedDocument *matchDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; 
        
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:[matchDatabase.fileURL path]]) {
            [matchDatabase saveToURL:matchDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
                NSLog(@"Does not exist so create it");
                completionBlock(matchDatabase);
            }];
        } else if (matchDatabase.documentState == UIDocumentStateClosed) {
            [matchDatabase openWithCompletionHandler:^(BOOL success) {
                NSLog(@"Exists so open it");
               completionBlock(matchDatabase);
                
            }];
        } else if (matchDatabase.documentState == UIDocumentStateNormal) {
            NSLog(@"Already Open and ready to use");
            completionBlock(matchDatabase);
        }
}

//+ (void) getDatabaseDocumentFromRequester:(id <MatchDatabaseDelegate>)requester {
//    
//    if(!matchDatabase) {
//        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
//        url = [url URLByAppendingPathComponent:@"Default Chance Cricket Database"];
//        matchDatabase = [[UIManagedDocument alloc] initWithFileURL:url]; 
//        
//        
//        if (![[NSFileManager defaultManager] fileExistsAtPath:[matchDatabase.fileURL path]]) {
//            // does not exist on disk, so create it
//            [matchDatabase saveToURL:matchDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
//                NSLog(@"Does not exist so create it");
//                [requester managedDocumentOpened:matchDatabase];
//            }];
//        } else if (matchDatabase.documentState == UIDocumentStateClosed) {
//            [matchDatabase openWithCompletionHandler:^(BOOL success) {
//                NSLog(@"Exists so open it");
//                [requester managedDocumentOpened:matchDatabase];
//                
//            }];
//        } else if (matchDatabase.documentState == UIDocumentStateNormal) {
//            NSLog(@"Already Open and ready to use");
//            [requester managedDocumentOpened:matchDatabase];
//        }
//    }else{
//        [requester managedDocumentOpened:matchDatabase];
//    }
//    
//}

+ (void) saveDatabase:(UIManagedDocument *)database usingCompletionBlock:(completion_block_t)completionBlock {
    [database saveToURL:database.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        NSLog(@"Match Saved: %@", success ? @"YES" : @"NO");
        if(completionBlock) completionBlock(database);
    }];
}




@end
