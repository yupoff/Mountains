//
//  MapViewController.m
//  Mountains
//
//  Created by Тимур Аюпов on 29.05.16.
//  Copyright © 2016 Тимур Аюпов. All rights reserved.
//

#import "MapViewController.h"
#import "Mountain.h"
#import "ServerManager.h"
@import GoogleMaps;

@interface MapViewController ()
@end

@implementation MapViewController
{
    GMSMapView *mapView_;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createDataSource];

    // Do any additional setup after loading the view.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:53.831574
                                                            longitude:58.5798744
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    // Creates a marker in the center of the map.
}

- (void)createDataSource
{
    [ServerManager getOrderedMountainsByStarCount:^(NSArray *mountains) {
      for (Mountain *mountain in mountains)
      {
          [self createMarkerByMountain:mountain];
      }
    }
        onFailure:^(NSError *error){

        }];
}

- (void)createMarkerByMountain:(Mountain *)mountain
{
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(mountain.location.lat, mountain.location.lon);
    marker.title = mountain.title;
    marker.snippet = mountain.region;
    marker.map = mapView_;
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
