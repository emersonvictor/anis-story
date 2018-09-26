//
//  WhaleTotem.m
//  mc3
//
//  Created by Gabriel D'Luca on 22/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "WhaleTotem.h"
#import "Player.h"

@implementation WhaleTotem

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void) runInteraction:(Player*)withPlayer {
    if (withPlayer.mask != WhaleMask) {
        [super runInteraction:withPlayer];
        
        NSLog(@"INTERAÇÃO COM O TOTEM DA BALEIA");
        
        // MARK: - Modifying player attributes
        withPlayer.mask = WhaleMask;
        withPlayer.physicsBody.mass *= 10;
        withPlayer.speedForce /= 50.0;
        
        // TO DO: Change player's sprite image
    }
}

@end
