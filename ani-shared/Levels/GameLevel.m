//
//  GameLevel.m
//  mc3
//
//  Created by André Carneiro on 10/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "GameLevel.h"

@implementation GameLevel {
    NSTimeInterval _lastUpdateTime;
}

// MARK: - Initializers and rendering
- (void)sceneDidLoad {

    self.physicsWorld.contactDelegate = self;
    self.physicsWorld.gravity = CGVectorMake(0.0, -5.0);
    
    
    // MARK: Looking for the sound file URL
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"raindrops" ofType:@"m4a"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    NSError *error;
    
    // MARK: Configuring the audio player
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:&error];
    self.audioPlayer.numberOfLoops = -1;
    self.audioPlayer.volume = 0.04;
    
    [self.audioPlayer play];
    
    // MARK: Playing walking sound in the background thread
//    qos_class_t identifier = QOS_CLASS_BACKGROUND;
//    dispatch_queue_global_t backgroundQueue = dispatch_get_global_queue(identifier, 0);
//    dispatch_async(backgroundQueue, ^{
//        [raindrops play];
//    });


//    self.audioNode = [[SKAudioNode alloc] initWithFileNamed:@"raindrops.m4a"];
//    [self.audioNode setPosition:CGPointMake(396.0, 104.0)];
//    [self.audioNode runAction:[SKAction changeVolumeTo:0.02 duration:0]];
//    [self.audioNode setPositional:TRUE];
//    [self addChild:self.audioNode];


    // Physics body
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect: CGRectMake(-self.size.width/2, -self.size.height/2, self.size.width, self.size.height)];
    self.physicsBody.categoryBitMask = 0b11;
    self.physicsBody.collisionBitMask = 0b1;
    
}


- (void)didMoveToView:(SKView *)view {
    [self.delegate sceneDidLoadFor:self];
}

-(void)update:(CFTimeInterval)currentTime {

    // Initialize _lastUpdateTime if it has not already been
    if (_lastUpdateTime == 0) {
        _lastUpdateTime = currentTime;
    }
    
    // Calculate time since last update
    CGFloat delta = currentTime - _lastUpdateTime;
    
    // Update entities
    for (GKEntity *entity in self.entities) {
        [entity updateWithDeltaTime:delta];
    }
    _lastUpdateTime = currentTime;
}

@end
