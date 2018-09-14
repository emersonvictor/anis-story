//
//  GameLevel.h
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "BaseLevelScene.h"
#import "Player.h"

@interface GameLevel : BaseLevelScene
@property (nonatomic, strong) Player *player;
@end
