//
//  GRViewController.m
//  _21_1_Animation
//
//  Created by Exo-terminal on 4/15/14.
//  Copyright (c) 2014 Evgenia. All rights reserved.
//

#import "GRViewController.h"

@interface GRViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSMutableArray *views;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSMutableArray *imageViews;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSMutableArray *imageMirrorViews;


@end

@implementation GRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.views = [[NSMutableArray alloc]init];
    self.imageViews = [[NSMutableArray alloc]init];
    self.imageMirrorViews = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    BOOL interface = NO;
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        interface = YES;
    }
    
    [self coordinateViewWithBool:interface];
    [self coordinateImageViewWithBool:interface andIndex:1];
    [self colorWithArray:self.views];
    
    [self callView];
  
}

-(void) callView{
    
    BOOL rotate = arc4random() % 2;
    
    if (rotate) {
        
        [self rotateMicky];
        [self rotateViewClockWaseWithArray:self.imageViews];
        [self performSelector:@selector(rotateViewClockWaseWithArray:) withObject:self.views afterDelay:1.f];
        
    }else{
        [self removeSubviewWithTag:0];
        [self coordinateImageViewWithBool:YES andIndex:0];
        [self mirrowMicky];
        [self rotateViewClockConterWaseWithArray:self.imageMirrorViews];
        [self performSelector:@selector(rotateViewClockConterWaseWithArray:) withObject:self.views afterDelay:1.f];

}
}
-(void) rotateViewClockWaseWithArray: (NSMutableArray*)array{
    
    UIView* firstView = [array firstObject];
    UIColor* color = [UIColor redColor];
    int firstX = CGRectGetMinX(firstView.frame);
    int firstY = CGRectGetMinY(firstView.frame);
    CGRect firstRect = CGRectMake(firstX, firstY, 100, 100);
    
    for (int i = 0; i < [array count] ; i++) {
        
        UIView* view = [array objectAtIndex:i];
        CGRect rect = firstRect;
        
        UIView* view2 = [[UIView alloc]initWithFrame:firstRect];
        color = [UIColor redColor];
        
        if (!(i == ([array count]-1))){
            UIView* view2 = [array objectAtIndex:i + 1];
            rect = view2.frame;
            color = view2.backgroundColor;
        }
        
        [self moveView:view andViewAnimationOptions:rect andColor:color];
    }
    
}

-(void) rotateViewClockConterWaseWithArray: (NSMutableArray*)array{
    
    UIView* lastView = [array lastObject];
    UIColor* color = [UIColor greenColor];
    int lastX = CGRectGetMinX(lastView.frame);
    int lastY = CGRectGetMinY(lastView.frame);
    CGRect lastRect = CGRectMake(lastX, lastY, 100, 100);
    
    for (int i = ([array count]-1); i < [array count] ; i--) {
        
        UIView* view = [array objectAtIndex:i];
        CGRect rect = lastRect;
        
        UIView* view2 = [[UIView alloc]initWithFrame:lastRect];
        color = [UIColor greenColor];
        
        if (!(i == 0)){
            UIView* view2 = [array objectAtIndex:i - 1];
            rect = view2.frame;
            color = view2.backgroundColor;
        }
        
        [self moveView:view andViewAnimationOptions:rect andColor:color];
    }
}

-(void) createViewWithX:(NSInteger) x andY: (NSInteger) y  {
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
    
    view.tag = 1;
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    [self.views addObject:view];
}



-(void) moveView: (UIView*) view andViewAnimationOptions: (CGRect) rectView andColor: (UIColor*) color{
    
    UIView* view2 = [[UIView alloc]initWithFrame:rectView];
    view2.backgroundColor = color;
    
    [UIView animateWithDuration:2
                          delay:0
                        options: UIViewAnimationOptionCurveLinear | UIViewAnimationOptionRepeat
                     animations:^{
                         view.center = view2.center;
                         view.backgroundColor = view2.backgroundColor;
                     }
                     completion:^(BOOL finished) {
                     }];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    
    [self removeSubviewWithTag:1];
    self.views = nil;
    self.imageViews = nil;
    self.imageMirrorViews = nil;
    
    self.views = [[NSMutableArray alloc]init];
    self.imageViews = [[NSMutableArray alloc]init];
    self.imageMirrorViews = [[NSMutableArray alloc]init];
    
    [self coordinateViewWithBool:YES];
    [self coordinateImageViewWithBool:YES andIndex:1];
    [self colorWithArray:self.views];
    [self callView];
}

