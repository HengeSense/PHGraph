//
//  AppController.m
//  GraphTest
//
//  Created by Pierre-Henri Jondot on 05/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

int param(double t, double *x, double *y)
{
	if (t==0) return 1;
	
	*x = t*t+2/t;
	*y = t*t+1/(t*t);
	return 0;
}

double parabole(double x, int *flag)
{
	*flag = 0;
	return x*x/4;
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
	xaxis = [[PHxAxis alloc] init];
	[xaxis setMinimum:-8.6 maximum:8.6];
	
	yaxis = [[PHyAxis alloc] init];
	[yaxis setMinimum:-2.3 maximum:10.6];
	
	[graphView addPHxAxis:xaxis];
	[graphView addPHyAxis:yaxis];
	[graphView setMouseEventsMode:PHCompositeZoomAndDrag];

	PHParametricCurve* curve = [[PHParametricCurve alloc] 
		initWithXAxis:xaxis yAxis:yaxis function:param
		tmin:-10 tmax:10 ];
	[curve setColor:[NSColor redColor]];
	[curve setTmin:-5 tmax:5];
	
	PHFunctionGraph* paraboleAsymptote = [[PHFunctionGraph alloc]
		initWithXAxis:xaxis yAxis:yaxis function:parabole];
	
	[paraboleAsymptote setColor:[NSColor blackColor]];
	[paraboleAsymptote setWidth:0.5];
	
	PHLineWithCartesianEquation* line = [[PHLineWithCartesianEquation alloc]
		initWithXAxis:xaxis yAxis:yaxis a:1 b:-1 c:0];
	[line setColor:[NSColor greenColor]];
	[line setWidth:0.5];
		
	PHAxisSystem* systemAxis = [[PHAxisSystem alloc]
		initWithXAxis:xaxis yAxis:yaxis];
	
	[graphView addPHGraphObject:curve];
	[graphView addPHGraphObject:paraboleAsymptote];
	[graphView addPHGraphObject:line];
	[graphView addPHGraphObject:systemAxis];
	[graphView setDelegate:self];

}
@end
