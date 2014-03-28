//
//  NearShopMapView.h
//  Traveller
//
//  Created by TY on 14-3-20.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//
@protocol SelectShopMapMethods <NSObject>

- (void)didSelectShopMap:(id)shop;
- (void)didUserLocation;
@end
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "SBJson.h"
#import "DPRequest.h"
#import "BusinessModel.h"
#import "UserModel.h"
#import "MapShopInfoBtn.h"


@interface NearShopMapView : UIView <MAMapViewDelegate,AMapSearchDelegate>


@property (strong,nonatomic)MAMapView *mapView;
@property (strong,nonatomic)AMapSearchAPI *mapSearch;
@property (strong,nonatomic)NSMutableArray *arrAnnotations;
@property (strong,nonatomic)NSMutableDictionary *dicShops;
@property (strong,nonatomic)UIButton *btnCurLocation;
@property (assign,nonatomic)CLLocationCoordinate2D userLocation;
@property (weak,nonatomic)id<SelectShopMapMethods> delegate;




@end
