//
//  CardTableViewCell.h
//  wallet-ios
//

#import <UIKit/UIKit.h>
#import "CardModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardTableViewCell : UITableViewCell

- (void)configureWithCard:(CardModel *)card;

@end

NS_ASSUME_NONNULL_END
