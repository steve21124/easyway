//
//  AccessibilityItineraireAPI.m
//  accessibility
//
//  Created by Tchikovani on 08/06/2014.
//  Copyright (c) 2014 Tchikovani. All rights reserved.
//

#import "AFNetworking.h"
#import "AccessibilityItineraireAPI.h"

#define URL_SERVER "http://54.183.73.49:3000/journeys.json?"

@implementation AccessibilityItineraireAPI

- (void)searchJourney:(NSMutableDictionary *)from to:(NSMutableDictionary *)direction
{
    NSString *fromString = [NSString stringWithFormat:@"%@,%@", [from valueForKey:@"lng"], [from valueForKey:@"lat"]];
    NSString *toString = [NSString stringWithFormat:@"%@,%@", [direction valueForKey:@"lng"], [direction valueForKey:@"lat"]];
    NSString *url = [NSString stringWithFormat:@"%sfrom=%@&to=%@&datetime=20140518T0800", URL_SERVER, fromString, toString];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate resultSearchForJourney:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate errorForJourneyRequest:error];
    }];
}

@end
