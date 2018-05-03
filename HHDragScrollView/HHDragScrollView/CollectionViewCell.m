//
//  CollectionViewCell.m
//  collection
//
//  Created by Mac on 2018/5/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()

@end

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHeight:(CGFloat)height
{
    self.constraintBottom.constant = height;
}

@end
