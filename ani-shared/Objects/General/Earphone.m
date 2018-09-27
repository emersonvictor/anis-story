//
//  Earphone.m
//  ani
//
//  Created by Gabriel D'Luca on 27/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "Earphone.h"

@implementation Earphone

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super initWithCoder:aDecoder];
}

- (void) runInteraction:(Player*)withPlayer {
    NSLog(@"INTERAÇÃO DO FONE DE OUVIDO");
    self.hasPerformedAction = TRUE;
}

@end
