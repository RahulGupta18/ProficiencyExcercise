//
//  ServiceHandler.h
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ServiceHandlerCompletionBlock)(NSDictionary * response, NSError *error);

@interface ServiceHandler : NSObject

+ (void)fetchDataWithCompletion:(ServiceHandlerCompletionBlock)completionBlock;

@end
