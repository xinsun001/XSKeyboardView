//
//  TxtpICemojiCollectionViewCell.m
//  XSKeyboardView
//
//  Created by admin on 2020/12/31.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import "TxtpICemojiCollectionViewCell.h"

@implementation TxtpICemojiCollectionViewCell

//
//-(UILabel *)txtLabel{
//    if (!_txtLabel) {
//        _txtLabel=[UILabel new];
//        _txtLabel.font=[UIFont systemFontOfSize:13];
//        _txtLabel.textColor=[UIColor whiteColor];
//    }
//    return _txtLabel;
//}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView=[UIImageView new];
    }
    return _imgView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
                
        __weak typeof(self)  weakSelf=self;
        
      
//        [self.contentView addSubview:self.txtLabel];
//        [self.txtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(weakSelf.contentView);
//        }];
        
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.imgView);
        }];
    
    }
    return self;
}


-(void)setModel:(TxtPicmodel *)model{
    _model=model;
    
    self.imgView.image=[UIImage imageNamed:model.png];
}


@end
