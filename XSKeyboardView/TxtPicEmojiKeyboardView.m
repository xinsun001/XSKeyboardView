//
//  TxtPicEmojiKeyboardView.m
//  XSKeyboardView
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import "TxtPicEmojiKeyboardView.h"
#import "TxtpICemojiCollectionViewCell.h"

#define itemH (ViewAllWidth-30-70)/8

#define bgColor colorWithValue(245, 245, 245, 1)

@implementation TxtPicEmojiKeyboardView



-(UIScrollView *)chooseScrollView{
    if (!_chooseScrollView) {
        _chooseScrollView=[UIScrollView new];
        
    }
    return _chooseScrollView;
}


-(UIView *)botmLine{
    if (!_botmLine) {
        _botmLine=[UIView new];
        _botmLine.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    }
    return _botmLine;
}


- (UICollectionView *)mtagCollectionView{

    if (_mtagCollectionView ==nil) {

        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];

        _mtagCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _mtagCollectionView.showsVerticalScrollIndicator=NO;

        _mtagCollectionView.delegate = self;
        _mtagCollectionView.dataSource = self;
    }
    return _mtagCollectionView;
}


-(UIButton *)backButton{
    if (!_backButton) {
        _backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor=[UIColor whiteColor];
        
        __weak typeof(self)  weakSelf=self;

        UIImageView *img=[UIImageView new];
        img.image=[UIImage imageNamed:@"keyboardback"];
        [_backButton addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.backButton);
            make.height.mas_equalTo(itemH/2);
            make.width.mas_equalTo(itemH/2/5*8);
        }];
        
        _backButton.layer.cornerRadius=itemH/2;
        _backButton.layer.masksToBounds=YES;
//        _backButton.layer.shadowColor=[UIColor whiteColor].CGColor;
//        _backButton.layer.shadowOffset=CGSizeMake(-1, -1);
//        _backButton.layer.shadowOpacity=0.6;
        [_backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        //button长按事件
        self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
        self.longPress.minimumPressDuration = 0.5; //定义按的时间
        
        [_backButton addGestureRecognizer:self.longPress];
    }
    return _backButton;
}

-(void)backButtonAction{
    if (self.backButtonBlock) {
        self.backButtonBlock();
    }
}


-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
   
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        
        [self.timer invalidate];
        self.timer=nil;
    }else{
        [self.timer fire];
    }
    
}


-(NSTimer *)timer{
    if (_timer==nil) {
        _timer=[NSTimer new];
        //    NSTimeInterval:多长多件操作一次
        //    target :操作谁
        //    selector : 要操作的方法
        //    userInfo: 传递参数
        //    repeats: 是否重复
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.09 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    }
    
    return _timer;
    
}


-(void)timerAction{
    
    [self backButtonAction];
}





- (instancetype)initWithFrame:(CGRect)frame
{
    CGRect rect = CGRectMake(0, 0, ViewAllWidth, 10+(itemH+10)*5+keyboardH);
    
    if (self = [super initWithFrame:rect]) {
        
        self.backgroundColor=self.mtagCollectionView.backgroundColor = bgColor;

        self.emojiArr=[NSMutableArray array];
        
        NSArray *plsitNameArr=@[@"emoticons"];
        
        for (NSInteger i=0; i<plsitNameArr.count; i++) {
            
            NSArray *getrr=[self getPlistArr:plsitNameArr[i]];
            NSArray *sorArr=[TxtPicmodel mj_objectArrayWithKeyValuesArray:getrr];

            [self.emojiArr addObject:sorArr];
            
        }

//        NSArray *onearr=[self getArr:45 andBeforestr:@"A"];
//        NSArray *twoarr=[self getArr:78 andBeforestr:@"B"];
//        NSArray *threearr=[self getArr:34 andBeforestr:@"C"];
//        NSArray *fourarr=[self getArr:28 andBeforestr:@"D"];
//        NSArray *fivearr=[self getArr:90 andBeforestr:@"E"];
//        NSArray *sixarr=[self getArr:35 andBeforestr:@"F"];
//        NSArray *sevenarr=[self getArr:54 andBeforestr:@"G"];
//        NSArray *eightarr=[self getArr:37 andBeforestr:@"H"];
//        NSArray *ninearr=[self getArr:87 andBeforestr:@"I"];
//        NSArray *tenarr=[self getArr:55 andBeforestr:@"J"];
//
//        [self.emojiArr addObject:onearr];
//        [self.emojiArr addObject:twoarr];
//        [self.emojiArr addObject:threearr];
//        [self.emojiArr addObject:fourarr];
//        [self.emojiArr addObject:fivearr];
//        [self.emojiArr addObject:sixarr];
//        [self.emojiArr addObject:sevenarr];
//        [self.emojiArr addObject:eightarr];
//        [self.emojiArr addObject:ninearr];
//        [self.emojiArr addObject:tenarr];
        
        self.chooseScrollView.contentSize=CGSizeMake(15+(itemH+10)*self.emojiArr.count, 0);
        
        [self getBotmArr:self.emojiArr];

        [self setUI];
    }
    
    return self;
}


