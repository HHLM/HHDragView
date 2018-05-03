//
//  HHCollectionView.m
//  HHDragScrollView
//
//  Created by Mac on 2018/5/3.
//  Copyright © 2018年 Mac. All rights reserved.
//

#import "HHCollectionView.h"
#import "CollectionViewCell.h"

static NSString *kCell = @"CollectionViewCell";

#define MaxWidth 300
#define MinWidth 280
#define MaxHeight 200
#define MinHeight 160
#define Screen_Width [[UIScreen mainScreen] bounds].size.width
#define Screen_Height [[UIScreen mainScreen] bounds].size.height

@interface HHCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) CGFloat sizeScale;
@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (assign, nonatomic) CGFloat contentOffsetX;  // collectionView偏移量
@end
@implementation HHCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.flowLayout.itemSize = CGSizeMake(MaxWidth, MaxHeight);
    self.contentOffsetX = self.collectionView.contentOffset.x;
}

- (void)setupUI {
    self.contentOffsetX = 0;
    
    self.cellSize = CGSizeMake(CGRectGetWidth(self.frame) - 60, 60);
    self.datas = [[NSMutableArray alloc] initWithArray:@[@0, @20, @20, @20, @20, @20]];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 200) collectionViewLayout:self.flowLayout];
    self.collectionView.showsHorizontalScrollIndicator = false;
    [self.collectionView registerNib:[UINib nibWithNibName:kCell bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:kCell];
    [self addSubview:self.collectionView];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = scrollView.contentOffset.x / scrollView.frame.size.width;
    if (scale < 0 || scale > self.datas.count) return;
}

- (int)currentIndex
{
    int index = (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;;
    return MAX(0, index);
}

- (void)scrollToIndex:(int)targetIndex
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        int index = [self currentIndex];
        [self scrollToIndex:index];
    });
}



- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.contentOffsetX = self.collectionView.contentOffset.x;
}

@end
