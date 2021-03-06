CCAudioAction
==================

Wrapper for SimpleAudioEngine written for Cocos2d-iPhone 2.x

Using SimpleAudioEngine in cocos2d is awesome but it's difficult to integrate inside out CCActions.
CCAudioAction easily allow a developer to insert SimpleAudioEngine features inside CCActions ( CCSequence, CCSpawn, ... )

Features
---------
- **CCAudioPlayBackground**: Play background music.
- **CCAudioFadeBackgroundTo**: Allow the background music to fadeIn / fadeOut.
- **CCAudioPlaySound**: Play a sound with some parameters (pitch, pan, gain).

Example of use
---------
```objective-c
[image runAction:
 [CCSequence actions:
  [CCAudioPlaySound actionWithSoundName:@"swosh.wav"], // CCAudioAction
  [CCEaseExponentialOut actionWithAction:[CCMoveBy actionWithDuration:0.4f position:ccp(moveHoriz, 0.0f)]],
  [CCDelayTime actionWithDuration:1.2f],
  [CCAudioPlaySound actionWithSoundName:@"swosh.wav"], // CCAudioAction
  [CCEaseExponentialIn actionWithAction:[CCMoveBy actionWithDuration:0.4f position:ccp(moveHoriz, 0.0f)]],
  [CCCallBlockN actionWithBlock:^(CCNode *n) { [n removeFromParentAndCleanup:YES]; }],
  nil]];
```

License 
---------
CCAudioAction is available under the MIT license. See the LICENSE file for more info.

**Follow me on twitter [@capezzbr](http://www.twitter.com/capezzbr)**