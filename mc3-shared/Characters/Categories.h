//
//  Categories.m
//  mc3
//
//  Created by Gabriel D'Luca on 19/09/18.
//  Copyright © 2018 Gabriel D'Luca. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    sceneCategory = 0x1<<0,
    playerCategory = 0x1<<1,
    obstaclesCategory = 0x1<<2,
    totemCategory = 0x1<<3
} Categories;
