//
//  AppDelegate.h
//  TomorrowsApp
//
//  Created by Mehmet Akif DERE on 24.01.2021.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

@interface AppDelegate : FlutterAppDelegate <UIApplicationDelegate, FlutterAppLifeCycleProvider>

@property (nonatomic,strong) FlutterEngine *flutterEngine;

@end


