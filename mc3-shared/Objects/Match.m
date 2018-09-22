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
    NSLog(@"INTERAÇÃO DO PALITO DE FÓSFORO");
    self.hasPerformedAction = TRUE;
}

@end
