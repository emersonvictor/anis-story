//
//  GameState.h
//  mc3
//
//  Created by André Carneiro on 19/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameplayKit/GameplayKit.h>
#import "StatefulNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameState : GKState

@property (nonatomic, weak) StatefulNode* node;

- (instancetype) initWithNode:(StatefulNode*) node;

@end

NS_ASSUME_NONNULL_END
