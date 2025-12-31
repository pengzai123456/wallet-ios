//
//  BillDetailViewController.m
//  wallet-ios
//

#import "BillDetailViewController.h"
#import "BillItem.h"
#import "Colors.h"
#import "Dimensions.h"

@interface BillDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIView *contentCard;
@property (nonatomic, strong) UITableView *itemsTableView;
@property (nonatomic, strong) UIView *summaryView;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *editBillButton;
@property (nonatomic, strong) NSArray<BillItem *> *billItems;

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    self.billItems = @[
        [BillItem itemWithName:@"Beef Teriyaki Bowl" price:4.50 quantity:1],
        [BillItem itemWithName:@"Salmon Sashimi Plate" price:4.80 quantity:1],
        [BillItem itemWithName:@"Green Tea Frappe" price:2.50 quantity:1],
        [BillItem itemWithName:@"Peach Lemonade" price:2.80 quantity:1],
        [BillItem itemWithName:@"Sencha Green Tea" price:3.00 quantity:1]
    ];
}

- (void)setupUI {
    self.view.backgroundColor = kLightGrayBackground;
    self.navigationController.navigationBarHidden = YES;
    
    [self setupHeader];
    [self setupContentCard];
    [self setupButtons];
}

- (void)setupHeader {
    self.headerView = [[UIView alloc] init];
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerView.backgroundColor = kLightGrayBackground;
    [self.view addSubview:self.headerView];
    
    self.backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.backButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backButton setImage:[UIImage systemImageNamed:@"arrow.left"] forState:UIControlStateNormal];
    self.backButton.tintColor = kTextPrimaryColor;
    [self.backButton addTarget:self action:@selector(backButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.headerView addSubview:self.backButton];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"Bill Details";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.headerView addSubview:self.titleLabel];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.moreButton setImage:[UIImage systemImageNamed:@"ellipsis"] forState:UIControlStateNormal];
    self.moreButton.tintColor = kTextPrimaryColor;
    [self.headerView addSubview:self.moreButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.headerView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.headerView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.headerView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.headerView.heightAnchor constraintEqualToConstant:50],
        
        [self.backButton.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor constant:kHorizontalPadding],
        [self.backButton.centerYAnchor constraintEqualToAnchor:self.headerView.centerYAnchor],
        [self.backButton.widthAnchor constraintEqualToConstant:44],
        [self.backButton.heightAnchor constraintEqualToConstant:44],
        
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.headerView.centerXAnchor],
        [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.headerView.centerYAnchor],
        
        [self.moreButton.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor constant:-kHorizontalPadding],
        [self.moreButton.centerYAnchor constraintEqualToAnchor:self.headerView.centerYAnchor],
        [self.moreButton.widthAnchor constraintEqualToConstant:44],
        [self.moreButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

- (void)setupContentCard {
    self.contentCard = [[UIView alloc] init];
    self.contentCard.translatesAutoresizingMaskIntoConstraints = NO;
    self.contentCard.backgroundColor = kWhiteBackground;
    self.contentCard.layer.cornerRadius = kCornerRadius;
    [self.view addSubview:self.contentCard];
    
    // Table header
    UIView *tableHeader = [[UIView alloc] init];
    tableHeader.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentCard addSubview:tableHeader];
    
    UILabel *itemsLabel = [[UILabel alloc] init];
    itemsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    itemsLabel.text = @"Item's";
    itemsLabel.font = [UIFont systemFontOfSize:14];
    itemsLabel.textColor = kTextSecondaryColor;
    [tableHeader addSubview:itemsLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    priceLabel.text = @"Price";
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = kTextSecondaryColor;
    [tableHeader addSubview:priceLabel];
    
    UILabel *qtyLabel = [[UILabel alloc] init];
    qtyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    qtyLabel.text = @"Qty";
    qtyLabel.font = [UIFont systemFontOfSize:14];
    qtyLabel.textColor = kTextSecondaryColor;
    [tableHeader addSubview:qtyLabel];
    
    // Items table
    self.itemsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.itemsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.itemsTableView.delegate = self;
    self.itemsTableView.dataSource = self;
    self.itemsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.itemsTableView.backgroundColor = [UIColor clearColor];
    self.itemsTableView.scrollEnabled = NO;
    [self.itemsTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"BillItemCell"];
    [self.contentCard addSubview:self.itemsTableView];
    
    // Summary view
    self.summaryView = [[UIView alloc] init];
    self.summaryView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentCard addSubview:self.summaryView];
    
    // Separator
    UIView *separator = [[UIView alloc] init];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    separator.backgroundColor = [kTextSecondaryColor colorWithAlphaComponent:0.2];
    [self.summaryView addSubview:separator];
    
    // Calculate totals
    CGFloat subtotal = 0;
    for (BillItem *item in self.billItems) {
        subtotal += [item totalPrice];
    }
    CGFloat tax = subtotal * 0.10;
    CGFloat discount = 2.00;
    CGFloat total = subtotal + tax - discount;
    
    // Tax row
    UILabel *taxTitleLabel = [[UILabel alloc] init];
    taxTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    taxTitleLabel.text = @"Sales Tax (10%)";
    taxTitleLabel.font = [UIFont systemFontOfSize:14];
    taxTitleLabel.textColor = kTextSecondaryColor;
    [self.summaryView addSubview:taxTitleLabel];
    
    UILabel *taxValueLabel = [[UILabel alloc] init];
    taxValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    taxValueLabel.text = [NSString stringWithFormat:@"$%.2f", tax];
    taxValueLabel.font = [UIFont systemFontOfSize:14];
    taxValueLabel.textAlignment = NSTextAlignmentRight;
    [self.summaryView addSubview:taxValueLabel];
    
    // Discount row
    UILabel *discountTitleLabel = [[UILabel alloc] init];
    discountTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    discountTitleLabel.text = @"Discount";
    discountTitleLabel.font = [UIFont systemFontOfSize:14];
    discountTitleLabel.textColor = kTextSecondaryColor;
    [self.summaryView addSubview:discountTitleLabel];
    
    UILabel *discountValueLabel = [[UILabel alloc] init];
    discountValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    discountValueLabel.text = [NSString stringWithFormat:@"-$%.2f", discount];
    discountValueLabel.font = [UIFont systemFontOfSize:14];
    discountValueLabel.textAlignment = NSTextAlignmentRight;
    [self.summaryView addSubview:discountValueLabel];
    
    // Total row
    UILabel *totalTitleLabel = [[UILabel alloc] init];
    totalTitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    totalTitleLabel.text = @"Amount";
    totalTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.summaryView addSubview:totalTitleLabel];
    
    UILabel *totalValueLabel = [[UILabel alloc] init];
    totalValueLabel.translatesAutoresizingMaskIntoConstraints = NO;
    totalValueLabel.text = [NSString stringWithFormat:@"$%.2f", total];
    totalValueLabel.font = [UIFont boldSystemFontOfSize:18];
    totalValueLabel.textAlignment = NSTextAlignmentRight;
    [self.summaryView addSubview:totalValueLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.contentCard.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:kVerticalPadding],
        [self.contentCard.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kHorizontalPadding],
        [self.contentCard.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kHorizontalPadding],
        
        [tableHeader.topAnchor constraintEqualToAnchor:self.contentCard.topAnchor constant:kVerticalPadding],
        [tableHeader.leadingAnchor constraintEqualToAnchor:self.contentCard.leadingAnchor constant:kHorizontalPadding],
        [tableHeader.trailingAnchor constraintEqualToAnchor:self.contentCard.trailingAnchor constant:-kHorizontalPadding],
        [tableHeader.heightAnchor constraintEqualToConstant:30],
        
        [itemsLabel.leadingAnchor constraintEqualToAnchor:tableHeader.leadingAnchor],
        [itemsLabel.centerYAnchor constraintEqualToAnchor:tableHeader.centerYAnchor],
        
        [priceLabel.trailingAnchor constraintEqualToAnchor:qtyLabel.leadingAnchor constant:-30],
        [priceLabel.centerYAnchor constraintEqualToAnchor:tableHeader.centerYAnchor],
        
        [qtyLabel.trailingAnchor constraintEqualToAnchor:tableHeader.trailingAnchor],
        [qtyLabel.centerYAnchor constraintEqualToAnchor:tableHeader.centerYAnchor],
        
        [self.itemsTableView.topAnchor constraintEqualToAnchor:tableHeader.bottomAnchor],
        [self.itemsTableView.leadingAnchor constraintEqualToAnchor:self.contentCard.leadingAnchor],
        [self.itemsTableView.trailingAnchor constraintEqualToAnchor:self.contentCard.trailingAnchor],
        [self.itemsTableView.heightAnchor constraintEqualToConstant:self.billItems.count * 55],
        
        [self.summaryView.topAnchor constraintEqualToAnchor:self.itemsTableView.bottomAnchor constant:10],
        [self.summaryView.leadingAnchor constraintEqualToAnchor:self.contentCard.leadingAnchor constant:kHorizontalPadding],
        [self.summaryView.trailingAnchor constraintEqualToAnchor:self.contentCard.trailingAnchor constant:-kHorizontalPadding],
        [self.summaryView.bottomAnchor constraintEqualToAnchor:self.contentCard.bottomAnchor constant:-kVerticalPadding],
        [self.summaryView.heightAnchor constraintEqualToConstant:100],
        
        [separator.topAnchor constraintEqualToAnchor:self.summaryView.topAnchor],
        [separator.leadingAnchor constraintEqualToAnchor:self.summaryView.leadingAnchor],
        [separator.trailingAnchor constraintEqualToAnchor:self.summaryView.trailingAnchor],
        [separator.heightAnchor constraintEqualToConstant:1],
        
        [taxTitleLabel.topAnchor constraintEqualToAnchor:separator.bottomAnchor constant:12],
        [taxTitleLabel.leadingAnchor constraintEqualToAnchor:self.summaryView.leadingAnchor],
        
        [taxValueLabel.centerYAnchor constraintEqualToAnchor:taxTitleLabel.centerYAnchor],
        [taxValueLabel.trailingAnchor constraintEqualToAnchor:self.summaryView.trailingAnchor],
        
        [discountTitleLabel.topAnchor constraintEqualToAnchor:taxTitleLabel.bottomAnchor constant:8],
        [discountTitleLabel.leadingAnchor constraintEqualToAnchor:self.summaryView.leadingAnchor],
        
        [discountValueLabel.centerYAnchor constraintEqualToAnchor:discountTitleLabel.centerYAnchor],
        [discountValueLabel.trailingAnchor constraintEqualToAnchor:self.summaryView.trailingAnchor],
        
        [totalTitleLabel.topAnchor constraintEqualToAnchor:discountTitleLabel.bottomAnchor constant:12],
        [totalTitleLabel.leadingAnchor constraintEqualToAnchor:self.summaryView.leadingAnchor],
        
        [totalValueLabel.centerYAnchor constraintEqualToAnchor:totalTitleLabel.centerYAnchor],
        [totalValueLabel.trailingAnchor constraintEqualToAnchor:self.summaryView.trailingAnchor]
    ]];
}

