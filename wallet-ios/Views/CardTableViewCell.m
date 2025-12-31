//
//  CardTableViewCell.m
//  wallet-ios
//

#import "CardTableViewCell.h"
#import "Colors.h"
#import "Dimensions.h"

@interface CardTableViewCell ()

@property (nonatomic, strong) UIView *cardContainerView;
@property (nonatomic, strong) UILabel *cardTypeLabel;
@property (nonatomic, strong) UILabel *cardNumberTitleLabel;
@property (nonatomic, strong) UILabel *cardNumberLabel;
@property (nonatomic, strong) UILabel *expiryTitleLabel;
@property (nonatomic, strong) UILabel *expiryLabel;
@property (nonatomic, strong) UILabel *cardNameTitleLabel;
@property (nonatomic, strong) UILabel *cardHolderLabel;
@property (nonatomic, strong) UIImageView *chipImageView;
@property (nonatomic, strong) UIImageView *hideIconView;

@end

@implementation CardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    // Card container
    self.cardContainerView = [[UIView alloc] init];
    self.cardContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardContainerView.layer.cornerRadius = kCardCornerRadius;
    self.cardContainerView.clipsToBounds = YES;
    [self.contentView addSubview:self.cardContainerView];
    
    // Card type (VISA)
    self.cardTypeLabel = [[UILabel alloc] init];
    self.cardTypeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardTypeLabel.font = [UIFont boldSystemFontOfSize:24];
    self.cardTypeLabel.textColor = kTextWhiteColor;
    [self.cardContainerView addSubview:self.cardTypeLabel];
    
    // Chip icon
    self.chipImageView = [[UIImageView alloc] init];
    self.chipImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.chipImageView.image = [UIImage systemImageNamed:@"cpu"];
    self.chipImageView.tintColor = [kTextWhiteColor colorWithAlphaComponent:0.8];
    [self.cardContainerView addSubview:self.chipImageView];
    
    // Hide icon
    self.hideIconView = [[UIImageView alloc] init];
    self.hideIconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.hideIconView.image = [UIImage systemImageNamed:@"eye.slash"];
    self.hideIconView.tintColor = [kTextWhiteColor colorWithAlphaComponent:0.6];
    [self.cardContainerView addSubview:self.hideIconView];
    
    // Card number title
    self.cardNumberTitleLabel = [[UILabel alloc] init];
    self.cardNumberTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardNumberTitleLabel.text = @"Card Number";
    self.cardNumberTitleLabel.font = [UIFont systemFontOfSize:12];
    self.cardNumberTitleLabel.textColor = [kTextWhiteColor colorWithAlphaComponent:0.7];
    [self.cardContainerView addSubview:self.cardNumberTitleLabel];
    
    // Card number
    self.cardNumberLabel = [[UILabel alloc] init];
    self.cardNumberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardNumberLabel.font = [UIFont boldSystemFontOfSize:20];
    self.cardNumberLabel.textColor = kTextWhiteColor;
    [self.cardContainerView addSubview:self.cardNumberLabel];
    
    // Expiry title
    self.expiryTitleLabel = [[UILabel alloc] init];
    self.expiryTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.expiryTitleLabel.text = @"Exp";
    self.expiryTitleLabel.font = [UIFont systemFontOfSize:12];
    self.expiryTitleLabel.textColor = [kTextWhiteColor colorWithAlphaComponent:0.7];
    [self.cardContainerView addSubview:self.expiryTitleLabel];
    
    // Expiry
    self.expiryLabel = [[UILabel alloc] init];
    self.expiryLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.expiryLabel.font = [UIFont boldSystemFontOfSize:14];
    self.expiryLabel.textColor = kTextWhiteColor;
    [self.cardContainerView addSubview:self.expiryLabel];
    
    // Card name title
    self.cardNameTitleLabel = [[UILabel alloc] init];
    self.cardNameTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardNameTitleLabel.text = @"Card Name";
    self.cardNameTitleLabel.font = [UIFont systemFontOfSize:12];
    self.cardNameTitleLabel.textColor = [kTextWhiteColor colorWithAlphaComponent:0.7];
    [self.cardContainerView addSubview:self.cardNameTitleLabel];
    
    // Card holder
    self.cardHolderLabel = [[UILabel alloc] init];
    self.cardHolderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardHolderLabel.font = [UIFont boldSystemFontOfSize:14];
    self.cardHolderLabel.textColor = kTextWhiteColor;
    [self.cardContainerView addSubview:self.cardHolderLabel];
    
    [self setupConstraints];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
        [self.cardContainerView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:10],
        [self.cardContainerView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        [self.cardContainerView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        [self.cardContainerView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-10],
        
        [self.cardTypeLabel.topAnchor constraintEqualToAnchor:self.cardContainerView.topAnchor constant:20],
        [self.cardTypeLabel.leadingAnchor constraintEqualToAnchor:self.cardContainerView.leadingAnchor constant:20],
        
        [self.chipImageView.topAnchor constraintEqualToAnchor:self.cardContainerView.topAnchor constant:20],
        [self.chipImageView.trailingAnchor constraintEqualToAnchor:self.cardContainerView.trailingAnchor constant:-20],
        [self.chipImageView.widthAnchor constraintEqualToConstant:35],
        [self.chipImageView.heightAnchor constraintEqualToConstant:28],
        
        [self.hideIconView.topAnchor constraintEqualToAnchor:self.chipImageView.bottomAnchor constant:8],
        [self.hideIconView.trailingAnchor constraintEqualToAnchor:self.cardContainerView.trailingAnchor constant:-20],
        [self.hideIconView.widthAnchor constraintEqualToConstant:24],
        [self.hideIconView.heightAnchor constraintEqualToConstant:20],
        
        [self.cardNumberTitleLabel.topAnchor constraintEqualToAnchor:self.cardTypeLabel.bottomAnchor constant:12],
        [self.cardNumberTitleLabel.leadingAnchor constraintEqualToAnchor:self.cardContainerView.leadingAnchor constant:20],
        
        [self.cardNumberLabel.topAnchor constraintEqualToAnchor:self.cardNumberTitleLabel.bottomAnchor constant:4],
        [self.cardNumberLabel.leadingAnchor constraintEqualToAnchor:self.cardContainerView.leadingAnchor constant:20],
        
        [self.expiryTitleLabel.bottomAnchor constraintEqualToAnchor:self.expiryLabel.topAnchor constant:-4],
        [self.expiryTitleLabel.leadingAnchor constraintEqualToAnchor:self.cardContainerView.leadingAnchor constant:20],
        
        [self.expiryLabel.bottomAnchor constraintEqualToAnchor:self.cardContainerView.bottomAnchor constant:-20],
        [self.expiryLabel.leadingAnchor constraintEqualToAnchor:self.cardContainerView.leadingAnchor constant:20],
        
        [self.cardNameTitleLabel.bottomAnchor constraintEqualToAnchor:self.cardHolderLabel.topAnchor constant:-4],
        [self.cardNameTitleLabel.trailingAnchor constraintEqualToAnchor:self.cardContainerView.trailingAnchor constant:-20],
        
        [self.cardHolderLabel.bottomAnchor constraintEqualToAnchor:self.cardContainerView.bottomAnchor constant:-20],
        [self.cardHolderLabel.trailingAnchor constraintEqualToAnchor:self.cardContainerView.trailingAnchor constant:-20]
    ]];
}

- (void)configureWithCard:(CardModel *)card {
    self.cardTypeLabel.text = card.cardType;
    self.cardNumberLabel.text = card.maskedNumber;
    self.expiryLabel.text = card.expiryDate;
    self.cardHolderLabel.text = card.cardHolderName;
    self.cardContainerView.backgroundColor = card.cardColor;
}

@end
