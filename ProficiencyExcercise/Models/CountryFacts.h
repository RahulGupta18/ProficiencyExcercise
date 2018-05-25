//
//  CountryFacts.h
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fact.h"

@interface CountryFacts : NSObject

@property (strong, nonatomic) NSString *strScreenTitle;
@property (strong, nonatomic) NSArray *arrFactList;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
