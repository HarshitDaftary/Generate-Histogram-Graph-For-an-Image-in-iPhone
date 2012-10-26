//
//  ViewController.m
//  Histogram
//
//  Created by Hadley on 18/10/12.
//  Copyright (c) 2012 Hadley. All rights reserved.
//

#import "ViewController.h"
#define scale 100

float fltR[255],fltG[255],fltB[255];


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    arrAllPoints  = [[NSMutableArray alloc] init];
    arrGreenPoints = [[NSMutableArray alloc] init];
    arrBluePoints  = [[NSMutableArray alloc] init];
    
    NSLog(@"Reading....");
    
    [self readImage:[UIImage imageNamed:@"yamaha.jpg"]];    
}

-(void)readImage:(UIImage*)image
{
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    for (int yy=0;yy<height; yy++)
    {
        for (int xx=0; xx<width; xx++)
        {
            // Now your rawData contains the image data in the RGBA8888 pixel format.
            int byteIndex = (bytesPerRow * yy) + xx * bytesPerPixel;
            for (int ii = 0 ; ii < 1 ; ++ii)
            {
                CGFloat red   = (rawData[byteIndex]     * 1.0) ;
                CGFloat green = (rawData[byteIndex + 1] * 1.0) ;
                CGFloat blue  = (rawData[byteIndex + 2] * 1.0) ;
                // CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
                byteIndex += 4;
                
                // TYPE CASTING ABOVE FLOAT VALUES TO THAT THEY CAN BE MATCHED WITH ARRAY'S INDEX.
                
                int redValue = (int)red;
                int greenValue = (int)green;
                int blueValue = (int)blue;
                
                
                // THESE COUNTERS COUNT " TOTAL NUMBER OF PIXELS " FOR THAT  Red , Green or Blue Value IN ENTIRE IMAGE.
                
                fltR[redValue]++;
                fltG[greenValue]++;
                fltB[blueValue]++;                
            }
        }
    }
    [self makeArrays];
    free(rawData);
}

-(void)makeArrays
{
    float max=0;
    int maxR=0;
    int maxG=0;
    int maxB=0;
    
    
    
    // PERFORMING SUMMESION OF ALL RED , GREEN AND BLUE VLAUES GRADUALLY TO TAKE AVERAGE OF THEM    
    for (int i=0; i<255; i++)
    {
        maxR += fltR[i];
        maxG += fltG[i];
        maxB += fltB[i];
    }


    // CALCULATING AVERAGE OF ALL red, green and blue values.    
    maxR = maxR/255;
    maxG = maxG/255;
    maxB = maxB/255;
    
    
    // As  I AM GENERATING 3 GRAPHS , ITS COMPULSARY TO KEEP THEM ON SCREEN SO TAKING THEIR AVERAGE.
    max = (maxR+maxG+maxB)/3;
    
    // DEVIDED BY 8 TO GET GRAPH OF THE SAME SIZE AS ITS IN PREVIEW
    max = max*8;
        
    for (int i=0; i<255; i++)
    {
        ClsDrawPoint *objPoint = [[ClsDrawPoint alloc] init];
        objPoint.x = i;
        objPoint.y = fltR[i]*scale/max;
        [arrAllPoints addObject:objPoint];
        [objPoint release];
    }    
    
    redGraphView.arrRedPoints = arrAllPoints;
    redGraphView.graphColor = [UIColor redColor];
    [redGraphView drawGraphForArray:arrAllPoints];       /* redGraphView is an object of ClsDraw (custom class of UIView) and this call drws graph from the points of arrAllPoints */
    [arrAllPoints release];
    
    arrAllPoints = [[NSMutableArray alloc] init];
      
    for (int i=0; i<255; i++)
    {
        ClsDrawPoint *objPoint = [[ClsDrawPoint alloc] init];
        objPoint.x = i;
        objPoint.y = fltG[i]*scale/max;
        [arrAllPoints addObject:objPoint];
        [objPoint release];
    }
        
    greenGraphView.arrRedPoints = arrAllPoints;
    greenGraphView.graphColor = [UIColor greenColor];
   [greenGraphView drawGraphForArray:arrAllPoints];         /* greenGraphView is an object of ClsDraw (custom class of UIView) and this call drws graph from the points of arrAllPoints */
    [arrAllPoints release];
    
    arrAllPoints = [[NSMutableArray alloc] init];
     
    for (int i=0; i<255; i++)
    {
        ClsDrawPoint *objPoint = [[ClsDrawPoint alloc] init];
        objPoint.x = i;
        objPoint.y = fltB[i]*scale/max;
        [arrAllPoints addObject:objPoint];
        [objPoint release];
    }        
    blueGraphView.arrRedPoints = arrAllPoints;
    blueGraphView.graphColor = [UIColor blueColor];
    [blueGraphView drawGraphForArray:arrAllPoints];         /* blueGraphView is an object of ClsDraw (custom class of UIView) and this call drws graph from the points of arrAllPoints */
    [arrAllPoints release];
   

    // THE COORDINATE SYSTEM OF IOS IS TOTALLY OPPOSITE TO THAT OF THE MAC'S SO ROTATED IT WITH REFERENCE TO X - axis.    
    blueGraphView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0,0.0, 0.0);
    redGraphView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0,0.0, 0.0);
    greenGraphView.layer.transform = CATransform3DMakeRotation(M_PI, 1.0,0.0, 0.0);
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (UIInterfaceOrientationPortrait == toInterfaceOrientation);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
