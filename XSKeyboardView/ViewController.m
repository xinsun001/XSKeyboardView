//
//  ViewController.m
//  XSKeyboardView
//
//  Created by admin on 2021/1/25.
//

#import "ViewController.h"
#import "TxtPicInputView.h"
#import "TxtPicEmojiKeyboardView.h"
#import "XSNumberKeyboard.h"

@interface ViewController ()<UIGestureRecognizerDelegate,UITextViewDelegate>

@property(nonatomic,strong)UITextView *ceshiTextView;

@property(nonatomic,strong)UIButton *keyBoardButton;

@property(nonatomic,strong)UITextField *numBoardTextField;

@property(nonatomic,strong)TxtPicInputView *topInputView;

@property(nonatomic,strong)TxtPicEmojiKeyboardView *inpytView;

@property(nonatomic,strong)XSNumberKeyboard *numStyleBoard;


@property(nonatomic,assign)NSInteger keyInputH;

@property(nonatomic,assign)CGRect lenFrame;

@property(nonatomic,assign)BOOL setpicBool;

@end

@implementation ViewController

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    
    

}

-(UITextView *)ceshiTextView{
    if (!_ceshiTextView) {
        _ceshiTextView=[UITextView new];
        _ceshiTextView.delegate=self;
        _ceshiTextView.font=[UIFont systemFontOfSize:15];
        _ceshiTextView.textColor=[UIColor blackColor];
        _ceshiTextView.backgroundColor=[UIColor lightGrayColor];
        _ceshiTextView.returnKeyType=UIReturnKeySend;
        _ceshiTextView.text=@"测试编辑状态时键盘样式";
    }
    return _ceshiTextView;
}

-(UIButton *)keyBoardButton{
    if (!_keyBoardButton) {
        _keyBoardButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_keyBoardButton setTitle:@"调起表情键盘" forState:UIControlStateNormal];
        [_keyBoardButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_keyBoardButton addTarget:self action:@selector(keyBoardButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _keyBoardButton;
}


-(void)keyBoardButtonAction{
    
    [self.topInputView.detailTextView becomeFirstResponder];

}

-(UITextField *)numBoardTextField{
    if (!_numBoardTextField) {
        _numBoardTextField=[UITextField new];
        _numBoardTextField.textColor=[UIColor blackColor];
        _numBoardTextField.backgroundColor=[UIColor cyanColor];
        _numBoardTextField.placeholder=@"调起数字键盘";
        _numBoardTextField.inputView=self.numStyleBoard;
        [_numBoardTextField reloadInputViews];
    }
    return _numBoardTextField;
}



-(TxtPicEmojiKeyboardView *)inpytView{
    if (!_inpytView) {
        _inpytView=[TxtPicEmojiKeyboardView new];
        [_inpytView btnAction:_inpytView.tagChooseArr[0]];
    }
    return _inpytView;
}

-(TxtPicInputView *)topInputView{
    if (!_topInputView) {
        _topInputView=[TxtPicInputView new];
        _topInputView.backgroundColor=[UIColor grayColor];
    }
    return _topInputView;
}


-(XSNumberKeyboard *)numStyleBoard{
    if (!_numStyleBoard) {
        _numStyleBoard=[XSNumberKeyboard new];
        
    }
    return _numStyleBoard;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];


    self.keyInputH=55;
    
    [self setUI];

    
    [self setBlock];

}


-(void)forgetCanTouch{
    
    [[[UIApplication sharedApplication]keyWindow]endEditing:YES];
        
}

-(void)setUI{
    

    weakSet(self)
    
    [self.view addSubview:self.ceshiTextView];
    [self.ceshiTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSub.view.mas_top).offset(NAVBAR_HEIGHT+20);
        make.width.mas_equalTo(ViewAllWidth-80);
        make.centerX.equalTo(weakSub.view);
        make.bottom.equalTo(weakSub.view.mas_centerY).offset(-50);;
    }];
    
    [self.view addSubview:self.keyBoardButton];
    [self.keyBoardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSub.view);
        make.trailing.equalTo(weakSub.view.mas_centerX).offset(-20);
    }];
    
    [self.view addSubview:self.numBoardTextField];
    [self.numBoardTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSub.view);
        make.leading.equalTo(weakSub.view.mas_centerX).offset(20);
    }];
    
    [self.view addSubview:self.topInputView];
    self.topInputView.frame=CGRectMake(0, ViewAllHeight, ViewAllWidth, self.keyInputH);
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardCancel:)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)keyboardCancel:(UITapGestureRecognizer *)tap{

    [self forgetCanTouch];
   
}


