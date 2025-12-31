//
//  BillItem.m
//  wallet-ios
//

#import "BillItem.h"

@implementation BillItem

+ (instancetype)itemWithName:(NSString *)name price:(CGFloat)price quantity:(NSInteger)quantity {
    BillItem *item = [[BillItem alloc] init];
    item.itemName = name;
    item.price = price;
    item.quantity = quantity;
    return item;
}

- (CGFloat)totalPrice {
    return self.price * self.quantity;
}

@end
