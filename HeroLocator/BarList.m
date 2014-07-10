//
//  BarList.m
//  HeroLocator
//
//  Created by Ruben Jeronimo Fernandez on 10/07/14.
//  Copyright (c) 2014 IronHack. All rights reserved.
//

#import "BarList.h"
#import "Bar.h"
#import <MapKit/MapKit.h>

@interface BarList()

@end

@implementation BarList
+(NSArray*)takeData{
    NSMutableArray *bares = [[NSMutableArray alloc]init];
    NSString *fileNameAndPath = [[NSBundle mainBundle] pathForResource:@"bares" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:fileNameAndPath];
    for (NSDictionary *dict in array) {
        Bar *bar = [[Bar alloc] init];
        bar.title = [dict objectForKey:@"name"];
        CLLocationDegrees latitud = [[dict valueForKey:@"lat"]floatValue];
        CLLocationDegrees longitud = [[dict valueForKey:@"lon"]floatValue];
        bar.coordinate = CLLocationCoordinate2DMake(latitud,longitud);
        [bares addObject:bar];
    }
    return bares;
}
@end
