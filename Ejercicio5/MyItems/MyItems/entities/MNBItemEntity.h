//
//  MNBItemEntity.h
//  MyItems
//
//  Created by Marcelo Busico on 11/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNBItemEntity : NSObject <NSCoding>

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *subTitle;
@property (nonatomic,strong) NSNumber *price;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) NSArray *images;

-(void)persistItem;
-(void)persistItemWithItemId:(NSString *)itemId;
+(void)forgetAllItems;
+(NSArray *)loadSavedData;

@end
