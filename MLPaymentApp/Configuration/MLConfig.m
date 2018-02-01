//
//  MLConfig.m
//  MLPaymentApp
//
//  Created by Javier González Ovalle on 30-01-18.
//  Copyright © 2018 ML. All rights reserved.
//

#import "MLConfig.h"

@interface MLConfig ()

/**
 * full path to the property list configuration file.
 */
@property(nonatomic,copy) NSString *pathString;

/**
 * config file as mutable dictionary.
 */
@property(nonatomic,retain) NSMutableDictionary *configDictionary;
@end

@implementation MLConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:MLCONFIGURATION_FILENAME
                                                               ofType:nil];
        [self loadConfigurationInPath:bundlePath];
    }
    return self;
}

- (void)loadConfigurationInPath:(NSString *)filePath {
    if (filePath) {
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSMutableDictionary *localDict;
        self.pathString = filePath;
        
        if([fileManager fileExistsAtPath:filePath]) {
            localDict = [[NSMutableDictionary alloc] initWithContentsOfFile:_pathString];
        }
        else
        {
            localDict = [[NSMutableDictionary alloc] init];
            [localDict writeToFile:_pathString atomically:NO];
            NSLog(@"new configuration file created at: %@", _pathString);
        }
        self.configDictionary = localDict;
    }
    else
        NSLog(@"filepath invalid");
}

#pragma mark - Configuration values
- (NSString *)publicKey {
    //return @"444a9ef5‐8a6b‐429f‐abdf‐587639155d88";
    return [_configDictionary objectForKey:MLPublicKey];
}

- (NSString *)paymentMethods {
    
    return [_configDictionary objectForKey:MLPaymentMethods];
}

@end
