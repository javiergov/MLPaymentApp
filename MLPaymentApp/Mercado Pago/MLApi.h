//
//  MLApi.h
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 30-01-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLApi : NSObject

@property (nonatomic,readonly, copy) NSObject *apiResponseObject;

- (void)callPaymentMethods;
- (NSInteger)amountOfPaymentOptions;

@end
