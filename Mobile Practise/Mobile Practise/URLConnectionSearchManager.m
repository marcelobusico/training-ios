//
//  URLConnectionSearchManager.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 19/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "URLConnectionSearchManager.h"
#import "ItemEntity.h"

@implementation URLConnectionSearchManager

-(void)searchItemsWithQuery:(NSString *)searchString completionBlock:(void (^)(NSArray *))completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *stringUrl = [NSString stringWithFormat:kSearchURL, searchString];
        
        NSURL *url = [NSURL URLWithString:stringUrl];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLResponse *response;
        NSError *error;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        
        if (data.length > 0 && !error)
        {
            NSArray *itemEntities = [ItemEntity itemEntitiesFromData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(itemEntities);
            });
        }
    });
}

@end