-(NSArray *)getPlistArr:(NSString *)plistname{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistname ofType:@"plist"];
    NSArray  *fileArray = [NSArray arrayWithContentsOfFile:filePath];
    
    
    return fileArray;
    
}


////测试用的
//-(NSArray *)getArr:(NSInteger )maxNum andBeforestr:(NSString *)beforestr{
//
//    NSMutableArray *cellArr=[NSMutableArray array];
//
//    for ( NSInteger i=0; i<maxNum; i++) {
//        NSString *addstr=[NSString stringWithFormat:@"%@%ld",beforestr,i];
//        [cellArr addObject:addstr];
//
//    }
//
//    return [NSArray arrayWithArray:cellArr];
//
//}


-(void)setUI{
    
    __weak typeof(self)  weakSelf=self;
    
    
    [self addSubview:self.mtagCollectionView];
    [self.mtagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.equalTo(weakSelf);
        make.height.mas_equalTo(10+(itemH+10)*4);
    }];
    
    
    [self addSubview:self.chooseScrollView];
    [self addSubview:self.botmLine];
    
    [self.chooseScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(weakSelf);
        make.height.mas_equalTo((itemH+10));
        make.top.equalTo(weakSelf.mtagCollectionView.mas_bottom).offset(0);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-keyboardH);
    }];
    
    [self.botmLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.chooseScrollView.mas_top);
        make.leading.trailing.equalTo(weakSelf);
        make.height.mas_equalTo(1);
    }];
    
    
    [self addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.mas_trailing).offset(-15);
        make.height.mas_equalTo(itemH);
        make.width.mas_equalTo((itemH+10)+15);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-(itemH+10)-15-keyboardH);
    }];
    
}




-(void)getBotmArr:(NSMutableArray *)botmarr{
 
    __weak typeof(self)  weakSelf=self;

    self.tagChooseArr=[NSMutableArray array];
    
    for (NSInteger i=0; i<botmarr.count; i++) {
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor=bgColor;
        
        NSArray *setarr=self.emojiArr[i];
        TxtPicmodel *imgmode=setarr[0];
        [btn setImage:[UIImage imageNamed:imgmode.png] forState:UIControlStateNormal];
        
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        btn.titleLabel.font=[UIFont systemFontOfSize:15];
//        [btn setTitle:[NSString stringWithFormat:@"%ld",i] forState:UIControlStateNormal];
        
        btn.tag=i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tagChooseArr addObject:btn];
        
        [self.chooseScrollView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(weakSelf.chooseScrollView.mas_leading).offset(15+(itemH+10)*i);
            make.height.width.mas_equalTo(itemH);
            make.top.equalTo(weakSelf.chooseScrollView.mas_top).offset(10);
        }];
                
    }
    
    
}


-(void)btnAction:(UIButton *)btn{
    
    if(_btn2== btn) {
    //上次点击过的按钮，不做处理
        
        
    } else{
     
        NSArray *getcellarr=self.emojiArr[btn.tag];
        
        self.sxArray=[NSMutableArray arrayWithArray:getcellarr];
        
        [self.mtagCollectionView reloadData];
        
    }
    _btn2= btn;
    
}


-(void)setSxArray:(NSMutableArray *)sxArray{
    _sxArray=sxArray;
}




#pragma mark collectionView代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  
    return self.sxArray.count;
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    __weak typeof(self) weakSelf=self;

    NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];

    [self.mtagCollectionView registerClass:[TxtpICemojiCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    TxtpICemojiCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    __weak typeof(cell)  weakCell=cell;
    
    
//    cell.txtLabel.text=self.sxArray[indexPath.row];
//    cell.txtLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row];

    cell.model=self.sxArray[indexPath.row];
    
    cell.backgroundColor=bgColor;

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

        return CGSizeMake(itemH,itemH);


}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{

        return UIEdgeInsetsMake(15, 15,15, 15);


}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
        return 10;

}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

        return 10;


}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    TxtpICemojiCollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];


    if (self.tagCelllock) {
        self.tagCelllock(cell.model.cht);
    }

}




@end
