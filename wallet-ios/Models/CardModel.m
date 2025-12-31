//
//  CardModel.m
//  wallet-ios
//

#import "CardModel.h"

@implementation CardModel

+ (instancetype)cardWithId:(NSString *)cardId
                  cardType:(NSString *)cardType
                cardNumber:(NSString *)cardNumber
                expiryDate:(NSString *)expiryDate
            cardHolderName:(NSString *)cardHolderName
                 cardColor:(UIColor *)cardColor {
    CardModel *card = [[CardModel alloc] init];
    card.cardId = cardId;
    card.cardType = cardType;
    card.cardNumber = cardNumber;
    card.expiryDate = expiryDate;
    card.cardHolderName = cardHolderName;
    card.cardColor = cardColor;
    card.maskedNumber = [card formattedCardNumber];
    return card;
}

- (NSString *)formattedCardNumber {
    if (self.cardNumber.length < 16) {
        return self.cardNumber;
    }
    NSMutableString *formatted = [NSMutableString string];
    for (NSInteger i = 0; i < self.cardNumber.length; i++) {
        if (i > 0 && i % 4 == 0) {
            [formatted appendString:@" "];
        }
        [formatted appendFormat:@"%c", [self.cardNumber characterAtIndex:i]];
    }
    return [formatted copy];
}

- (NSString *)lastFourDigits {
    if (self.cardNumber.length >= 4) {
        return [self.cardNumber substringFromIndex:self.cardNumber.length - 4];
    }
    return self.cardNumber;
}

@end
