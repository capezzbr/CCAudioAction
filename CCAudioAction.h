//
//  MyAudioAction.h
//
//  Created by Bruno Capezzali on 23/02/12.
//  Copyright 2012 Bruno Capezzali. All rights reserved.
//

#import "CCActionInterval.h"
#import "SimpleAudioEngine.h"
#import "CDXPropertyModifierAction.h"

@interface CCAudioPlaySound : CCActionInstant <NSCopying> {
    NSString *_soundName;
    
    Float32 _pitch;
    Float32 _pan;
    Float32 _gain;
}

+(id)actionWithSoundName:(NSString *)soundName;
+(id)actionWithSoundName:(NSString *)soundName pitch:(Float32)pitch pan:(Float32)pan gain:(Float32)gain;
-(id)initWithSoundName:(NSString *)soundName pitch:(Float32)pitch pan:(Float32)pan gain:(Float32)gain;

@end

@interface CCAudioPlayBackground : CCActionInstant <NSCopying> {
    NSString *_backgroundName;
}

+(id)actionWithBackgroundName:(NSString *)backName;
-(id)initWithBackgroundName:(NSString *)backName;

@end

@interface CCAudioFadeBackgroundTo : CCActionInterval <NSCopying> {
	float _dstVolume;
    BOOL _stop;
    
	CDPropertyModifier *_modifier;
	float _lastSetValue;
}

+(id)actionWithDuration:(ccTime)duration volume:(float)volume stop:(BOOL)stop;
-(id)initWithDuration:(ccTime)duration volume:(float)volume stop:(BOOL)stop;

@end

