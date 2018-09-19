//
//  PlayerStates.h
//  mc3
//
//  Created by André Carneiro on 18/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameplayKit/GameplayKit.h>
#import "GameState.h"

NS_ASSUME_NONNULL_BEGIN

@interface IdleState : GameState

@end

@interface WalkingState : GameState

@end

@interface JumpingState : GameState

@end

@interface RunningState : GameState

@end

NS_ASSUME_NONNULL_END
