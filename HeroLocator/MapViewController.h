//
//  MapViewController.h
//  HeroLocator
//
//  Created by Ruben Jeronimo Fernandez on 10/07/14.
//  Copyright (c) 2014 IronHack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
- (IBAction)tipoMapa:(id)sender;
- (IBAction)centrarMapa:(id)sender;
- (IBAction)searchField:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchLabel;

@end
