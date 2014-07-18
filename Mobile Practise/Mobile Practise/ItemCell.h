//
//  ItemCell.h
//  Mobile Practise
//
//  Created by Marcelo Busico on 18/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell

@property (weak,nonatomic) IBOutlet UILabel *lblTitle;
@property (weak,nonatomic) IBOutlet UILabel *lblPrice;
@property (weak,nonatomic) IBOutlet UIImageView *itemImage;

@end
