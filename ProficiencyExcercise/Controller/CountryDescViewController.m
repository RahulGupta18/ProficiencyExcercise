//
//  CountryDescViewController.m
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import "CountryDescViewController.h"
#import "FactCell.h"
#import "CountryFacts.h"
#import "Fact.h"
#import "ServiceHandler.h"
#import "Reachability.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CountryDescViewController ()

@property (nonatomic, strong) CountryFacts *factData;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end

@implementation CountryDescViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initPullToRefresh];
    [self getDataFromServer];
}

- (void)loadView {
    
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //TableView
    self.tblViwFacts = [[UITableView alloc]init];
    self.tblViwFacts.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tblViwFacts.dataSource = self;
    self.tblViwFacts.delegate = self;
    self.tblViwFacts.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:self.tblViwFacts];
    self.tblViwFacts.rowHeight = UITableViewAutomaticDimension;
    
    // Activity Indicator
    self.spinner = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake ([[UIScreen mainScreen] bounds].size.width/2 - 40, [[UIScreen mainScreen] bounds].size.height/2 - 40, 80, 80)];
    self.spinner.color = [UIColor blackColor];
    [self.view addSubview:self.spinner];
    
    [self initTableViewCell];
}

- (void)initTableViewCell {
    
    [self.tblViwFacts registerClass:[FactCell class] forCellReuseIdentifier:@"TableViewCellIdentifier"];
    self.tblViwFacts.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
}

- (void)initPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor blueColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(getDataFromServer) forControlEvents:UIControlEventValueChanged];
    [self.tblViwFacts addSubview: self.refreshControl];
}

- (void)startLoader {
    [self.spinner startAnimating];
}

- (void)stopLoader {
    [self.spinner stopAnimating];
}

// Get data from server
- (void)getDataFromServer {
    
    if ([self checkInternet]) {
        
        [self startLoader];
        
        [ServiceHandler fetchDataWithCompletion:^(NSDictionary *result, NSError *error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopLoader];
                [self.refreshControl endRefreshing];
            });
            
            if (!error) {
                
                self.factData = [[CountryFacts alloc] initWithDictionary: result];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // update the UI with your calculated results
                    self.title = self.factData.strScreenTitle;
                    self.arrFacts = self.factData.arrFactList;
                    [self.tblViwFacts reloadData];
                });
            }
            else
            {
                [self showAlertWithMessage:@"Some error occurred!" AndTitle:@""];
            }
        }];
    }
    else {
        [self showAlertWithMessage:@"No internet" AndTitle:@""];
    }
    
}

- (bool)checkInternet {
    
    NetworkStatus networkStatus = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
    
    if (networkStatus == NotReachable) {
        return FALSE;
    }
    else {
        return TRUE;
    }
}

- (void)showAlertWithMessage:(NSString*)message AndTitle:(NSString *)title {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: title
                                                                   message: message
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction* action = [UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Table view

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.arrFacts count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TableViewCellIdentifier";
    FactCell *cell = (FactCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[FactCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Fact *fact = [self.arrFacts objectAtIndex:indexPath.row];
    cell.lblFactTitle.text = fact.strTitleText;
    cell.lblFactDesc.text = fact.strDescriptionText;
    [cell.imgFact sd_setImageWithURL:[NSURL URLWithString: fact.strImageUrl]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}

-(void)dealloc {
    self.tblViwFacts = nil;
    self.arrFacts = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
