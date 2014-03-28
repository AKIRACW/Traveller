//
//  BussinessCollectionManager.h
//  Traveller
//
//  Created by TY on 14-3-26.
//  Copyright (c) 2014年 NewWorld. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusinessModel.h"
@interface BussinessCollectionManager : NSObject
@property(nonatomic,strong)NSMutableArray *arrBussiness;

+ (id)sharedBussinessCollectionManager;

@end
