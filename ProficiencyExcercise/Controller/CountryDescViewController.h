//
//  CountryDescViewController.h
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountryDescViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tblViwFacts;

@property(nonatomic, strong) NSArray *arrFacts;


@end

