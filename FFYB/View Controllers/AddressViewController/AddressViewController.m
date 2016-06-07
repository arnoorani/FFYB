//
//  AddressViewController.m
//  FFYB
//
//  Created by Geniusu on 31/05/16.
//  Copyright © 2016 Geniusu. All rights reserved.
//

#import "AddressViewController.h"

@interface AddressViewController ()

@end

@implementation AddressViewController
@synthesize locationManager;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getParseDataForAddress];
        // Do any additional setup after loading the view.
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    [self setDistanceTime:location.coordinate.latitude userLong:location.coordinate.longitude];
}
typedef void(^addressCompletion)(NSString *);

-(void)getAddressFromLocation:(CLLocation *)location complationBlock:(addressCompletion)completionBlock
{
    __block CLPlacemark* placemark;
    __block NSString *address = nil;
    
    CLGeocoder* geocoder = [CLGeocoder new];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (error == nil && [placemarks count] > 0)
         {
             placemark = [placemarks lastObject];
             address = [NSString stringWithFormat:@"%@, %@ %@", placemark.name, placemark.postalCode, placemark.locality];
             completionBlock(address);
         }
     }];
}

#pragma mark == Get Parse Data
-(void)getParseDataForAddress
{
    //[self popup_warning:Tittle];
    
    
    PFQuery *query = [PFQuery queryWithClassName:@"Address"];
    //  [query orderByAscending:@"Day"];
    // [query whereKey:@"Day" containsString:Day];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
    
            NSMutableArray *arry = [[NSMutableArray alloc]initWithArray: objects];
            NSLog(@"Data Arry: %@",arry);
            
            eventLatatitude = [[[objects objectAtIndex:0] valueForKey:@"latitude"] doubleValue];
            eventLongitude = [[[objects objectAtIndex:0] valueForKey:@"longitude"] doubleValue];
            
            [self setEventLocation:eventLatatitude andLongitude:eventLongitude];
        }
    }];
    
}

-(void)setEventLocation:(double)latitude andLongitude:(double)longitude
{
    // Create your coordinate
    //NSString *addressStr = [self getAddressFromLatLon:19.071690 withLongitude:72.834127];
    CLLocation* eventLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    [self getAddressFromLocation:eventLocation complationBlock:^(NSString * address) {
        if(address) {
            self.addresslabel.text = address;
        }
    }];
    
    CLLocationCoordinate2D myCoordinate = {19.071690, 72.834127};
    //Create your annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    // Set your annotation to point at your coordinate
    point.coordinate = myCoordinate;
    //If you want to clear other pins/annotations this is how to do it
    for (id annotation in self.mapView.annotations) {
        [self.mapView removeAnnotation:annotation];
    }
    // we have to setup the location manager with permission in later iOS versions
    if ([[self locationManager] respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [[self locationManager] requestWhenInUseAuthorization];
    }
    
    [[self locationManager] setDesiredAccuracy:kCLLocationAccuracyBest];
    //Drop pin on map
    [self.mapView addAnnotation:point];
    
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 &&
        [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse
        //[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedAlways
        ) {
        // Will open an confirm dialog to get user's approval
        [locationManager requestWhenInUseAuthorization];
        //[_locationManager requestAlwaysAuthorization];
    } else {
        [locationManager startUpdatingLocation]; //Will update location immediately
    }
    
    
}

-(void)setDistanceTime:(double)userLat userLong:(double)userLong
{
    NSString *strUrl = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%f,%f&destination=%f,%f&sensor=false&mode=%@", eventLatatitude,  eventLongitude, userLat,  userLong, @"DRIVING"];
    NSURL *url = [NSURL URLWithString:[strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    if(jsonData != nil)
    {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        NSMutableArray *arrDistance=[result objectForKey:@"routes"];
        if ([arrDistance count]==0) {
            NSLog(@"N.A.");
        }
        else{
            NSMutableArray *arrLeg=[[arrDistance objectAtIndex:0]objectForKey:@"legs"];
            NSMutableDictionary *dictleg=[arrLeg objectAtIndex:0];
            self.duarationlabel.text = [NSString stringWithFormat:@"Event is %@ from your location, you will reach in %@",[[dictleg   objectForKey:@"distance"] objectForKey:@"text"],[[dictleg   objectForKey:@"duration"] objectForKey:@"text"]];
            
            NSLog(@"%@",[NSString stringWithFormat:@"%@ from your location.",[[dictleg   objectForKey:@"duration"] objectForKey:@"text"]]);
        }
    }
    else{
        NSLog(@"N.A.");
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
