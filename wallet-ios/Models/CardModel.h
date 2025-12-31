//
//  CardModel.h
//  wallet-ios
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardModel : NSObject

@property (nonatomic, copy) NSString *cardId;
@property (nonatomic, copy) NSString *cardType;
@property (nonatomic, copy) NSString *cardNumber;
@property (nonatomic, copy) NSString *maskedNumber;
@property (nonatomic, copy) NSString *expiryDate;
@property (nonatomic, copy) NSString *cardHolderName;
@property (nonatomic, strong) UIColor *cardColor;

+ (instancetype)cardWithId:(NSString *)cardId
                  cardType:(NSString *)cardType
                cardNumber:(NSString *)cardNumber
                expiryDate:(NSString *)expiryDate
            cardHolderName:(NSString *)cardHolderName
                 cardColor:(UIColor *)cardColor;

- (NSString *)formattedCardNumber;
- (NSString *)lastFourDigits;

@end

NS_ASSUME_NONNULL_END
