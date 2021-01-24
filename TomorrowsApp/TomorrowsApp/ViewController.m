//
//  ViewController.m
//  TomorrowsApp
//
//  Created by Mehmet Akif DERE on 24.01.2021.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import <Flutter/Flutter.h>
#import <Flutter/FlutterChannels.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (IBAction)toDartSide:(UIButton *)sender {
    
    
    FlutterEngine *flutterEngine = ((AppDelegate *)UIApplication.sharedApplication.delegate).flutterEngine;
    
    
    [flutterEngine run];
    
    FlutterViewController *flutterViewController =
    [[FlutterViewController alloc] initWithEngine:flutterEngine
                                          nibName:nil bundle:nil];
    
    
    
    
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"cxl" binaryMessenger:flutterViewController];
    
    //method
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        
        NSLog(@"flutter gives me：\nmethod=%@ \narguments = %@",call.method,call.arguments);
        
        if ([call.method isEqualToString:@"initialMethod"]) {
            result(self.yourMessage.text);
        } else if ([call.method isEqualToString:@"toNativeSomething"]) {
            
            // Call back to flutter
            if (result) {
                result(@1);
            }
        } else if ([call.method isEqualToString:@"toNativePush"]) {
            
            NSLog(@"%@",call.arguments);
            NSLog(@"push===push===push");
            result(@1);
        } else if ([call.method isEqualToString:@"toNativePop"]) {
            
            NSLog(@"%@",call.arguments);
            NSLog(@"pop===pop===pop");
            result(@2);
        }
    }];
    
    [self presentViewController:flutterViewController animated:YES completion:nil];
}

- (void)flutter_to_ios {
    
    //Create controller
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    //Set the routing address of the loaded controller
    [flutterViewController setInitialRoute:@"MyApp"];
    
    
    // Set channel number
    FlutterBasicMessageChannel* messageChannel = [FlutterBasicMessageChannel messageChannelWithName:@"cxl"
                                                                                    binaryMessenger:flutterViewController
                                                                                              codec:[FlutterStandardMessageCodec sharedInstance]];//消息发送代码，本文不做解释
    // Message sending code, this article will not explain
    __weak __typeof(self) weakSelf = self;
    
    
    //
    [messageChannel setMessageHandler:^(id message, FlutterReply reply) {
        // Any message on this channel pops the Flutter view.
        [[weakSelf navigationController] popViewControllerAnimated:YES];
        reply(@"");
    }];
    
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"cxl" binaryMessenger:flutterViewController];
    
    //method
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        // call.method gets the method name returned by flutter.
        //To match the multiple sending method names corresponding to channelName,
        //it is generally necessary to distinguish between call.arguments to get the parameters given by flutter,
        //(for example, the parameters needed to jump to another page ) Result is a callback to flutter,
        //the callback can only be used once
        NSLog(@"flutter gives me：\nmethod=%@ \narguments = %@",call.method,call.arguments);
        
        if ([call.method isEqualToString:@"toNativeSomething"]) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter callback" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alertView show];
            
            // Call back to flutter
            if (result) {
                result(@1000);
            }
        } else if ([call.method isEqualToString:@"toNativePush"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter callback" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alertView show];
            
            NSLog(@"push===push===push");
        } else if ([call.method isEqualToString:@"toNativePop"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter callback" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alertView show];
            
            NSLog(@"pop===pop===pop");
        }
    }];
    
    
    //   NSAssert([self navigationController], @"Must have a NaviationController");
    [[self navigationController]  pushViewController:flutterViewController animated:YES];
    
}

@end
