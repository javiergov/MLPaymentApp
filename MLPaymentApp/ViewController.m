//
//  ViewController.m
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 29-01-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import "ViewController.h"
#import "MLApi.h"

@interface ViewController ()

@property (nonatomic, retain) MLApi *apiCaller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (!_apiCaller) {
        self.apiCaller = [[MLApi alloc] init];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"memory warning ❗️");
}

#pragma mark - Button Actions
- (IBAction)paymenMethodsButtonAction:(id)sender {
    [self.apiCaller callPaymentMethods];
}


@end
