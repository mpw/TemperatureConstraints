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
    [[self methodServer] setupMethodServer];
    NSLog(@"interpreter: %@ solver: %@",[self interpreter],[[self interpreter] solver]);
    [[self interpreter] bindValue:self toVariableNamed:@"delegate"];
    [[self interpreter] evaluateScriptString:@"scheme:ivar := ref:var:delegate asScheme."];
    NSLog(@"will setupDeltablueConstraints");
    NSLog(@"method: %@",[[[self interpreter] methodForClass:[self className] name:@"setupDeltablueConstraints"] script]);
    
    [self methodsDefined];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(methodsDefined) name:@"methodsDefined" object:nil];
}


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

-(void)methodsDefined
{
    [self setSolver:[NSClassFromString(@"DBSolver") solver]];
    [[self interpreter] setSolver:[self solver]];
    [self setupDeltablueConstraints];
}

-(id)isValidPassword:password withRepeat:repeatPassword
{
    id enabled=@([password isEqual:repeatPassword] && [password length] > 4);
    NSLog(@"password: %@ repeatPassword: %@ enabled: %@",password,repeatPassword,enabled);
    return enabled;
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

