//
//  BillItem.h
//  wallet-ios
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillItem : NSObject

@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger quantity;

+ (instancetype)itemWithName:(NSString *)name price:(CGFloat)price quantity:(NSInteger)quantity;
- (CGFloat)totalPrice;

@end

NS_ASSUME_NONNULL_END
