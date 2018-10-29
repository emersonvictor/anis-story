//
//  Match.m
//  mc3
//
//  Created by Gabriel D'Luca on 22/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "Match.h"

@implementation Match

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void) runInteraction:(Player*)withPlayer {
    // TO DO: Implementar interação do palito de fósforo
    [withPlayer.stateMachine enterState:GrabbingState.class];
    NSLog(@"INTERAÇÃO DO PALITO DE FÓSFORO");
    
//    withPlayer.heldItem = @"Match";
    
    self.hasPerformedAction = TRUE;
    self.position = CGPointMake(20, 15);
    self.zRotation = 180;
    self.physicsBody = nil;
    [withPlayer.stateMachine enterState:IdleState.class];
    
//    [withPlayer addChild:self];
    
    [self removeFromParent];
    [withPlayer addChild:self];
    
    
    
}

@end
