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
    
    
    
    NSString *apiPublicKey, *paymentMethodsURLString, *pmRawUrlString, *pmUrlStringEncoded;
    apiPublicKey = [self.configurationFile publicKey];
    paymentMethodsURLString = [self.configurationFile paymentMethods];
    
    pmRawUrlString = [paymentMethodsURLString stringByAppendingString:apiPublicKey];
    //pmUrlStringEncoded = [pmRawUrlString stringByAddingPercentEncodingWithAllowedCharacters:URLHostAllowedCharacterSet];
    //pmUrlStringEncoded = [pmRawUrlString stringByAddingPercentEscapesUsingEncoding:<#(NSStringEncoding)#>]
    
    NSURL *pmUrl = [[NSURL alloc] initWithString:pmRawUrlString]; //pmUrlEncoded];
    
    NSLog(@"pmS: %@\n pmURL: %@", pmRawUrlString, pmUrl.description);
    
    NSURLRequest *pmRequest = [NSURLRequest requestWithURL:pmUrl];
    NSLog(@"pmR: %@", pmRequest.description);
    AFHTTPRequestOperation *pmOperation = [[AFHTTPRequestOperation alloc] initWithRequest:pmRequest];
    [pmOperation setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [pmOperation setCompletionBlockWithSuccess:
     ^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
         NSLog(@"✅ JSON: %@", responseObject);
     }
                                     failure:
     ^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
         NSLog(@"⛔️ Failed request");
     }];
    
    //[operation start];
    [[NSOperationQueue mainQueue] addOperation:pmOperation];
    
}

@end
