//
//  ViewController.h
//  Histogram
//
//  Created by Hadley on 18/10/12.
//  Copyright (c) 2012 Hadley. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClsDraw.h"
#import "ClsDrawPoint.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController
{
    NSMutableArray *arrAllPoints;

    IBOutlet ClsDraw *redGraphView;
    IBOutlet ClsDraw *blueGraphView;
    IBOutlet ClsDraw *greenGraphView;

}


@end
