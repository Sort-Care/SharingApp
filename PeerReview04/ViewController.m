//
//  ViewController.m
//  PeerReview04
//
//  Created by 嵇昊雨 on 3/27/16.
//  Copyright © 2016 嵇昊雨. All rights reserved.
//

#import "ViewController.h"
#import "DistanceGetter/DGDistanceRequest.h"

@interface ViewController ()

@property (nonatomic) DGDistanceRequest *req;

@property (weak, nonatomic) IBOutlet UITextField *startLocation;
@property (weak, nonatomic) IBOutlet UITextField *endLocationA;
@property (weak, nonatomic) IBOutlet UITextField *endLocationB;
@property (weak, nonatomic) IBOutlet UITextField *endLocationC;

@property (weak, nonatomic) IBOutlet UILabel *distanceA;
@property (weak, nonatomic) IBOutlet UILabel *distanceB;
@property (weak, nonatomic) IBOutlet UILabel *distanceC;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitSegment;

@end

@implementation ViewController

- (IBAction)calculateDistance:(id)sender {
    self.updateButton.enabled = false;
    
    self.req = [DGDistanceRequest alloc];
    
    NSString *start = self.startLocation.text;
    NSString *destA = self.endLocationA.text;
    NSString *destB = self.endLocationB.text;
    NSString *destC = self.endLocationC.text;
NSLog(@"%@  %@ :", start, destA);
    NSArray *dests = @[destA, destB, destC];
    
    self.req = [self.req initWithLocationDescriptions:dests sourceDescription:start];
    
    __weak ViewController *weakSelf = self;
    
    self.req.callback = ^void (NSArray *responses){
        ViewController *strongSelf = weakSelf;
        if(!strongSelf) return;
 
        NSNull *badResult = [NSNull null];
        
        //A destination
        if(responses[0] != badResult){
            double num ;
            if(strongSelf.unitSegment.selectedSegmentIndex == 0){//metres
                
                num = [responses[0] floatValue];
                NSString *x = [NSString stringWithFormat:@"%.2f metres", num];
                strongSelf.distanceA.text = x;
                
            }else if(strongSelf.unitSegment.selectedSegmentIndex == 1){//kilometres
                
                num = ([responses[0] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongSelf.distanceA.text = x;
                
            }else{//miles
                
                num = ([responses[0] floatValue]/1000.0) * 0.621;
                NSString *x = [NSString stringWithFormat:@"%.2f miles", num];
                strongSelf.distanceA.text = x;
                
            }
            
        }else{
            strongSelf.distanceA.text = @"Error";
        }
        
        
        //B destination
        if(responses[1] != badResult){
            double num ;
            if(strongSelf.unitSegment.selectedSegmentIndex == 0){//metres
                
                num = [responses[1] floatValue];
                NSString *x = [NSString stringWithFormat:@"%.2f metres", num];
                strongSelf.distanceB.text = x;
                
            }else if(strongSelf.unitSegment.selectedSegmentIndex == 1){//kilometres
                
                num = ([responses[1] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongSelf.distanceB.text = x;
                
            }else{//miles
                
                num = ([responses[1] floatValue]/1000.0) * 0.621;
                NSString *x = [NSString stringWithFormat:@"%.2f miles", num];
                strongSelf.distanceB.text = x;
                
            }
            
        }else{
            strongSelf.distanceB.text = @"Error";
        }
        
        
        //C destination
        if(responses[2] != badResult){
            double num ;
            if(strongSelf.unitSegment.selectedSegmentIndex == 0){//metres
                
                num = [responses[2] floatValue];
                NSString *x = [NSString stringWithFormat:@"%.2f metres", num];
                strongSelf.distanceC.text = x;
                
            }else if(strongSelf.unitSegment.selectedSegmentIndex == 1){//kilometres
                
                num = ([responses[2] floatValue]/1000.0);
                NSString *x = [NSString stringWithFormat:@"%.2f km", num];
                strongSelf.distanceC.text = x;
                
            }else{//miles
                
                num = ([responses[2] floatValue]/1000.0) * 0.621;
                NSString *x = [NSString stringWithFormat:@"%.2f miles", num];
                strongSelf.distanceC.text = x;
                
            }
            
        }else{
            strongSelf.distanceC.text = @"Error";
        }
        
        
        strongSelf.req = nil;
        strongSelf .updateButton.enabled = true;
        
 
    };
    
    
    [self.req start];

    
}

@end
