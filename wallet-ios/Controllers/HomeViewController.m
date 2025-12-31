//
//  HomeViewController.m
//  wallet-ios
//

#import "HomeViewController.h"
#import "Colors.h"
#import "Dimensions.h"

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *greetingLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *notificationButton;
@property (nonatomic, strong) UIView *balanceCardView;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, assign) BOOL isBalanceHidden;
@property (nonatomic, strong) UICollectionView *quickActionsView;
@property (nonatomic, strong) UICollectionView *quickSendView;
@property (nonatomic, strong) UITableView *transactionTableView;
@property (nonatomic, strong) NSArray *quickActions;
@property (nonatomic, strong) NSArray *contacts;
@property (nonatomic, strong) NSArray *transactions;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    self.quickActions = @[
        @{@"icon": @"paperplane", @"title": @"Send"},
        @{@"icon": @"doc.text", @"title": @"Split Bills"},
        @{@"icon": @"globe", @"title": @"Data Internet"},
        @{@"icon": @"square.grid.2x2", @"title": @"More"}
    ];
    
    self.contacts = @[
        @{@"name": @"Add", @"isAdd": @YES},
        @{@"name": @"Miranda", @"isAdd": @NO},
        @{@"name": @"Alex houten", @"isAdd": @NO},
        @{@"name": @"Dibala", @"isAdd": @NO},
        @{@"name": @"Rosdia", @"isAdd": @NO}
    ];
    
    self.transactions = @[
        @{@"icon": @"apple.logo", @"name": @"Apple music", @"date": @"Dec 15, 2023", @"amount": @"-$35.43", @"status": @"Paid"},
        @{@"icon": @"play.rectangle.fill", @"name": @"Youtube premium", @"date": @"Dec 15, 2023", @"amount": @"-$18.12", @"status": @"Paid"}
    ];
    
    self.isBalanceHidden = NO;
}

- (void)setupUI {
    self.view.backgroundColor = kLightGrayBackground;
    self.navigationController.navigationBarHidden = YES;
    
    [self setupScrollView];
    [self setupHeader];
    [self setupBalanceCard];
    [self setupQuickActions];
    [self setupQuickSend];
    [self setupTransactionHistory];
}

- (void)setupScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    self.contentView = [[UIView alloc] init];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.scrollView addSubview:self.contentView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        
        [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
        [self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
        [self.contentView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor]
    ]];
}

