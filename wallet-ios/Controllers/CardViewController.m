//
//  CardViewController.m
//  wallet-ios
//

#import "CardViewController.h"
#import "CardTableViewCell.h"
#import "CardModel.h"
#import "BillDetailViewController.h"
#import "Colors.h"
#import "Dimensions.h"

@interface CardViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UITableView *cardsTableView;
@property (nonatomic, strong) UIButton *addCardButton;
@property (nonatomic, strong) NSArray<CardModel *> *cards;

@end

@implementation CardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self setupUI];
}

- (void)setupData {
    self.cards = @[
        [CardModel cardWithId:@"1"
                     cardType:@"VISA"
                   cardNumber:@"2243665294359982"
                   expiryDate:@"05/25"
               cardHolderName:@"Jennie Svarowsk"
                    cardColor:kPrimaryTealColor],
        [CardModel cardWithId:@"2"
                     cardType:@"VISA"
                   cardNumber:@"1234567890123456"
                   expiryDate:@"11/26"
               cardHolderName:@"Alice Wonderland"
                    cardColor:kCardDarkBackground]
    ];
}

- (void)setupUI {
    self.view.backgroundColor = kLightGrayBackground;
    self.navigationController.navigationBarHidden = YES;
    
    [self setupHeader];
    [self setupTableView];
    [self setupAddButton];
}

- (void)setupHeader {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.text = @"My Cards";
    self.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    self.titleLabel.textColor = kTextPrimaryColor;
    [self.view addSubview:self.titleLabel];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.moreButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.moreButton setImage:[UIImage systemImageNamed:@"ellipsis"] forState:UIControlStateNormal];
    self.moreButton.tintColor = kTextPrimaryColor;
    [self.view addSubview:self.moreButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:kVerticalPadding],
        [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kHorizontalPadding],
        
        [self.moreButton.centerYAnchor constraintEqualToAnchor:self.titleLabel.centerYAnchor],
        [self.moreButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kHorizontalPadding],
        [self.moreButton.widthAnchor constraintEqualToConstant:44],
        [self.moreButton.heightAnchor constraintEqualToConstant:44]
    ]];
}

- (void)setupTableView {
    self.cardsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.cardsTableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.cardsTableView.delegate = self;
    self.cardsTableView.dataSource = self;
    self.cardsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.cardsTableView.backgroundColor = [UIColor clearColor];
    self.cardsTableView.showsVerticalScrollIndicator = NO;
    [self.cardsTableView registerClass:[CardTableViewCell class] forCellReuseIdentifier:@"CardCell"];
    [self.view addSubview:self.cardsTableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.cardsTableView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:kVerticalPadding],
        [self.cardsTableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.cardsTableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.cardsTableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-150]
    ]];
}

- (void)setupAddButton {
    self.addCardButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.addCardButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addCardButton setTitle:@"Add Cards  +" forState:UIControlStateNormal];
    self.addCardButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.addCardButton.tintColor = kTextPrimaryColor;
    self.addCardButton.backgroundColor = kWhiteBackground;
    self.addCardButton.layer.cornerRadius = 25;
    self.addCardButton.layer.borderWidth = 1;
    self.addCardButton.layer.borderColor = [kTextSecondaryColor colorWithAlphaComponent:0.3].CGColor;
    [self.addCardButton addTarget:self action:@selector(addCardButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.addCardButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.addCardButton.topAnchor constraintEqualToAnchor:self.cardsTableView.bottomAnchor constant:kVerticalPadding],
        [self.addCardButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:kHorizontalPadding],
        [self.addCardButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-kHorizontalPadding],
        [self.addCardButton.heightAnchor constraintEqualToConstant:kButtonHeight]
    ]];
}

- (void)addCardButtonTapped {
    NSLog(@"Add card button tapped");
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell" forIndexPath:indexPath];
    [cell configureWithCard:self.cards[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCardCellHeight;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CardModel *selectedCard = self.cards[indexPath.row];
    BillDetailViewController *billDetailVC = [[BillDetailViewController alloc] init];
    billDetailVC.hidesBottomBarWhenPushed = YES;
    billDetailVC.selectedCard = selectedCard;
    [self.navigationController pushViewController:billDetailVC animated:YES];
}

@end
