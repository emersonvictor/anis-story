//
//  StatefulNode.h
//  mc3
//
//  Created by André Carneiro on 19/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StatefulNode : SKSpriteNode

@property (nonatomic) GKStateMachine* stateMachine;

- (void) updateWithDeltaTime:(NSTimeInterval)delta;


@end

NS_ASSUME_NONNULL_END
