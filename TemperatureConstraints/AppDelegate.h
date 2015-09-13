//
//  AppDelegate.h
//  TemperatureConstraints
//
//  Created by Marcel Weiher on 9/21/14.
//  Copyright (c) 2014 Metaobject. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MethodServer;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSTextField *celsiusTextField;
    IBOutlet NSTextField *fahrenheitTextField;
    IBOutlet NSTextField *kelvinTextField;
    
    IBOutlet NSTextField *userNameField;
    IBOutlet NSTextField *passwordField;
    IBOutlet NSTextField *repeatPasswordField;
 
    IBOutlet NSButton    *loginButton;
    id solver;
    MethodServer         *methodServer;
    
    NSNumber  *c,*f,*k;
}


@end

