//
//  AFNetworkingSearchManager.m
//  Mobile Practise
//
//  Created by Marcelo Busico on 19/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "AFNetworkingSearchManager.h"
#import "ItemEntity.h"

@implementation AFNetworkingSearchManager

-(void)searchItemsWithQuery:(NSString *)searchString completionBlock:(void (^)(NSArray *))completionBlock {
    NSString *stringUrl = [NSString stringWithFormat:kSearchURL, searchString];
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *itemEntities = [ItemEntity itemEntitiesFromJson:responseObject];
        completionBlock(itemEntities);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completionBlock(nil);
    }];
    
    [operation start];
}

@end
