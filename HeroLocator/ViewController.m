//
//  ViewController.m
//  HeroLocator
//
//  Created by Ruben Jeronimo Fernandez on 10/07/14.
//  Copyright (c) 2014 IronHack. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property float jaw;
@property (nonatomic,strong) CLLocationManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor: [UIColor whiteColor]];
    [self location];
    [self checkNorth];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}



// 1. arrancamos core location. primero importando, luego haciendo esto y ademas en el interface tienes que poner el delegate.
-(void)location{
    if ([CLLocationManager locationServicesEnabled]) {
        _manager = [[CLLocationManager alloc]init];
        self.manager.delegate = self;
        self.manager.desiredAccuracy = kCLLocationAccuracyKilometer;
        self.manager.distanceFilter = 500;
        [self.manager startUpdatingLocation];
        NSLog(@"latitude: %f, longitude: %f",self.manager.location.coordinate.latitude,self.manager.location.coordinate.longitude);
        [self.manager startUpdatingHeading]; //esta linea busca la direccion a donde miramos
    }
}

//este metodo nos da datos de nuestra posicion
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    for (CLLocation *location in locations) {
        NSLog(@"%@",[location description]);
        NSLog(@"Jaw:%f",location.course);
//        self.jaw = location.course;
    }
}

//este metodo nos da la orientacion hacia donde mira el dispositivo. aqui podemos poner tambien rollo de nortes magneticos y verdaderos
-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"heading: %f",newHeading.trueHeading);
    self.jaw = newHeading.trueHeading;
    [self checkNorth];
}

-(void) checkNorth{
    UILabel *direction = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, 140, 30)];
    direction.textColor = [UIColor blackColor];
    [self.view addSubview:direction];

    if (self.jaw<=10 && self.jaw>=350) {
        NSLog(@"estas mirando a papa noel");
        direction.text = @"NORTE";
    }else if (self.jaw<=100 && self.jaw>=80){
        NSLog(@"estas mirando a japon");
        direction.text = @"ESTE";
    }else if (self.jaw<=190 && self.jaw>=170){
        NSLog(@"estas mirando al sur");
        direction.text = @"SUR";
    }else if (self.jaw<=280 && self.jaw>=260){
        NSLog(@"estas mirando al sur");
        direction.text = @"OESTE";
    }else{
        NSLog(@"donde coño estas mirando");
        direction.text = @"COÑO!!";
    }
}


@end