-(void) coordinateViewWithBool: (BOOL) interface{
    NSInteger x;
    NSInteger y;
    
    y = (CGRectGetMaxY(self.view.bounds) - 100);
    x = (CGRectGetMaxX(self.view.bounds) - 100);
    if (interface) {
        [self createViewWithX:0 andY:0];
        [self createViewWithX:y andY:0];
        [self createViewWithX:y andY:x];
        [self createViewWithX:0 andY:x];

     }else{
        [self createViewWithX:0 andY:0];
        [self createViewWithX:x andY:0];
        [self createViewWithX:x andY:y];
        [self createViewWithX:0 andY:y];
    }
}

-(void) coordinateImageViewWithBool: (BOOL) interface andIndex: (int) index{
    NSInteger x;
    NSInteger y;
    
    y = (CGRectGetMaxY(self.view.bounds) - 100);
    x = (CGRectGetMaxX(self.view.bounds) - 100);
    if (interface) {
        [self createViewImageWithX:0 andY:0 andIndex:index];
        [self createViewImageWithX:y andY:0 andIndex:index];
        [self createViewImageWithX:y andY:x andIndex:index];
        [self createViewImageWithX:0 andY:x andIndex:index];
    }else{
        [self createViewImageWithX:0 andY:0 andIndex:index];
        [self createViewImageWithX:x andY:0 andIndex:index];
        [self createViewImageWithX:x andY:y andIndex:index];
        [self createViewImageWithX:0 andY:y andIndex:index];
    }
}

-(void) createViewImageWithX:(NSInteger) x andY: (NSInteger) y andIndex:(int) index{
    
    NSMutableArray *array = [self createArrayWithIndex:index];
    
    UIImageView* view = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 100, 100)];
    view.tag = 2;
    view.backgroundColor = [UIColor clearColor];
    view.animationImages = array;
    view.animationDuration = 1.f;
    
    [self.view addSubview:view];
    [view startAnimating];
    
    if (index == 1) {
        [self.imageViews addObject:view];
    }else{
        [self.imageMirrorViews addObject:view];
    }
}

-(NSMutableArray*) createArrayWithIndex: (int) index{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    if (index == 1) {
        UIImage* image1 = [UIImage imageNamed:@"1.png"];
        UIImage* image2 = [UIImage imageNamed:@"2.png"];
        UIImage* image3 = [UIImage imageNamed:@"3.png"];
        UIImage* image4 = [UIImage imageNamed:@"4.png"];
        UIImage* image5 = [UIImage imageNamed:@"5.png"];
        
        [array addObject:image1];
        [array addObject:image2];
        [array addObject:image3];
        [array addObject:image4];
        [array addObject:image5];
    }else{
        UIImage* image6 = [UIImage imageNamed:@"6.png"];
        UIImage* image7 = [UIImage imageNamed:@"7.png"];
        UIImage* image8 = [UIImage imageNamed:@"8.png"];
        UIImage* image9 = [UIImage imageNamed:@"9.png"];
        UIImage* image10 = [UIImage imageNamed:@"10.png"];
        
        [array addObject:image6];
        [array addObject:image7];
        [array addObject:image8];
        [array addObject:image9];
        [array addObject:image10];
    }
    return  array;
}
-(void) removeSubviewWithTag: (int) tag{
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[UIView class]]) {
            
            if (tag == 1) {
                if (view.tag == 1 || view.tag == 2) {
                    
                    [view removeFromSuperview];
                    
                }
            }else{
                if (view.tag == 2) {
                    [view removeFromSuperview];

                }
            }
          }
    }
}


-(void) rotateMicky{
    int i = 0;
    for (UIImageView * view in self.imageViews) {
        
        if(i == 0)       view.transform = CGAffineTransformMakeRotation(M_PI);
        
        if(i == 1)       view.transform = CGAffineTransformMakeRotation(M_PI/-2);
        
        if(i == 2)       view.transform = CGAffineTransformMakeRotation(M_PI*2);
        
        if(i == 3)       view.transform = CGAffineTransformMakeRotation(M_PI/2);
        i++;
    }
}

-(void) mirrowMicky{
    int i = 0;
    for (UIImageView * view in self.imageMirrorViews) {
        
        if(i == 0)  {
            view.transform = CGAffineTransformMakeRotation(M_PI/2);
        }
        
        if(i == 1){
           view.transform = CGAffineTransformMakeRotation(M_PI);
        }
        
        if(i == 2) {
            view.transform = CGAffineTransformMakeRotation(M_PI/-2);
        }
        
        if(i == 3)  {
            view.transform = CGAffineTransformMakeRotation(M_PI*2);
        }
        i++;
    }

}

-(void) colorWithArray: (NSMutableArray*) array{
    int i = 0;
    for (UIView * view in self.views) {
        
            if(i == 0)       view.backgroundColor = [UIColor redColor];
        
            if(i == 1)       view.backgroundColor = [UIColor orangeColor];
        
            if(i == 2)       view.backgroundColor = [UIColor yellowColor];
        
            if(i == 3)       view.backgroundColor = [UIColor greenColor];
        i++;
       }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
