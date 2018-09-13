//
//  GameController.h
//  mc3
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <GameplayKit/GameplayKit.h>
#import <SpriteKit/SpriteKit.h>
#import "LevelDelegate.h"
#import "InputHandler.h"

@interface GameController: NSObject <LevelDelegate>

@end
