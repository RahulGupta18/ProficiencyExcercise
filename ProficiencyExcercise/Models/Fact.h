//
//  Fact.h
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fact : NSObject

@property (strong, nonatomic) NSString *strTitleText;
@property (strong, nonatomic) NSString *strDescriptionText;
@property (strong, nonatomic) NSString *strImageUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
