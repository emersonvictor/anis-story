//
//  GameState.m
//  mc3
//
//  Created by André Carneiro on 19/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameState.h"

@implementation GameState

- (instancetype) initWithNode: (StatefulNode*) node {
    self = [super init];
    self.node = node;
    
    return self;
}

@end