- (void)setupButtons {
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.confirmButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.confirmButton setTitle:@"Confirm" forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.confirmButton.tintColor = kTextWhiteColor;
    self.confirmButton.backgroundColor = kPrimaryTealColor;
    self.confirmButton.layer.cornerRadius = 25;
    [self.confirmButton addTarget:self action:@selector(confirmButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmButton];
    
    self.editBillButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.editBillButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.editBillButton setTitle:@"Edit Bill" forState:UIControlStateNormal];
    self.editBillButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.editBillButton.tintColor = kTextPrimaryColor;
    self.editBillButton.backgroundColor = kWhiteBackground;
    self.editBillButton.layer.cornerRadius = 25;
    self.editBillButton.layer.borderWidth = 1;
    self.editBillButton.layer.borderColor = [kTextSecondaryColor colorWithAlphaComponent:0.3].CGColor;
    [self.editBillButton addTarget:self action:@selector(editBillButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.editBillButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.confirmButton.bottomAnchor constraintEqualToAnchor:self.editBillButton.topAnchor constant:-12],
        [self.confirmButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kHorizontalPadding],
        [self.confirmButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kHorizontalPadding],
        [self.confirmButton.heightAnchor constraintEqualToConstant:kButtonHeight],
        
        [self.editBillButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-kVerticalPadding],
        [self.editBillButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kHorizontalPadding],
        [self.editBillButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kHorizontalPadding],
        [self.editBillButton.heightAnchor constraintEqualToConstant:kButtonHeight]
    ]];
}

