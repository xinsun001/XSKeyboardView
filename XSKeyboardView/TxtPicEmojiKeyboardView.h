//
//  TxtPicEmojiKeyboardView.h
//  XSKeyboardView
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TxtPicmodel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TxtPicEmojiKeyboardView : UIView<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property(nonatomic,strong)UICollectionView *mtagCollectionView;
@property (nonatomic,strong)NSMutableArray *sxArray;

@property(nonatomic,copy)void(^tagCelllock)(NSString *str);

@property (nonatomic,strong)NSMutableArray *tagChooseArr;
@property(nonatomic,strong)UIButton *btn2;

@property(nonatomic,strong)UIScrollView *chooseScrollView;

@property(nonatomic,strong)UIView *botmLine;


@property (nonatomic,strong)NSMutableArray *emojiArr;

@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,copy)void(^backButtonBlock)(void);

@property(nonatomic,strong)UILongPressGestureRecognizer *longPress;
@property(nonatomic,strong)NSTimer *timer;


-(void)btnAction:(UIButton *)btn;

@end

NS_ASSUME_NONNULL_END
