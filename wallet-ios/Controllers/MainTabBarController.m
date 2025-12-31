//
//  MainTabBarController.m
//  wallet-ios
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "CardViewController.h"
#import "ReportViewController.h"
#import "SettingViewController.h"
#import "Colors.h"
#import "Dimensions.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    [self setupTabBarAppearance];
    [self setupCenterButton];
}

- (void)setupViewControllers {
    // Home
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNav = [[UINavigationController alloc] initWithRootViewController:homeVC];
    homeNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home"
                                                       image:[UIImage systemImageNamed:@"house"]
                                               selectedImage:[UIImage systemImageNamed:@"house.fill"]];
    
    // Card
    CardViewController *cardVC = [[CardViewController alloc] init];
    UINavigationController *cardNav = [[UINavigationController alloc] initWithRootViewController:cardVC];
    cardNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Card"
                                                       image:[UIImage systemImageNamed:@"creditcard"]
                                               selectedImage:[UIImage systemImageNamed:@"creditcard.fill"]];
    
    // Center placeholder (empty VC for spacing)
    UIViewController *centerVC = [[UIViewController alloc] init];
    centerVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"" image:nil tag:2];
    centerVC.tabBarItem.enabled = NO;
    
    // Report
    ReportViewController *reportVC = [[ReportViewController alloc] init];
    UINavigationController *reportNav = [[UINavigationController alloc] initWithRootViewController:reportVC];
    reportNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Report"
                                                         image:[UIImage systemImageNamed:@"chart.pie"]
                                                 selectedImage:[UIImage systemImageNamed:@"chart.pie.fill"]];
    
    // Setting
    SettingViewController *settingVC = [[SettingViewController alloc] init];
    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:settingVC];
    settingNav.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Setting"
                                                          image:[UIImage systemImageNamed:@"gearshape"]
                                                  selectedImage:[UIImage systemImageNamed:@"gearshape.fill"]];
    
    self.viewControllers = @[homeNav, cardNav, centerVC, reportNav, settingNav];
    self.selectedIndex = 0;
}

- (void)setupTabBarAppearance {
    self.tabBar.tintColor = kPrimaryTealColor;
    self.tabBar.unselectedItemTintColor = kTabBarUnselectedColor;
    self.tabBar.backgroundColor = kWhiteBackground;
    self.tabBar.clipsToBounds = NO; // 允许按钮超出TabBar边界
    
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *appearance = [[UITabBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = kWhiteBackground;
        self.tabBar.standardAppearance = appearance;
        self.tabBar.scrollEdgeAppearance = appearance;
    }
}

- (void)setupCenterButton {
    self.centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.centerButton.frame = CGRectMake(0, 0, kCenterButtonSize, kCenterButtonSize);
    self.centerButton.backgroundColor = kPrimaryTealColor;
    self.centerButton.layer.cornerRadius = kCenterButtonSize / 2;
    self.centerButton.layer.shadowColor = kPrimaryTealColor.CGColor;
    self.centerButton.layer.shadowOffset = CGSizeMake(0, 4);
    self.centerButton.layer.shadowOpacity = 0.3;
    self.centerButton.layer.shadowRadius = 8;
    
    UIImage *centerIcon = [UIImage systemImageNamed:@"qrcode.viewfinder"];
    [self.centerButton setImage:[centerIcon imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    self.centerButton.tintColor = kTextWhiteColor;
    
    [self.centerButton addTarget:self action:@selector(centerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:self.centerButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat centerX = self.tabBar.bounds.size.width / 2;
    // 按钮中心点应该在TabBar顶部往上偏移一半按钮高度，使按钮突出显示
    CGFloat centerY = (kCenterButtonSize / 2) - 10;
    self.centerButton.center = CGPointMake(centerX, centerY);
}

- (void)centerButtonTapped:(UIButton *)sender {
    // Center button action - can be customized
    NSLog(@"Center button tapped");
}

@end
