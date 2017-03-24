//
//  TActionInstantStopSound.m
//  TataViewer
//
//  Created by Albert Li on 10/16/14.
//  Copyright (c) 2014 Tataland. All rights reserved.
//

#import "TActionInstantStopSound.h"
#import "SMXMLDocument.h"
#import "TUtil.h"

@implementation TActionInstantStopSound

- (id)init {
    if (self = [super init]) {
        self.name = @"Stop Sound";
        self.icon = [UIImage imageNamed:@"icon_action_stopsound"];
        
        self.sound = @"";
    }
    
    return self;
}

- (void)clone:(TAction *)target {
    [super clone:target];
    
    TActionInstantStopSound* targetAction = (TActionInstantStopSound*)target;
    targetAction.sound = self.sound;
}

- (BOOL)parseXml:(SMXMLElement *)xml {
    if (xml == nil || ![xml.name isEqualToString:@"ActionInstantStopSound"])
        return NO;
    
    if (![super parseXml:xml])
        return NO;
    
    @try {
        self.sound = [TUtil parseStringXElement:[xml childNamed:@"Sound"] default:@""];
        return YES;
    } @catch (NSException* e) {
        NSLog(@"Error: %@", e);
        return NO;
    }
}

- (SMXMLElement*)toXml {
    NOT_IMPLEMENTED_METHOD
}

- (BOOL)isUsingSound:(NSString *)sound {
    return [self.sound isEqualToString:sound];
}

#pragma mark - Launch Methods

- (void)reset:(long long)time {
    [super reset:time];
}

- (BOOL)step:(id<TTataDelegate>)delegate time:(long long)time {
    
    [delegate stopEffect:self.sound];
    
    return [super step:delegate time:time];
}

@end
