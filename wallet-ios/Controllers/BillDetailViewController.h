//
//  BillDetailViewController.h
//  wallet-ios
//

#import <UIKit/UIKit.h>
#import "CardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BillDetailViewController : UIViewController

@property (nonatomic, strong) CardModel *selectedCard;

@end

NS_ASSUME_NONNULL_END
