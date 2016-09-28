//
//  PayHomeViewController.m
//  HarryPay
//
//  Created by Harry.Deng on 14/12/30.
//  Copyright (c) 2014年 Harry.Deng. All rights reserved.
//

#import "PayHomeViewController.h"

#import "LoginInViewController.h"

#import "UIButton+Harry.h"


@interface PayHomeCollectionCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *fuctionBt;

@end

@implementation PayHomeCollectionCell

@end



@interface PayHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *payCollectionView;
@property (weak, nonatomic) IBOutlet UIButton *scanBt;
@property (weak, nonatomic) IBOutlet UIButton *payBt;

@end

@implementation PayHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //没有登录，先跳到登录界面
//    LoginInViewController *taobaoLoginVC = GET_STORYBOARD_VC(@"Main", @"LoginInViewController");
//    [self presentViewController:taobaoLoginVC animated:NO completion:Nil];
    
    [_scanBt setTapBackgroundColor:RGBS(21)];
    [_payBt setTapBackgroundColor:RGBS(21)];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.payCollectionView addGestureRecognizer:longPress];
}

- (void)longPressGestureRecognized:(id)sender {
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.payCollectionView];
    NSIndexPath *indexPath = [self.payCollectionView indexPathForItemAtPoint:location];
    NSLog(@"location : x:%0.2f, y:%0.2f  indexPath: section:%d row:%d", location.x, location.y, (int)indexPath.section, (int)indexPath.row);
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                sourceIndexPath = indexPath;
                
                UICollectionViewCell *cell = [self.payCollectionView cellForItemAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.payCollectionView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    cell.alpha = 0.0;
                    
                } completion:^(BOOL finished) {
                    
                    cell.hidden = YES;
                    
                }];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {
//            CGPoint center = snapshot.center;
//            center.y = location.y;
            snapshot.center = location;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) {
                
                // ... update data source.
                //[self.objects exchangeObjectAtIndex:indexPath.row withObjectAtIndex:sourceIndexPath.row];
                
                // ... move the rows.
                //[self.tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        }
            
        default: {
            // Clean up.
            UICollectionViewCell *cell = [self.payCollectionView cellForItemAtIndexPath:sourceIndexPath];
            cell.hidden = NO;
            cell.alpha = 0.0;
            
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                sourceIndexPath = nil;
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            
            break;
        }
    }
}

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}


#pragma mark - viewAction
- (IBAction)scanAction {
    
}

- (IBAction)payAction {
    
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 12;
    }else if(section == 1){
        return 1;
    }else{
        return 14;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(Main_Size.width / 4.0, [GlobalMethod AdapterScreenInchBy4InchFloat:95]);
    CGFloat width = Main_Size.width / 4.0;
    switch ((int)[GlobalMethod getCurrentScreenInch]) {
        case IPHONE_35_INCH | IPHONE_40_INCH:
            return CGSizeMake(width, 95);
            break;
        case IPHONE_47_INCH:
            return CGSizeMake(width, 95);
            break;
        case IPHONE_55_INCH:
            return CGSizeMake(width, 95);
            break;
        default:
            return CGSizeMake(width, 95);
            break;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PayHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pay_collection_cell" forIndexPath:indexPath];
    
    [cell.fuctionBt setTapBackgroundColor:RGBS(230)];
    cell.fuctionBt.layer.borderWidth = 0.5;
    cell.fuctionBt.layer.borderColor = RGBS(230).CGColor;
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end
