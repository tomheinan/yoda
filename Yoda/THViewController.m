//
//  THViewController.m
//  Yoda
//
//  Created by Tom Heinan on 1/24/14.
//  Copyright (c) 2014 Tom Heinan. All rights reserved.
//

#import "THViewController.h"

@implementation THViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)pressTranslate:(id)sender
{
	NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
	NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
	
	NSString *encodedString = [self.textField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *url = [NSString stringWithFormat:@"%@?sentence=%@", API_URL, encodedString];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
	[request setValue:API_TOKEN forHTTPHeaderField:API_KEY];
	
	NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
			
			if (error) {
				self.textView.text = [error description];
			} else {
				NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
				if (httpResponse.statusCode == 403) {
					NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
					text = responseObject[@"message"];
				}
				self.textView.text = text;
			}
			
			[self.spinner stopAnimating];
		});
	}];
	
	self.textView.text = nil;
	[self.spinner startAnimating];
	[task resume];
}
@end
