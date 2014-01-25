//
//  THViewController.h
//  Yoda
//
//  Created by Tom Heinan on 1/24/14.
//  Copyright (c) 2014 Tom Heinan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define API_URL @"https://yoda.p.mashape.com/yoda"
#define API_KEY @"X-Mashape-Authorization"
#define API_TOKEN @"PUB3M2MZXnmq8#7RP7MpG4-PkWzocaia"

@interface THViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (IBAction)pressTranslate:(id)sender;

@end
