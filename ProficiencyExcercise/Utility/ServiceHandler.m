//
//  ServiceHandler.m
//  ProficiencyExcercise
//
//  Created by Mac_Admin on 24/05/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

#import "ServiceHandler.h"


@implementation ServiceHandler

+ (void)fetchDataWithCompletion:(ServiceHandlerCompletionBlock)completionBlock {
    
    NSURL *URL = [NSURL URLWithString:@"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      // ...
                                      
                                      NSData *jsonData = [NSData dataWithData:data];
                                      NSString *stringJson = [[NSString alloc] initWithData:jsonData encoding:NSISOLatin1StringEncoding];
                                      NSData * responseData = [stringJson dataUsingEncoding:NSUTF8StringEncoding];
                                      NSDictionary * jsonObject = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
                                      NSLog(@"JSON: %@", jsonObject);
                                      
                                      dispatch_async(dispatch_get_main_queue(), ^(void){
                                          completionBlock(jsonObject, error);
                                      });
                            
                                  }];
    
    [task resume];
}

@end
