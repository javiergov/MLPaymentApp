//
//  ViewController.m
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 29-01-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import "ViewController.h"
#import "MLApi.h"
#import "MLPaymentOptionsVC.h"

static NSString *PaymentMethodsSegueIdentifier = @"showPaymentMethods";

@interface ViewController ()

@property (nonatomic, retain) MLApi *apiCaller;

@end

@implementation ViewController

static void *APIResponseChange = @"APIResponseChange";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Mercado Pago API";
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"MP API"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButton];
    
    if (!_apiCaller) {
        self.apiCaller = [[MLApi alloc] init];
        [_apiCaller addObserver:self forKeyPath:@"apiResponseObject"
                        options:NSKeyValueObservingOptionNew
                        context:APIResponseChange];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memory warning ❗️");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (context == APIResponseChange) {
        NSLog(@"cambió la información: %@",change.description);
        if ([_apiCaller.apiResponseObject isKindOfClass:[NSArray class]]) {
            NSLog(@"segue >");
            [self performSegueWithIdentifier:PaymentMethodsSegueIdentifier sender:self];
        }
    }
    
}

#pragma mark - Button Actions
- (IBAction)paymenMethodsButtonAction:(id)sender {
    [self.apiCaller callPaymentMethods];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:PaymentMethodsSegueIdentifier]) {
        NSLog(@"segue to navigation");
        if ([segue.destinationViewController isKindOfClass:[MLPaymentOptionsVC class]]) {
            MLPaymentOptionsVC *nextVC = segue.destinationViewController;
            [nextVC setApiCaller:_apiCaller];
        }
    }
}
@end
