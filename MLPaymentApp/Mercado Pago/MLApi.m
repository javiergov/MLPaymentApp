//
//  MLApi.m
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 30-01-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import "MLApi.h"
#import "MLConfig.h"
#import "AFHTTPRequestOperation.h"

@interface MLApi ()

@property (nonatomic, strong) MLConfig *configurationFile;
@property (nonatomic, copy) NSObject *apiResponseObject;

@end


@implementation MLApi

- (instancetype)init
{
    self = [super init];
    if (self) {
        _configurationFile = [[MLConfig alloc] init];
    }
    return self;
}

- (void)callPaymentMethods {
    
    
    
    NSString *apiPublicKey, *paymentMethodsURLString, *pmRawUrlString;
    apiPublicKey = [self.configurationFile publicKey];
    paymentMethodsURLString = [self.configurationFile paymentMethods];
    
    pmRawUrlString = [paymentMethodsURLString stringByAppendingString:apiPublicKey];
    NSURL *pmUrl = [[NSURL alloc] initWithString:pmRawUrlString];
    
    NSLog(@"pmS: %@\n pmURL: %@", pmRawUrlString, pmUrl.description);
    
    NSURLRequest *pmRequest = [NSURLRequest requestWithURL:pmUrl];
    NSLog(@"pmR: %@", pmRequest.description);
    AFHTTPRequestOperation *pmOperation = [[AFHTTPRequestOperation alloc] initWithRequest:pmRequest];
    [pmOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    __weak typeof(self) weakSelf = self;
    [pmOperation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         NSLog(@"✅ JSON");
         if ([responseObject isKindOfClass:[NSArray class]]) {
             NSArray *arrayResp = responseObject;
             NSLog(@"array (%lu) response.", arrayResp.count);
             
             NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)\
              objectAtIndex:0];
             NSString *pathToSave = [docPath stringByAppendingPathComponent:@"jsonArray.plist"];
             
             if ([arrayResp writeToFile:pathToSave atomically:NO])
                 NSLog(@"file saved successfully to %@", pathToSave);
             weakSelf.apiResponseObject = responseObject;
         }
         else if ([responseObject isKindOfClass:[NSDictionary class]]) {
             NSDictionary *dictResp = responseObject;
             NSLog(@"dictionary (%lu) response: %@", dictResp.count, dictResp.description);
             weakSelf.apiResponseObject = responseObject;
         }
         else {
             NSLog(@"don't know what's the response. We won't save the object.");
         }
     }
                                     failure:
     ^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         NSLog(@"⛔️ Failed request");
     }];
    
    [[NSOperationQueue mainQueue] addOperation:pmOperation];
}

- (NSInteger)amountOfPaymentOptions {
    
    NSArray *paymentArray;
    if ([_apiResponseObject isKindOfClass:[NSArray class]]) {
        paymentArray = (NSArray *)_apiResponseObject;
    } else if ([_apiResponseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *responseDict = (NSDictionary *)self.apiResponseObject;
        paymentArray = responseDict.allKeys;
    }

    return paymentArray.count;
}

@end
