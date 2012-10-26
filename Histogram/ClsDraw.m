//
//  ClsDraw.m
//  GraphDrawingOperations
//
//  Created by hadley on 10/01/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ClsDraw.h"


@implementation ClsDraw
@synthesize arrRedPoints,arrGreenPoints,arrBluePoints,graphColor,arrPoints;

-(id)init
{
	[self setBackgroundColor:[UIColor blueColor]];
	
	return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	NSLog(@"Touched");
    //boolCancelDrawing = YES;
//	[self drawGraphForArray:arrPoints];
//	[self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{


}

-(void)drawGraphForArray:(NSMutableArray*)parrPoints
{
  //  boolCancelDrawing = YES;
    arrPoints = parrPoints;
	
	NSInteger counter=0;
	
	for (ClsDrawPoint *objPoint in arrPoints) 
	{
		objPoint.x = counter;	
		counter++;
	}	
	[self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect 
{	
				
		CGContextRef ctx = UIGraphicsGetCurrentContext();
        
		if ([arrPoints count] > 0) 
		{
			CGContextSetLineWidth(ctx, 1);
            CGContextSetStrokeColorWithColor(ctx, graphColor.CGColor);
            CGContextSetAlpha(ctx, 0.8);
			ClsDrawPoint *objPoint;
            CGContextBeginPath(ctx);


			for (int i = 0 ; i < [arrPoints count] ; i++)
			{
				objPoint = [arrPoints objectAtIndex:i];			
                CGContextMoveToPoint(ctx, objPoint.x,0);
               // CGContextMoveToPoint(ctx, objPoint.x,0);
				CGContextSetLineCap(ctx, kCGLineCapRound);
				CGContextSetLineJoin(ctx, kCGLineJoinRound);
                CGContextAddLineToPoint(ctx, objPoint.x,objPoint.y);
				CGContextMoveToPoint(ctx, objPoint.x,objPoint.y);
				CGContextStrokePath(ctx);
			}				
		}
    
}


@end