-(void)setBlock{
    
    weakSet(self)

    [self.topInputView setKeybordButtonBlock:^(BOOL keyboardBool) {
      
        weakSub.setpicBool=keyboardBool;
        
        if (keyboardBool==YES) {
            //表情键盘
                        
            weakSub.topInputView.detailTextView.inputView=weakSub.inpytView;
            [weakSub.topInputView.detailTextView reloadInputViews];
            
            
        }else{
            //系统键盘
            
            weakSub.topInputView.detailTextView.inputView=nil;
            [weakSub.topInputView.detailTextView reloadInputViews];

        }
    }];
    
    [self.topInputView setTextViewHeightBlock:^(NSInteger height) {
       
        weakSub.keyInputH=height;
        
        [weakSub relpodInoutH:height];

    }];
    
    [self.topInputView setSendButtonBlock:^(NSString * _Nonnull sendStr) {
        
        [weakSub forgetCanTouch];
        
        //执行发送信息的任务
       
        weakSub.topInputView.detailTextView.text=@"";
        weakSub.topInputView.ploceLabel.hidden=NO;

    }];
    
    [self.inpytView setBackButtonBlock:^{
        
        [weakSub.topInputView.detailTextView deleteBackward];
    }];
    
    [self.inpytView setTagCelllock:^(NSString * _Nonnull str) {

        NSString *nowtxt= weakSub.topInputView.detailTextView.text;

        nowtxt=[nowtxt stringByAppendingString:str];
        
        weakSub.topInputView.detailTextView.text=nowtxt;
        
        if (nowtxt.length>0) {
            weakSub.topInputView.ploceLabel.hidden=YES;

        }else{
            weakSub.topInputView.ploceLabel.hidden=NO;

        }
        
        
    }];
    
}

-(void)relpodInoutH:(NSInteger)keyInputH{

    [UIView animateWithDuration:0.2f animations:^{
        CGRect frame1 = self.topInputView.frame;
        frame1.size.height=keyInputH;
        if (self.lenFrame.origin.y ==  ViewAllHeight) {
            frame1.origin.y=self.topInputView.frame.origin.y;

        }else{
            frame1.origin.y=ViewAllHeight-self.lenFrame.size.height-keyInputH;

        }
        frame1.origin.x=self.topInputView.frame.origin.x;
        frame1.size.width=self.topInputView.bounds.size.width;
        self.topInputView.frame=frame1;

    }];


}


- (void)keybordChanged:(NSNotification *)notification{
    
    self.lenFrame = [notification.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect resultFrame ;
        
        if (self.lenFrame.origin.y ==  ViewAllHeight) {
            

            resultFrame=CGRectMake(0,  ViewAllHeight,  ViewAllWidth, self.keyInputH);
            
          
        }else{
            resultFrame=CGRectMake(0,  ViewAllHeight-self.lenFrame.size.height-self.keyInputH,  ViewAllWidth, self.keyInputH);
            
        }
        
        self.topInputView.frame = resultFrame;
        
    }];
}



-(void)setSetpicBool:(BOOL)setpicBool{

    _setpicBool=setpicBool;


    if (setpicBool==YES) {
        //表情键盘
                    
        self.ceshiTextView.inputView=self.inpytView;
        [self.ceshiTextView reloadInputViews];
        
        
        self.topInputView.detailTextView.inputView=self.inpytView;
        [self.topInputView.detailTextView reloadInputViews];
        
    }else{
        //系统键盘
        
        self.ceshiTextView.inputView=nil;
        [self.ceshiTextView reloadInputViews];
        
        self.topInputView.detailTextView.inputView=nil;
        [self.topInputView.detailTextView reloadInputViews];

    }
}



//- (void)textViewDidBeginEditing:(UITextView *)textView{
//
//    if (self.setpicBool==YES) {
//        //表情键盘
//
//        self.ceshiTextView.inputView=self.inpytView;
//        [self.ceshiTextView reloadInputViews];
//
//
//        self.topInputView.detailTextView.inputView=self.inpytView;
//        [self.topInputView.detailTextView reloadInputViews];
//
//    }else{
//        //系统键盘
//
//        self.ceshiTextView.inputView=nil;
//        [self.ceshiTextView reloadInputViews];
//
//        self.topInputView.detailTextView.inputView=nil;
//        [self.topInputView.detailTextView reloadInputViews];
//
//    }
//}



@end
