//
//  SearchManager.h
//  Mobile Practise
//
//  Created by Marcelo Busico on 19/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kSearchURL = @"https://api.mercadolibre.com/sites/MLA/search?q=%@&limit=100";

@protocol SearchManager <NSObject>

-(void)searchItemsWithQuery:(NSString *)searchString completionBlock:(void(^)(NSArray *))completionBlock;

@end
