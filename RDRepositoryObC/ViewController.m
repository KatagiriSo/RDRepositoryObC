//
//  ViewController.m
//  RDRepositoryObC
//
//  Created by developer on 2020/02/27.
//  Copyright © 2020 developer. All rights reserved.
//

#import "ViewController.h"
#import "RDWikipediaManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [RDWikipediaManager.sharedManager loadList:^(NSArray<RDWikipediaRecord *> * _Nullable records, NSError * _Nullable error) {
        NSLog(@"%@", [records description]);
    }];
}


@end
