//
//  HHDragView.m
//  HHDragScrollView
//
//  Created by Mac on 2018/5/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHDragView.h"


@interface HHDragView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, copy) NSArray *cells;
@property (nonatomic, assign) CGFloat sizeScall;
@property (nonatomic, assign) BOOL left;
@end

@implementation HHDragView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.cells = @[@1, @2, @3,@1, @2, @3,@1, @2, @3,@1];
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(self.frame)-30,200)];
        self.scrollView.contentSize = CGSizeMake((CGRectGetWidth(self.frame) -30)* self.cells.count, 40);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.clipsToBounds = NO;
        [self addSubview:self.scrollView];
        
        _sizeScall = 0.8;
        
        for (int i = 0; i < self.cells.count; i++) {
            CGFloat width = CGRectGetWidth(self.frame) - 40;
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10+i * (width + 10), 0,width, 200)];
            UIView *redView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0,width , 200)];
            //        redView.backgroundColor = [UIColor greenColor];
            redView.tag = 100+i;
            [view addSubview:redView];
            view.backgroundColor = [UIColor redColor];
            view.tag = i + 10;
            [self.scrollView addSubview:view];
            if (i == 0) {
                CGRect rect = redView.frame;
                rect.origin.x = 15;
                rect.size.width = width - 15;
                redView.frame = rect;
            }
            if (i > 0) {
                view.transform = CGAffineTransformMakeScale(1, _sizeScall);
                
                CGRect frame = view.frame;
                frame.origin.y = 0;
                view.frame = frame;
            }
        }
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > 9) return;
    
    // 获得需要操作的左边label
    NSInteger leftIndex = scale;
    
    // 获得需要操作的右边label
    NSInteger rightIndex = leftIndex + 1;
    
    // 右边比例
    CGFloat rightScale = scale - leftIndex;
    // 左边比例
    CGFloat leftScale = 1 - rightScale;
    
    
    CGFloat transScale = (1- _sizeScall);
    
    CGFloat leftTransScale  = leftScale * transScale;
    CGFloat rightTransScale = rightScale * transScale;
    
    
    UIView *view1 = (UIView *)[self viewWithTag:leftIndex + 10];
    UIView *view2 = (UIView *)[self viewWithTag:rightIndex + 10];
    
    
    
    view1.transform = CGAffineTransformMakeScale(1, _sizeScall + leftTransScale);
    view2.transform = CGAffineTransformMakeScale(1, _sizeScall + rightTransScale);
    NSLog(@"%f--%ld---%f",_sizeScall + leftTransScale,(long)leftIndex,_sizeScall + rightTransScale);
    
    CGRect frame1 = view1.frame;
    CGRect frame2 = view2.frame;
    
    
    
    UIView *subview1 = (UIView *)[self viewWithTag:leftIndex + 100];
    UIView *subview2 = (UIView *)[self viewWithTag:rightIndex + 100];
    
    CGRect frame3 = subview1.frame;
    CGRect frame4 = subview2.frame;
    
    frame1.origin.y = 0;
    frame2.origin.y = 0;
    
    
    if (_sizeScall + leftTransScale == 1 ) {
        frame3.origin.x = 15;
        frame3.size.width = CGRectGetWidth(self.frame) - 40-15;
        frame4.origin.x = 0;
        frame4.size.width = CGRectGetWidth(self.frame) - 40;
    }else {
        frame3.origin.x = 0;
        frame3.size.width = CGRectGetWidth(self.frame) - 40;
        frame4.origin.x = 0;
        frame4.size.width = CGRectGetWidth(self.frame) - 40;
    }
    view1.frame = frame1;
    view2.frame = frame2;
    subview1.frame = frame3;
    subview2.frame = frame4;
    
}


- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if(velocity.x>0){
        //右滑
        NSLog(@"右滑");
        _left = NO;
    }else{
        //左滑
        NSLog(@"左滑");
        _left = YES;
    }
}



- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event ];
    if (hitView == self)
    {
        return self.scrollView;
    }
    else
    {
        return hitView;
    }
    
}



@end
