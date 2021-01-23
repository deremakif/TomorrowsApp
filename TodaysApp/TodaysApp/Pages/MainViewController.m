//
//  MainViewController.m
//  TodaysApp
//
//  Created by Mehmet Akif DERE on 23.01.2021.
//

#import "MainViewController.h"
#import <Flutter/Flutter.h>
#import <Flutter/FlutterChannels.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)ios_to_flutter{
    
    FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithProject:nil nibName:nil bundle:nil];
    flutterViewController.navigationItem.title = @"Demo";
    [flutterViewController setInitialRoute:@"MyHome"];
    // To be consistent with main.dart
    NSString *channelName = @"aaa";
    
    FlutterEventChannel *evenChannal = [FlutterEventChannel eventChannelWithName:channelName binaryMessenger:flutterViewController];
    // 代理FlutterStreamHandler
    [evenChannal setStreamHandler:self];
    
    [self.navigationController pushViewController:flutterViewController animated:YES];

    
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
            
            NSLog(@"pushing => => => => => =>");
        } else if ([call.method isEqualToString:@"toNativePop"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"flutter callback" message:[NSString stringWithFormat:@"%@",call.arguments] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alertView show];
            
            NSLog(@"popping => => => => => =>");
        }
    }];
    
    
    NSAssert([self navigationController], @"Must have a NaviationController");
    [[self navigationController]  pushViewController:flutterViewController animated:YES];
    
}


@end
