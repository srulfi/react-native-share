//
//  GenericShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "GenericShare.h"

@implementation GenericShare
- (void)shareSingle:(NSDictionary *)options
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback
    serviceType:(NSString*)serviceType {

    NSLog(@"Try open view");
    if([SLComposeViewController isAvailableForServiceType:serviceType]) {

        SLComposeViewController *composeController = [SLComposeViewController  composeViewControllerForServiceType:serviceType];

        NSURL *URL = [RCTConvert NSURL:options[@"url"]];
        if (URL) {
            if (URL.fileURL || [URL.scheme.lowercaseString isEqualToString:@"data"]) {
                NSError *error;
                NSData *data = [NSData dataWithContentsOfURL:URL
                                                     options:(NSDataReadingOptions)0
                                                       error:&error];
                if (!data) {
                    failureCallback(error);
                    return;
                }
                UIImage *image = [UIImage imageWithData: data];
                [composeController addImage:image];

            } else {
                [composeController addURL:URL];
            }
        }

        if ([options objectForKey:@"message"] && [options objectForKey:@"message"] != [NSNull null]) {
            NSString *text = [RCTConvert NSString:options[@"message"]];
            [composeController setInitialText:text];
        }


        UIViewController *ctrl = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        [ctrl presentViewController:composeController animated:YES completion:Nil];
    } else {
        NSLog(@"No installed");
        
        
        NSString *URL = [RCTConvert NSString: options[@"url"]];
        
        NSString *shareURL = [RCTConvert NSString: options[@"urlShare"]];
        
        NSString *newURL = [shareURL stringByAppendingString: URL];
        
        
        if ([options objectForKey:@"image"] && [options objectForKey:@"image"] != [NSNull null]) {
            NSString *image = [RCTConvert NSString:options[@"image"]];
            NSString *imageParameter = @"&picture=";
            
            image = [imageParameter stringByAppendingString: image];
            
            newURL = [newURL stringByAppendingString: image];
            
        }
        
        
        if ([options objectForKey:@"description"] && [options objectForKey:@"description"] != [NSNull null]) {
            NSString *description = [RCTConvert NSString:options[@"description"]];
            NSString *descriptionParameter = @"&description=";
            
            description = [descriptionParameter stringByAppendingString: description];
            
            newURL = [newURL stringByAppendingString: description];
        }

        
        if ([options objectForKey:@"message"] && [options objectForKey:@"message"] != [NSNull null]) {
            NSString *message = [RCTConvert NSString:options[@"message"]];
            NSString *messageParameter = @"&text=";
            
            message = [messageParameter stringByAppendingString: message];
            
            newURL = [newURL stringByAppendingString: message];

        }
        
        NSString *redirect = @"http://movistarfriacj3bey5k7.devcloud.acquia-sites.com";
        NSString *redirectParameter = @"&redirect_uri=";
        
        redirect = [redirectParameter stringByAppendingString: redirect];
        newURL = [newURL stringByAppendingString: redirect];
        

        NSURL *urlOUT = [NSURL URLWithString:newURL];

        
        [[UIApplication sharedApplication] openURL: urlOUT];
        
        
    
    }


}


@end
