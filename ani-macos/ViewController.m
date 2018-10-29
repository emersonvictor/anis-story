//
//  ViewController.m
//  mc3-macos
//
//  Created by André Carneiro on 12/09/18.
//  Copyright © 2018 André Carneiro. All rights reserved.
//

#import "ViewController.h"
#import "GameLevel.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
    
    // including entities and graphs.
    GKScene *scene = [GKScene sceneWithFileNamed: @"GameLevel"];
    _ctrl = [GameController new];
    
    // Get the SKScene from the loaded GKScene
    GameLevel *sceneNode = (GameLevel *)scene.rootNode;
    
    sceneNode.delegate = _ctrl;
    // Copy gameplay related content over to the scene
    sceneNode.entities = [scene.entities mutableCopy];
    sceneNode.graphs = [scene.graphs mutableCopy];
    
    // Set the scale mode to scale to fit the window
    sceneNode.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene
    [self.skView presentScene:sceneNode];
    
    self.skView.showsFPS = FALSE;
    self.skView.showsNodeCount = FALSE;
    self.skView.showsPhysics = FALSE;
}

@end
