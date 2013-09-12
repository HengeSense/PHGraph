//
//  AppController.m
//  GraphTest
//
//  Created by Pierre-Henri Jondot on 05/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

double function(double x, int *flag)
{
	if (x!=0)
	{
		*flag=0;
		return x*x*sin(1/x);
	} else 
	{
		*flag=1;
		return 0;
	}
}

double derivate(double x,int *flag)
{
	if (x!=0)
	{
		*flag = 0;
		return cos(1/x)+2*x*sin(1/x);
	} else
	{
		*flag = 1;
		return 0;
	}
}

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
	xaxis=[[PHxAxis alloc] initWithStyle: 0];
	[xaxis setMinimum:-1.5 maximum:1.5];
	yaxis=[[PHyAxis alloc] initWithStyle: 0];
	[yaxis setMinimum:-1.2 maximum:1.2];
	[graphView addPHxAxis:xaxis];
	[graphView addPHyAxis:yaxis];
	[graphView setMouseEventsMode:PHCompositeZoomAndDrag];

	line = [[PHLineWithCartesianEquation alloc] initWithXAxis:xaxis yAxis:yaxis	a:1 b:1 c:1 ];
	[line setWidth:0.5];
	[line setStyle:PHStraight];
	[line setColor:[NSColor greenColor]];
	PHAxisSystem* axisSystem = [[PHAxisSystem alloc] initWithXAxis:xaxis yAxis:yaxis];
	[graphView addPHGraphObject:line];
	fonctionGraph1 = [[PHFunctionGraph alloc] initWithXAxis:xaxis yAxis:yaxis
			function:derivate];
	[fonctionGraph1 setColor:[NSColor blueColor]];
	[fonctionGraph1 setWidth:0.5];
	fonctionGraph2 = [[PHFunctionGraph alloc] initWithXAxis:xaxis yAxis:yaxis 
			function:function];
	[fonctionGraph2 setColor:[NSColor redColor]];
	[fonctionGraph2 setWidth:1];
	[graphView addPHGraphObject:fonctionGraph1];
	[graphView addPHGraphObject:fonctionGraph2];
	[graphView addPHGraphObject:axisSystem];
	
	[graphView setDelegate:self];

}
@end
