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
	xaxis=[[PHxAxis alloc] initWithStyle: PHShowGraduationAtLeft | PHShowGraduationAtRight];
	[xaxis setMinimum:-1.5 maximum:1.5];
	yaxis=[[PHyAxis alloc] initWithStyle: PHShowGraduationAtTop | PHShowGraduationAtBottom];
	[yaxis setMinimum:-0.6 maximum:0.6];
	[graphView addPHxAxis:xaxis];
	[graphView addPHyAxis:yaxis];
	[graphView setMouseEventsMode:PHCompositeZoomAndDrag];
	int i;
	double x=0; double y=0;double xp=0;
	for (i=0;i<1000;i++)
	{
		x = y+1-1.4*xp*xp;
		y = 0.3*xp;
		xp = x;
	}
	xData[0]=x;
	yData[0]=y;

	for (i=1;i<300000;i++)
	{
		xData[i]=yData[i-1]+1-1.4*xData[i-1]*xData[i-1];
		yData[i]=0.3*xData[i-1];
	}
	henon=[[PHPoints alloc] initWithXData:xData
		yData:yData numberOfPoints:300000 xAxis:xaxis yAxis:yaxis ];
			
	[henon setColor:[NSColor blueColor]];
	[henon setStyle:PHCrossplus];
	[henon setSize:0.2];
	[henon setWidth:0.2];
	[graphView addPHGraphObject:henon];
	[graphView setDelegate:self];

}
@end
