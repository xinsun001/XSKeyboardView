//
//  TxtPicInputView.h
//  XSKeyboardView
//
//  Created by admin on 2020/12/30.
//  Copyright © 2020 xin sun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TxtPicInputView : UIView<UITextViewDelegate>

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UIButton *sendButton;
@property(nonatomic,copy)void(^sendButtonBlock)(NSString *sendStr);


@property(nonatomic,strong)UIButton *keybordButton;
@property(nonatomic,copy)void(^keybordButtonBlock)(BOOL keyboardBool);

@property(nonatomic,strong)UILabel *ploceLabel;

@property(nonatomic,strong)UITextView *detailTextView;


@property(nonatomic,copy)void(^textViewHeightBlock)(NSInteger height);


-(void)keybordButtonAction;

@end

NS_ASSUME_NONNULL_END
