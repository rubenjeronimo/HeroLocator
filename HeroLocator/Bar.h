//
//  Bar.h
//  HeroLocator
//
//  Created by Ruben Jeronimo Fernandez on 10/07/14.
//  Copyright (c) 2014 IronHack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Bar : NSObject<MKAnnotation>
@property (nonatomic,copy) NSString *title;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end
