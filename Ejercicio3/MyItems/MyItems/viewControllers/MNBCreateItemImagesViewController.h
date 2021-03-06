//
//  MNBCreateItemImagesViewController.h
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MNBItemEntity.h"

@interface MNBCreateItemImagesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

- (id)initWithItemEntity:(MNBItemEntity *)itemEntity;

@end
