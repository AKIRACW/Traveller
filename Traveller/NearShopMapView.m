//
//  NearShopMapView.m
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "NearShopMapView.h"
@interface NearShopMapView ()
@property(nonatomic,strong)UserModel *user;
@end


@implementation NearShopMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        
        //用户数据
        _user = [UserModel sharedUserModel];
        //地图视图
        self.mapView=[[MAMapView alloc] initWithFrame:self.bounds];
        self.mapView.delegate = self;
        self.mapView.showsUserLocation = YES;
        self.mapView.userTrackingMode = 1;
        [self addSubview:self.mapView];
        
        
        //search
        self.mapSearch = [[AMapSearchAPI alloc] initWithSearchKey:MAMapApiKey Delegate:self];
        //self.mapSearch.delegate = self;
        //
        self.arrAnnotations = [[NSMutableArray alloc] init];
        self.dicShops = [[NSMutableDictionary alloc] init];
        //btn 当前位置
        self.btnCurLocation = [[UIButton alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, self.bounds.size.height-60, 30, 30)];
        self.btnCurLocation.backgroundColor = [UIColor redColor];
        [self.btnCurLocation setTitle:@"CL" forState:UIControlStateNormal];
        [self.btnCurLocation addTarget:self action:@selector(btnCurLocationAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btnCurLocation];
        
    }
    return self;
}

- (void)btnCurLocationAction{
    NSLog(@"to cur location!");
    self.mapView.userTrackingMode = 1;
}


- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.radius = 10000;
    regeo.requireExtension = YES;
    
    [self.mapSearch AMapReGoecodeSearch:regeo];
}

- (void)getMapAnnotationsByPage:(int)page andCategory:(NSString *)cat{
    NSArray *arr = [DPRequest getBusinessListByUser:_user andCategory:@"美食" andRadius:5000 andSort:7 andPage:page];
    for (id shop in arr) {
        [self setMapAnnotationWithBussiness:shop];
        
    }
    
}

- (void)setMapAnnotationWithBussiness:(BusinessModel *)shop{
    MAPointAnnotation *pa = [[MAPointAnnotation alloc] init];
    
    pa.coordinate = CLLocationCoordinate2DMake(shop.latitude, shop.longitude);
    pa.title = shop.name;
    pa.subtitle = shop.address;
    [self.dicShops setObject:shop forKey:shop.name];
    [self.mapView addAnnotation:pa];
}

#pragma mark - MAMapViewDelegate methods
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView{
    NSLog(@"start locating user");
    
}

/*!
 @brief 在地图View停止定位后，会调用此函数*/
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView{
    NSLog(@"stop locating user");
    
}


/*!
 @brief 位置或者设备方向更新后，会调用此函数*/
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    NSLog(@"update locating user");
    self.userLocation = [userLocation coordinate];
    NSLog(@"user location:\nlongitude:%f latitude:%f",self.userLocation.longitude,self.userLocation.latitude);
    [self searchReGeocodeWithCoordinate:self.userLocation];
    _user.USER_Latitude = self.userLocation.latitude;
    _user.USER_Longtitude = self.userLocation.longitude;
    if (self.dicShops.count==0) {
        for (int i=1; i<2; i++) {
            [self getMapAnnotationsByPage:i andCategory:@""];
        }
    }
    
    
}

/*
 @brief 定位失败后，会调用此函数*/
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"locate user erroer:%@",error);
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:pointReuseIndetifier];
        }
        
        annotationView.canShowCallout               = YES;
        annotationView.animatesDrop                 = YES;
        annotationView.draggable                    = NO;
        MapShopInfoBtn *btn = [[MapShopInfoBtn alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(selectShop:) forControlEvents:UIControlEventTouchUpInside];
        btn.key = annotation.title;
        annotationView.rightCalloutAccessoryView    = btn;
        annotationView.pinColor                     = MAPinAnnotationColorRed;
        
        return annotationView;
    }
    
    return nil;
}



- (void)selectShop:(id)sender{
    NSLog(@"selected");
    MapShopInfoBtn *btn = sender;
    if([self respondsToSelector:@selector(didSelectShopMap:)]){
        [self.delegate didSelectShopMap:[self.dicShops objectForKey:btn.key]];
    }
}
#pragma mark - AMapSearchDelegate methods

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    NSMutableString *mStr = [[NSMutableString alloc] init];
    if (response.regeocode != nil)
    {
        
        NSLog(@"%@",response.regeocode.formattedAddress);
        NSLog(@"%@",response.regeocode.addressComponent.province);
        if (response.regeocode.addressComponent.city.length==0) {
            
            [mStr setString:response.regeocode.addressComponent.province];
            [mStr deleteCharactersInRange:NSMakeRange(mStr.length-1, 1)];
        }else{
            
            [mStr setString:response.regeocode.addressComponent.city];
            [mStr deleteCharactersInRange:NSMakeRange(mStr.length-1, 1)];
        }
        
    }
    
    if (![_user.USER_City isEqualToString:mStr]) {
        _user.USER_City = mStr;
        if([self respondsToSelector:@selector(didUserLocation)]){
            [self.delegate didUserLocation];
        }
    }
}

#pragma mark - SelectShopMapMethods methods
- (void)didSelectShopMap:(id)shop{
    
}

- (void)didUserLocation{
    
}
@end
