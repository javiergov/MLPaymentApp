//
//  MLConfig.h
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 30-01-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MLCONFIGURATION_FILENAME      @"MLConfiguration.plist"
// Configuration File Keys.
static NSString *MLPublicKey = @"MLPublicKey";
static NSString *MLPaymentMethods = @"MLPaymentMethods";
static NSString *MLCardIssuer = @"MLCardIssuer";
static NSString *MLInstallments = @"MLCardIssuer";


@interface MLConfig : NSObject

@property (readonly, nonatomic, copy) NSString *publicKey;
@property (readonly, nonatomic, copy) NSString *paymentMethods;

@end
