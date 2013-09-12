//
//  AppController.m
//  GraphTest
//
//  Created by Pierre-Henri Jondot on 05/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"

double amplitude(double x, int *flag)
{
	*flag=0;
	return x/sqrt(1+x*x);
}

double phase(double x,int *flag)
{
	*flag=0;
	return 90-atan(x)*180/3.141592653589323;
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
	[NSTextFieldYpos setFloatValue:[yAmplitudeAxis convertValue:position.y]];
}

-(void)mouseDraggedAtPoint:(NSPoint)position
{
	[NSTextFieldXpos setFloatValue:[xaxis convertValue:position.x]];
	[NSTextFieldYpos setFloatValue:[yAmplitudeAxis convertValue:position.y]];
}

-(void)awakeFromNib
{
	xaxis = [[PHxAxis alloc] initWithStyle: 
		 PHIsLog | PHShowGrid | PHShowGraduationAtBottom | PHShowGraduationAtTop];
	[xaxis setMinimum:-1 maximum:3];
	
	yAmplitudeAxis = [[PHyAxis alloc] initWithStyle: 
		  PHIsLog | PHShowGrid | PHShowGraduationAtLeft];
	[yAmplitudeAxis setMinimum:-3 maximum:1];
	[yAmplitudeAxis setColor:[NSColor blueColor]];
	
	yPhaseAxis = [[PHyAxis alloc] initWithStyle: PHShowGraduationAtRight];
	[yPhaseAxis setMinimum:-200 maximum:200];
	[yPhaseAxis setColor:[NSColor redColor]];
	[yPhaseAxis setMajorTickWidth:90];
	[yPhaseAxis setMinorTicksNumber:9];
	
	[graphView addPHxAxis:xaxis];
	[graphView addPHyAxis:yAmplitudeAxis];
	[graphView addPHyAxis:yPhaseAxis];
	[graphView setMouseEventsMode:PHCompositeZoomAndDrag];

	PHFunctionGraph* fonctionGraph1 = [[PHFunctionGraph alloc] 
		initWithXAxis:xaxis yAxis:yAmplitudeAxis function:amplitude];
	[fonctionGraph1 setColor:[NSColor blueColor]];
	
	PHFunctionGraph* fonctionGraph2 = [[PHFunctionGraph alloc]
		initWithXAxis:xaxis yAxis:yPhaseAxis function:phase];
	[fonctionGraph2 setColor:[NSColor redColor]];
	[graphView addPHGraphObject:fonctionGraph1];
	[graphView addPHGraphObject:fonctionGraph2];
	[graphView setDelegate:self];

}
@end
