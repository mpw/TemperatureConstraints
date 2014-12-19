//
//  AppDelegate.m
//  TemperatureConstraints
//
//  Created by Marcel Weiher on 9/21/14.
//  Copyright (c) 2014 Metaobject. All rights reserved.
//

#import "AppDelegate.h"
#import <MethodServer/MethodServer.h>
#import <MPWFoundation/MPWFoundation.h>

@interface AppDelegate ()

@property (strong) IBOutlet NSWindow *window;

@end

@implementation AppDelegate


idAccessor(solver, setSolver)
objectAccessor(NSTextField, celsiusTextField, setCelsiusTextField )
objectAccessor(NSTextField, fahrenheitTextField, setFahrenheitTextField )
objectAccessor(NSTextField, kelvinTextField, setKelvinTextField )
objectAccessor(MethodServer, methodServer, setMethodServer)

-interpreter
{
    return [[self methodServer] interpreter];
}


- (void)applicationWillFinishLaunching:(NSNotification *)aNotification {
    [self setMethodServer:[[[MethodServer alloc] initWithMethodDictName:@"temperatureconstraints"] autorelease]];
    [[self methodServer] setupWithoutStarting];
    [[self interpreter] bindValue:self toVariableNamed:@"delegate"];
    [[self interpreter] evaluateScriptString:@"scheme:ivar := ref:var:delegate asScheme."];
    NSLog(@"will setupDeltablueConstraints");
    
    [self setupDeltablueConstraints];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end

@implementation NSControl(objst_observing)

-(void)objst_addObserver:anObserver forKey:aKey
{
    [NSNotificationCenter.defaultCenter addObserverForName:NSControlTextDidChangeNotification object:self queue:nil usingBlock:^(NSNotification *note) {
        [anObserver didChange];
    }];
}

@end