- (void)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)confirmButtonTapped {
    NSLog(@"Confirm button tapped");
}

- (void)editBillButtonTapped {
    NSLog(@"Edit bill button tapped");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.billItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillItemCell" forIndexPath:indexPath];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    BillItem *item = self.billItems[indexPath.row];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.text = item.itemName;
    nameLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:nameLabel];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    priceLabel.text = [NSString stringWithFormat:@"$%.2f", item.price];
    priceLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:priceLabel];
    
    UILabel *qtyLabel = [[UILabel alloc] init];
    qtyLabel.translatesAutoresizingMaskIntoConstraints = NO;
    qtyLabel.text = [NSString stringWithFormat:@"%ld", (long)item.quantity];
    qtyLabel.font = [UIFont systemFontOfSize:15];
    qtyLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:qtyLabel];
    
    // Add button
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeSystem];
    addButton.translatesAutoresizingMaskIntoConstraints = NO;
    [addButton setImage:[UIImage systemImageNamed:@"plus.circle"] forState:UIControlStateNormal];
    addButton.tintColor = kTextSecondaryColor;
    [cell.contentView addSubview:addButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [nameLabel.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:kHorizontalPadding],
        [nameLabel.topAnchor constraintEqualToAnchor:cell.contentView.topAnchor constant:8],
        
        [addButton.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:kHorizontalPadding],
        [addButton.topAnchor constraintEqualToAnchor:nameLabel.bottomAnchor constant:4],
        [addButton.widthAnchor constraintEqualToConstant:24],
        [addButton.heightAnchor constraintEqualToConstant:24],
        
        [priceLabel.trailingAnchor constraintEqualToAnchor:qtyLabel.leadingAnchor constant:-30],
        [priceLabel.centerYAnchor constraintEqualToAnchor:nameLabel.centerYAnchor],
        
        [qtyLabel.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-kHorizontalPadding],
        [qtyLabel.centerYAnchor constraintEqualToAnchor:nameLabel.centerYAnchor],
        [qtyLabel.widthAnchor constraintEqualToConstant:30]
    ]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

@end
