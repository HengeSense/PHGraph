//
//  AppController.m
//  GraphTest
//
//  Created by Pierre-Henri Jondot on 05/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

@implementation AppController
-(id)init
{
	[super init];
	return self;
}

-(IBAction)changeMode:(id)sender
{
	[graphView setMouseEventsMode:[NSMatrixChooseMode selectedRow]];
}

-(void)mouseDownAtPoint:(NSPoint)position
{
	[NSTextFieldXpos setFloatValue:[xaxis convertValue:position.x]];
	[NSTextFieldYpos setFloatValue:[yaxis convertValue:position.y]];
}

-(void)mouseDraggedAtPoint:(NSPoint)position
{
	[NSTextFieldXpos setFloatValue:[xaxis convertValue:position.x]];
	[NSTextFieldYpos setFloatValue:[yaxis convertValue:position.y]];
}

-(void)awakeFromNib
{
	xaxis=[[PHxAxis alloc] initWithStyle:PHShowGrid | PHShowGraduationAtBottom | PHShowGraduationAtTop];
	[xaxis setMinimum:-1.51 maximum:1.51];
	yaxis=[[PHyAxis alloc] initWithStyle:PHShowGrid | PHShowGraduationAtLeft | PHShowGraduationAtRight];
	[yaxis setMinimum:-1.21 maximum:1.21];
	[graphView addPHxAxis:xaxis];
	[graphView addPHyAxis:yaxis];
	[graphView setMouseEventsMode:PHCompositeZoomAndDrag];
	int i;
	xData[0]=0;
	yData[0]=0;
	xData[1]=0;
	yData[1]=0;
	for (i=2;i<1000000;i++)
	{
			xData[i] = xData[i-1] + (xData[i-1]-xData[i-2])/2+(((double)random()/RAND_MAX)-0.5)*0.01;
			yData[i] = yData[i-1] + (yData[i-1]-yData[i-2])/2+(((double)random()/RAND_MAX)-0.5)*0.01;
	}
			
	randomWalking = [[PHCurve alloc]   initWithXData:xData
		yData:yData numberOfPoints:1000000 xAxis:xaxis yAxis:yaxis ];
			
	[randomWalking setColor:[NSColor redColor]];
	[randomWalking setWidth:0.5];
	[graphView addPHGraphObject:randomWalking];
	[graphView setHasBorder:YES];
	[graphView setLeftBorder:45 rightBorder:45 bottomBorder:20 topBorder:20];
	[graphView setDelegate:self];

}
@end
