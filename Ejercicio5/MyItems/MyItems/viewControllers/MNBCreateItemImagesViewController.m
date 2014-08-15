//
//  MNBCreateItemImagesViewController.m
//  MyItems
//
//  Created by Marcelo Busico on 28/07/14.
//  Copyright (c) 2014 Marcelo Busico. All rights reserved.
//

#import "MNBCreateItemImagesViewController.h"
#import "MNBImageViewCell.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MNBItemEntity.h"

@interface MNBCreateItemImagesViewController ()

@property (nonatomic,strong) IBOutlet UICollectionView *imagesCollectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MNBItemEntity *itemEntity;

@end

@implementation MNBCreateItemImagesViewController

- (id)initWithItemEntity:(MNBItemEntity *)itemEntity
{
    self = [super initWithNibName:NSStringFromClass([self class])
                           bundle:[NSBundle mainBundle]];
    
    if (self) {
        self.title = @"Images";
        self.itemEntity = itemEntity;
        self.dataArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imagesCollectionView registerNib:[UINib nibWithNibName:@"MNBImageViewCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    [self.imagesCollectionView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count] + 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MNBImageViewCell *cell = (MNBImageViewCell *)[self.imagesCollectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    if(cell) {
        if([self.dataArray count] > indexPath.item) {
            cell.imageView.image = [self.dataArray objectAtIndex:indexPath.item];
        } else {
            cell.imageView.image = [UIImage imageNamed:@"plusImage"];
        }
    }
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(80, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.item == [self.dataArray count]) {
        //Clicking on plus icon
        [self showImagePicker];
    } else {
        //Clicking on existing image, then remove it.
        [self.dataArray removeObjectAtIndex:indexPath.item];
        [self.imagesCollectionView reloadData];
    }
}

-(void)showImagePicker {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.dataArray addObject:image];
    [self.imagesCollectionView reloadData];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)saveItem:(id)sender {
    self.itemEntity.images = self.dataArray;
    
    [self.itemEntity persistItem];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Item saved successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
