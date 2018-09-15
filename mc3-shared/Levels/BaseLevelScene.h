//
//  BaseLevelScene.h
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "LevelDelegate.h"
#import <TargetConditionals.h>

@interface BaseLevelScene : SKScene

@property (nonatomic) NSMutableArray<GKEntity *> *entities;
@property (nonatomic) NSMutableDictionary<NSString*, GKGraph *> *graphs;
@property(nonatomic, weak) id<LevelDelegate> delegate;

@end
