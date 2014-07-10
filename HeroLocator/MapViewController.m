//
//  MapViewController.m
//  HeroLocator
//
//  Created by Ruben Jeronimo Fernandez on 10/07/14.
//  Copyright (c) 2014 IronHack. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import "BarList.h"
#import "Bar.h"

@interface MapViewController ()<UIActionSheetDelegate,UITextFieldDelegate>
@property  double latitudPOI;
@property double longitudPOI;
@property (weak, nonatomic) IBOutlet MKMapView *MapView;
@property (nonatomic,strong) NSArray *listadoBares;

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    self.latitudPOI = 40.392756;
    self.longitudPOI = -3.693344;
    [self mapea];
    self.listadoBares = [BarList takeData];
    [self POI];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)mapea{
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta=0.2;
    span.longitudeDelta=0.2;
    CLLocationCoordinate2D location;
    location.latitude = self.latitudPOI;
    location.longitude = self.longitudPOI;
    region.span = span;
    region.center = location;
    MKCoordinateRegion fitRegion = [self.MapView  regionThatFits:region];
    [self.MapView setRegion:fitRegion animated:YES];

    
}

-(void)POI{
    for (Bar *bar in self.listadoBares) {
//        CLLocationCoordinate2D coorPunto = CLLocationCoordinate2DMake(self.latitudPOI, self.longitudPOI);
//        MKPointAnnotation *anotacion = [[MKPointAnnotation alloc]init];
//        [anotacion setCoordinate:coorPunto];
        
        [self.MapView addAnnotation:bar];
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)tipoMapa:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc]initWithTitle:@"Map Type" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"satellite",@"standard",@"hybrid", nil];
    [as showInView:self.view];

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self.MapView setMapType:MKMapTypeSatellite];
            break;
        case 1:
            [self.MapView setMapType:MKMapTypeStandard];
            break;
        case 2:
            [self.MapView setMapType:MKMapTypeHybrid];
            break;
        default:
            break;
    }
}

- (IBAction)centrarMapa:(id)sender {
    self.latitudPOI = self.MapView.userLocation.coordinate.latitude;
    self.longitudPOI = self.MapView.userLocation.coordinate.longitude;

    [self mapea];
}



-(void) localSearch:(NSString *)searchString{
    MKLocalSearchRequest *searchRRequest = [[MKLocalSearchRequest alloc]init];
    [searchRRequest setNaturalLanguageQuery:searchString];
    [searchRRequest setRegion:[self.MapView region]];
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:searchRRequest];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (!error) {
            NSLog(@"Response!");
            [self.MapView setRegion:response.boundingRegion animated:YES];
            for (MKMapItem *poi in response.mapItems) {
                NSLog(@"%@",poi);
                Bar *barAnotation = [[Bar alloc]init];
                barAnotation.title = poi.name;
                barAnotation.coordinate = poi.placemark.coordinate;
                [self.MapView addAnnotation:barAnotation];
                
                
            }
        }
    }];
}

- (IBAction)searchField:(id)sender {
    [self resignFirstResponder];
    NSString *busca = [[NSString alloc]init];
    busca = self.searchLabel.text;
    [self localSearch:busca];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
