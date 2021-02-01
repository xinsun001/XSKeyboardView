//
//  TxtPicInputView.m
//  XSKeyboardView
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import "TxtPicInputView.h"

@implementation TxtPicInputView


-(UIView *)bgView{
    if (!_bgView) {
        _bgView=[UIView new];
        _bgView.backgroundColor=[UIColor greenColor];
        _bgView.layer.cornerRadius=17.5;
        _bgView.layer.masksToBounds=YES;
    }
    return _bgView;
}

-(UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@" 发送 " forState:UIControlStateNormal];
        _sendButton.titleLabel.font=[UIFont systemFontOfSize:13];
        _sendButton.backgroundColor=colorWithValue(40, 133, 247, 1);
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendButton.layer.cornerRadius=5;
        _sendButton.layer.masksToBounds=YES;
        [_sendButton addTarget:self  action:@selector(sendButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

-(void)sendButtonAction{
    
    if (self.detailTextView.text.length>0) {
        if (self.sendButtonBlock) {
            self.sendButtonBlock(self.detailTextView.text);
        }
    }else{
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入评论内容"];
    }
}

-(UIButton *)keybordButton{
    if (!_keybordButton) {
        _keybordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_keybordButton setImage:[UIImage imageNamed:@"emojiImg"] forState:UIControlStateNormal];
        [_keybordButton setImage:[UIImage imageNamed:@"keyBoardimg"] forState:UIControlStateSelected];
        [_keybordButton addTarget:self action:@selector(keybordButtonAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _keybordButton;
}

-(void)keybordButtonAction{
    if (self.keybordButton.isSelected==YES) {
        self.keybordButton.selected=NO;

//        NSLog(@"没点击");
    }else{
        self.keybordButton.selected=YES;


    }

    if (self.keybordButtonBlock) {
        self.keybordButtonBlock(self.keybordButton.selected);
    }

}

-(UILabel *)ploceLabel{
    if (!_ploceLabel) {
        _ploceLabel=[UILabel new];
        _ploceLabel.font=[UIFont systemFontOfSize:15];
        _ploceLabel.textColor=[UIColor lightGrayColor];
        _ploceLabel.text=@"爱评论的人运气都不会差~";
    }
    return _ploceLabel;
}

-(UITextView *)detailTextView{
    if (!_detailTextView) {
        _detailTextView=[UITextView new];
        _detailTextView.delegate=self;
        _detailTextView.font=[UIFont systemFontOfSize:15];
        _detailTextView.textColor=[UIColor blackColor];
        _detailTextView.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0];
       
        _detailTextView.returnKeyType=UIReturnKeySend;
    }
    return _detailTextView;
}



-(instancetype)init{
    self=[super init];
    
    if (self) {
        
        
        [self setUI];
        
                
    }
    return self;
}


-(void)setUI{
    
    __weak typeof(self)  weakSelf=self;
    
    [self addSubview:self.sendButton];

    [self addSubview:self.bgView];
    [self addSubview:self.keybordButton];
    [self addSubview:self.detailTextView];
    [self insertSubview:self.ploceLabel aboveSubview:self.detailTextView];

    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.mas_trailing).offset(-15);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).offset(-3);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(55);
    }];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.mas_leading).offset(15);
        make.trailing.equalTo(weakSelf.sendButton.mas_leading).offset(-15);
        make.top.equalTo(weakSelf.mas_top).offset(10);
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
    }];
    
    
    
    [self.keybordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(weakSelf.bgView.mas_trailing).offset(-10);
        make.height.width.mas_equalTo(20);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).offset(-7);
    }];
    
    [self.detailTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView.mas_leading).offset(10);
        make.top.equalTo(weakSelf.bgView.mas_top).offset(7);
        make.bottom.equalTo(weakSelf.bgView.mas_bottom).offset(-3);
        make.trailing.equalTo(weakSelf.keybordButton.mas_leading).offset(-10);
    }];
    
    [self.ploceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(weakSelf.bgView.mas_leading).offset(13);
        make.centerY.equalTo(weakSelf.bgView.mas_centerY).offset(-1);
        make.trailing.equalTo(weakSelf.bgView.mas_trailing).offset(-10);
    }];

    
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length>0) {
        self.ploceLabel.hidden=YES;

    }else{
        self.ploceLabel.hidden=NO;

    }
    
    NSInteger inputH=55;
    
    float textViewWidth=ViewAllWidth-(20+30+10+20);//取得文本框宽度

    NSString *content=textView.text;
    NSDictionary *dict=@{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize contentSize=[content sizeWithAttributes:dict];//计算文字长度
    float numLine=ceilf(contentSize.width/textViewWidth); //计算当前文字长度对应的行数
    
//    NSInteger heightText=contentSize.height;

    if (numLine>1) {
        
        if (numLine>4) {
            inputH=inputH+17*3;

        }else{
            inputH=inputH+17*(numLine-1);

        }

    }else{
        inputH=inputH;

    }
    
    
    if (self.textViewHeightBlock) {
        self.textViewHeightBlock(inputH);
    }

}


-(void)textViewDidEndEditing:(UITextView *)textView{

   
}


- (void)textViewDidBeginEditing:(UITextView *)textView{

    self.detailTextView.textColor=[UIColor lightGrayColor];

}



@end
