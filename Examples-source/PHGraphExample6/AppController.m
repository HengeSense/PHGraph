//
//  AppController.m
//  GraphTest
//
//  Created by Pierre-Henri Jondot on 05/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

int vectorFieldFunction(double x, double y, double *vectX, double *vectY)
{
	*vectX = y;
	*vectY = -x;
	return 0;
}

void colorScheme(double x,double y, float *Red, float *Green, float *Blue, float *Alpha)
{
	*Red = x;
	*Green = y;
	*Blue = 0;
	*Alpha = 1;
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
	
	//xData = [NSMutableData dataWithCapacity:10000*sizeof(double)];
	//yData = [NSMutableData dataWithCapacity:10000*sizeof(double)];
	
	xData[0]=0.1;
	yData[0]=0.1;
	int i;
	double h = 0.02;
	for (i=1; i<10000; i++)
	{
		xData[i]=xData[i-1]+h*yData[i-1];
		yData[i]=yData[i-1]-h*xData[i-1];
	}
	
	axisSystem = [[PHAxisSystem alloc] initWithXAxis:xaxis yAxis:yaxis];
	
	vectorField = [[PHVectorField alloc] initWithXAxis:xaxis
		yAxis:yaxis function: &vectorFieldFunction];
	[vectorField setColorFunction:colorScheme];
		
	forwardEuler = [[PHCurve alloc] initWithXData:xData yData:yData 
		numberOfPoints:10000 xAxis:xaxis yAxis:yaxis];
		
	[forwardEuler setColor:[NSColor blueColor]];
		
	[vectorField setXGrid:20 yGrid:20];
	[graphView addPHGraphObject:forwardEuler];
	[graphView addPHGraphObject:vectorField];
	[graphView addPHGraphObject:axisSystem];
	
	[graphView setDelegate:self];

}
@end
