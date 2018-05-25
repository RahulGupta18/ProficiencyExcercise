//
//  CountryFacts.m
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import "CountryFacts.h"

@implementation CountryFacts

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
        self.strScreenTitle = [dictionary valueForKey:@"title"];
    }
    
    if ([[dictionary valueForKey:@"rows"] isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *arrTemp = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in [dictionary valueForKey:@"rows"]) {
            
            if ([dict valueForKey:@"title"] == [NSNull null] || [dict valueForKey:@"title"] == nil) {
                continue;
            }
            
            Fact *fact = [[Fact alloc] initWithDictionary:dict];
            [arrTemp addObject: fact];
        }
        self.arrFactList = [[NSArray alloc] initWithArray:(NSArray*)arrTemp];
    }
    
    return YES;
}

@end
