//
//  PaymentMethodCell.h
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 02-02-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface PaymentMethodCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *paymentNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@end
