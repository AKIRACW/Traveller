//
//  BussinessCollectionManager.m
//  Traveller
//
//  Created by TY on 14-3-26.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import "BussinessCollectionManager.h"

@implementation BussinessCollectionManager
static BussinessCollectionManager *bussinessCollectionManager;

+ (id)sharedBussinessCollectionManager{
    if (!bussinessCollectionManager) {
        bussinessCollectionManager = [[BussinessCollectionManager alloc] init];
        bussinessCollectionManager.arrBussiness = [[NSMutableArray alloc] init];
    }
    return bussinessCollectionManager;
}

@end