- (void)setupHeader {
    // Avatar
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarImageView.backgroundColor = [UIColor lightGrayColor];
    self.avatarImageView.layer.cornerRadius = 25;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.image = [UIImage systemImageNamed:@"person.circle.fill"];
    self.avatarImageView.tintColor = kPrimaryTealColor;
    [self.contentView addSubview:self.avatarImageView];
    
    // Greeting
    self.greetingLabel = [[UILabel alloc] init];
    self.greetingLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.greetingLabel.text = @"Good morning,";
    self.greetingLabel.font = [UIFont systemFontOfSize:14];
    self.greetingLabel.textColor = kTextSecondaryColor;
    [self.contentView addSubview:self.greetingLabel];
    
    // Name
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.nameLabel.text = @"Jennie Svarowski";
    self.nameLabel.font = [UIFont boldSystemFontOfSize:18];
    self.nameLabel.textColor = kTextPrimaryColor;
    [self.contentView addSubview:self.nameLabel];
    
    // Notification
    self.notificationButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.notificationButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.notificationButton setImage:[UIImage systemImageNamed:@"bell"] forState:UIControlStateNormal];
    self.notificationButton.tintColor = kTextPrimaryColor;
    [self.contentView addSubview:self.notificationButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.avatarImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:kVerticalPadding],
        [self.avatarImageView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        [self.avatarImageView.widthAnchor constraintEqualToConstant:kAvatarSize],
        [self.avatarImageView.heightAnchor constraintEqualToConstant:kAvatarSize],
        
        [self.greetingLabel.topAnchor constraintEqualToAnchor:self.avatarImageView.topAnchor constant:5],
        [self.greetingLabel.leadingAnchor constraintEqualToAnchor:self.avatarImageView.trailingAnchor constant:12],
        
        [self.nameLabel.topAnchor constraintEqualToAnchor:self.greetingLabel.bottomAnchor constant:2],
        [self.nameLabel.leadingAnchor constraintEqualToAnchor:self.greetingLabel.leadingAnchor],
        
        [self.notificationButton.centerYAnchor constraintEqualToAnchor:self.avatarImageView.centerYAnchor],
        [self.notificationButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        [self.notificationButton.widthAnchor constraintEqualToConstant:44],
        [self.notificationButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

- (void)setupBalanceCard {
    self.balanceCardView = [[UIView alloc] init];
    self.balanceCardView.translatesAutoresizingMaskIntoConstraints = NO;
    self.balanceCardView.backgroundColor = kPrimaryTealColor;
    self.balanceCardView.layer.cornerRadius = kCornerRadius;
    [self.contentView addSubview:self.balanceCardView];
    
    // Currency selector
    UIView *currencyView = [[UIView alloc] init];
    currencyView.translatesAutoresizingMaskIntoConstraints = NO;
    currencyView.backgroundColor = kWhiteBackground;
    currencyView.layer.cornerRadius = 15;
    [self.balanceCardView addSubview:currencyView];
    
    UILabel *currencyLabel = [[UILabel alloc] init];
    currencyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    currencyLabel.text = @"🇺🇸 US Dollars";
    currencyLabel.font = [UIFont systemFontOfSize:12];
    [currencyView addSubview:currencyLabel];
    
    // Balance
    self.balanceLabel = [[UILabel alloc] init];
    self.balanceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.balanceLabel.text = @"$ 243,320.00";
    self.balanceLabel.font = [UIFont boldSystemFontOfSize:32];
    self.balanceLabel.textColor = kTextWhiteColor;
    [self.balanceCardView addSubview:self.balanceLabel];
    
    // Hide button
    UIButton *hideButton = [UIButton buttonWithType:UIButtonTypeSystem];
    hideButton.translatesAutoresizingMaskIntoConstraints = NO;
    [hideButton setImage:[UIImage systemImageNamed:@"eye.slash"] forState:UIControlStateNormal];
    hideButton.tintColor = kTextWhiteColor;
    [hideButton addTarget:self action:@selector(toggleBalanceVisibility) forControlEvents:UIControlEventTouchUpInside];
    [self.balanceCardView addSubview:hideButton];
    
    // Card info
    UILabel *numberLabel = [[UILabel alloc] init];
    numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    numberLabel.text = @"Number\n**** 9877";
    numberLabel.numberOfLines = 2;
    numberLabel.font = [UIFont systemFontOfSize:12];
    numberLabel.textColor = [kTextWhiteColor colorWithAlphaComponent:0.8];
    [self.balanceCardView addSubview:numberLabel];
    
    UILabel *expLabel = [[UILabel alloc] init];
    expLabel.translatesAutoresizingMaskIntoConstraints = NO;
    expLabel.text = @"Exp.\n05/25";
    expLabel.numberOfLines = 2;
    expLabel.font = [UIFont systemFontOfSize:12];
    expLabel.textColor = [kTextWhiteColor colorWithAlphaComponent:0.8];
    [self.balanceCardView addSubview:expLabel];
    
    UILabel *visaLabel = [[UILabel alloc] init];
    visaLabel.translatesAutoresizingMaskIntoConstraints = NO;
    visaLabel.text = @"VISA";
    visaLabel.font = [UIFont boldSystemFontOfSize:20];
    visaLabel.textColor = kTextWhiteColor;
    [self.balanceCardView addSubview:visaLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.balanceCardView.topAnchor constraintEqualToAnchor:self.avatarImageView.bottomAnchor constant:kVerticalPadding],
        [self.balanceCardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        [self.balanceCardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        [self.balanceCardView.heightAnchor constraintEqualToConstant:kBalanceCardHeight],
        
        [currencyView.topAnchor constraintEqualToAnchor:self.balanceCardView.topAnchor constant:12],
        [currencyView.trailingAnchor constraintEqualToAnchor:self.balanceCardView.trailingAnchor constant:-12],
        [currencyView.heightAnchor constraintEqualToConstant:30],
        
        [currencyLabel.centerYAnchor constraintEqualToAnchor:currencyView.centerYAnchor],
        [currencyLabel.leadingAnchor constraintEqualToAnchor:currencyView.leadingAnchor constant:10],
        [currencyLabel.trailingAnchor constraintEqualToAnchor:currencyView.trailingAnchor constant:-10],
        
        [self.balanceLabel.topAnchor constraintEqualToAnchor:currencyView.bottomAnchor constant:12],
        [self.balanceLabel.leadingAnchor constraintEqualToAnchor:self.balanceCardView.leadingAnchor constant:16],
        
        [hideButton.centerYAnchor constraintEqualToAnchor:self.balanceLabel.centerYAnchor],
        [hideButton.trailingAnchor constraintEqualToAnchor:self.balanceCardView.trailingAnchor constant:-16],
        
        [numberLabel.bottomAnchor constraintEqualToAnchor:self.balanceCardView.bottomAnchor constant:-16],
        [numberLabel.leadingAnchor constraintEqualToAnchor:self.balanceCardView.leadingAnchor constant:16],
        
        [expLabel.bottomAnchor constraintEqualToAnchor:numberLabel.bottomAnchor],
        [expLabel.leadingAnchor constraintEqualToAnchor:numberLabel.trailingAnchor constant:30],
        
        [visaLabel.bottomAnchor constraintEqualToAnchor:self.balanceCardView.bottomAnchor constant:-16],
        [visaLabel.trailingAnchor constraintEqualToAnchor:self.balanceCardView.trailingAnchor constant:-16]
    ]];
}

- (void)setupQuickActions {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(70, 80);
    layout.minimumInteritemSpacing = 20;
    
    self.quickActionsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.quickActionsView.translatesAutoresizingMaskIntoConstraints = NO;
    self.quickActionsView.backgroundColor = [UIColor clearColor];
    self.quickActionsView.delegate = self;
    self.quickActionsView.dataSource = self;
    self.quickActionsView.showsHorizontalScrollIndicator = NO;
    self.quickActionsView.tag = 100;
    [self.quickActionsView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"QuickActionCell"];
    [self.contentView addSubview:self.quickActionsView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.quickActionsView.topAnchor constraintEqualToAnchor:self.balanceCardView.bottomAnchor constant:kVerticalPadding],
        [self.quickActionsView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        [self.quickActionsView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        [self.quickActionsView.heightAnchor constraintEqualToConstant:90]
    ]];
}

- (void)setupQuickSend {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = @"Quick send";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:titleLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(60, 80);
    layout.minimumInteritemSpacing = 15;
    
    self.quickSendView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.quickSendView.translatesAutoresizingMaskIntoConstraints = NO;
    self.quickSendView.backgroundColor = [UIColor clearColor];
    self.quickSendView.delegate = self;
    self.quickSendView.dataSource = self;
    self.quickSendView.showsHorizontalScrollIndicator = NO;
    self.quickSendView.tag = 200;
    [self.quickSendView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"QuickSendCell"];
    [self.contentView addSubview:self.quickSendView];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.topAnchor constraintEqualToAnchor:self.quickActionsView.bottomAnchor constant:kVerticalPadding],
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        
        [self.quickSendView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:12],
        [self.quickSendView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        [self.quickSendView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        [self.quickSendView.heightAnchor constraintEqualToConstant:90]
    ]];
}

- (void)setupTransactionHistory {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.text = @"Transaction history";
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:titleLabel];
    
    UIButton *viewAllButton = [UIButton buttonWithType:UIButtonTypeSystem];
    viewAllButton.translatesAutoresizingMaskIntoConstraints = NO;
    [viewAllButton setTitle:@"View all" forState:UIControlStateNormal];
    viewAllButton.tintColor = kPrimaryTealColor;
    [self.contentView addSubview:viewAllButton];
    
    self.transactionTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.transactionTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.transactionTableView.delegate = self;
    self.transactionTableView.dataSource = self;
    self.transactionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.transactionTableView.backgroundColor = [UIColor clearColor];
    self.transactionTableView.scrollEnabled = NO;
    [self.transactionTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TransactionCell"];
    [self.contentView addSubview:self.transactionTableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [titleLabel.topAnchor constraintEqualToAnchor:self.quickSendView.bottomAnchor constant:kVerticalPadding],
        [titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        
        [viewAllButton.centerYAnchor constraintEqualToAnchor:titleLabel.centerYAnchor],
        [viewAllButton.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        
        [self.transactionTableView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:12],
        [self.transactionTableView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kHorizontalPadding],
        [self.transactionTableView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kHorizontalPadding],
        [self.transactionTableView.heightAnchor constraintEqualToConstant:150],
        [self.transactionTableView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-100]
    ]];
}

- (void)toggleBalanceVisibility {
    self.isBalanceHidden = !self.isBalanceHidden;
    self.balanceLabel.text = self.isBalanceHidden ? @"$ ********" : @"$ 243,320.00";
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 100) {
        return self.quickActions.count;
    }
    return self.contacts.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 100) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuickActionCell" forIndexPath:indexPath];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSDictionary *action = self.quickActions[indexPath.item];
        
        UIView *iconBg = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 60, 60)];
        iconBg.backgroundColor = kWhiteBackground;
        iconBg.layer.cornerRadius = 12;
        [cell.contentView addSubview:iconBg];
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 30, 30)];
        iconView.image = [UIImage systemImageNamed:action[@"icon"]];
        iconView.tintColor = kTextPrimaryColor;
        [iconBg addSubview:iconView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, 70, 15)];
        titleLabel.text = action[@"title"];
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:titleLabel];
        
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuickSendCell" forIndexPath:indexPath];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSDictionary *contact = self.contacts[indexPath.item];
        BOOL isAdd = [contact[@"isAdd"] boolValue];
        
        UIView *avatarView = [[UIView alloc] initWithFrame:CGRectMake(5, 0, 50, 50)];
        avatarView.layer.cornerRadius = 25;
        avatarView.clipsToBounds = YES;
        
        if (isAdd) {
            avatarView.layer.borderWidth = 1;
            avatarView.layer.borderColor = kTextSecondaryColor.CGColor;
            UIImageView *plusIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
            plusIcon.image = [UIImage systemImageNamed:@"plus"];
            plusIcon.tintColor = kTextSecondaryColor;
            [avatarView addSubview:plusIcon];
        } else {
            avatarView.backgroundColor = [UIColor colorWithRed:(arc4random() % 100) / 100.0 green:(arc4random() % 100) / 100.0 blue:(arc4random() % 100) / 100.0 alpha:0.3];
            UILabel *initialLabel = [[UILabel alloc] initWithFrame:avatarView.bounds];
            initialLabel.text = [[contact[@"name"] substringToIndex:1] uppercaseString];
            initialLabel.textAlignment = NSTextAlignmentCenter;
            initialLabel.font = [UIFont boldSystemFontOfSize:20];
            [avatarView addSubview:initialLabel];
        }
        [cell.contentView addSubview:avatarView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 55, 60, 25)];
        nameLabel.text = contact[@"name"];
        nameLabel.font = [UIFont systemFontOfSize:10];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.numberOfLines = 2;
        [cell.contentView addSubview:nameLabel];
        
        return cell;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSDictionary *transaction = self.transactions[indexPath.row];
    
    UIView *iconBg = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 44, 44)];
    iconBg.backgroundColor = kWhiteBackground;
    iconBg.layer.cornerRadius = 10;
    [cell.contentView addSubview:iconBg];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 24, 24)];
    iconView.image = [UIImage systemImageNamed:transaction[@"icon"]];
    iconView.tintColor = kTextPrimaryColor;
    [iconBg addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 12, 150, 20)];
    nameLabel.text = transaction[@"name"];
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [cell.contentView addSubview:nameLabel];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(54, 32, 150, 18)];
    dateLabel.text = transaction[@"date"];
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textColor = kTextSecondaryColor;
    [cell.contentView addSubview:dateLabel];
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width - 100, 12, 80, 20)];
    amountLabel.text = transaction[@"amount"];
    amountLabel.font = [UIFont boldSystemFontOfSize:15];
    amountLabel.textAlignment = NSTextAlignmentRight;
    amountLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [cell.contentView addSubview:amountLabel];
    
    UILabel *statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.contentView.bounds.size.width - 100, 32, 80, 18)];
    statusLabel.text = transaction[@"status"];
    statusLabel.font = [UIFont systemFontOfSize:12];
    statusLabel.textColor = kSuccessGreenColor;
    statusLabel.textAlignment = NSTextAlignmentRight;
    statusLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [cell.contentView addSubview:statusLabel];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

@end
