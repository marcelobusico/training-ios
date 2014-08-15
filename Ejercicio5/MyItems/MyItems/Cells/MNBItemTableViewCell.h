//
//  MNBItemTableViewCell.h
//  MyItems
//
//  Created by Marcelo Busico on 12/08/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MNBItemTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

@end
