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
    [super runInteraction:withPlayer];
    withPlayer.mask = WhaleMask;
}

@end
