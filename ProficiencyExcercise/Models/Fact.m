//
//  Fact.m
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import "Fact.h"

@implementation Fact

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        
        if(![self setPropertiesWithDictionary:dictionary]) {
            self = nil;
        }
    }
    return self;
}

- (BOOL)setPropertiesWithDictionary:(NSDictionary *)dictionary {
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return NO;
    }
    
    if ([dictionary valueForKey:@"title"] != [NSNull null] &&
        [dictionary valueForKey:@"title"] != nil) {
        self.strTitleText = [dictionary valueForKey:@"title"];
    }
    else {
        self.strTitleText = @"";
    }
    
    if ([dictionary valueForKey:@"description"] != [NSNull null] &&
        [dictionary valueForKey:@"description"] != nil) {
        self.strDescriptionText = [dictionary valueForKey:@"description"];
    }
    else {
        self.strDescriptionText = @"";
    }
    
    if ([dictionary valueForKey:@"imageHref"] != [NSNull null] &&
        [dictionary valueForKey:@"imageHref"] != nil) {
        self.strImageUrl = [dictionary valueForKey:@"imageHref"];
    }
    else {
        self.strImageUrl = @"";
    }
    
    return YES;
}

@end
