//
//  SettingViewController.m
//  wallet-ios
//

#import "SettingViewController.h"
#import "Colors.h"
#import "Dimensions.h"

@interface SettingViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = kLightGrayBackground;
    self.navigationController.navigationBarHidden = YES;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"Setting";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    self.titleLabel.textColor = kTextPrimaryColor;
    [self.view addSubview:self.titleLabel];
    
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    placeholderLabel.text = @"App Settings";
    placeholderLabel.font = [UIFont systemFontOfSize:16];
    placeholderLabel.textColor = kTextSecondaryColor;
    placeholderLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:placeholderLabel];
    
    UIImageView *iconView = [[UIImageView alloc] init];
    iconView.translatesAutoresizingMaskIntoConstraints = NO;
    iconView.image = [UIImage systemImageNamed:@"gearshape.fill"];
    iconView.tintColor = kPrimaryTealColor;
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:iconView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:kVerticalPadding],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kHorizontalPadding],
        
        [iconView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [iconView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor constant:-30],
        [iconView.widthAnchor constraintEqualToConstant:80],
        [iconView.heightAnchor constraintEqualToConstant:80],
        
        [placeholderLabel.topAnchor constraintEqualToAnchor:iconView.bottomAnchor constant:20],
        [placeholderLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]
    ]];
}

@end
