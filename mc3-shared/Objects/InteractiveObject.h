//
//  InteractiveObject.h
//  mc3
//
//  Created by Gabriel D'Luca on 22/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Player.h"

@interface InteractiveObject : SKSpriteNode

@property (nonatomic) BOOL hasPerformedAction;

- (void) runInteraction:(Player*) withPlayer;
@end
