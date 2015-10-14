//
//  SendViewController.m
//  WeiboPlus
//
//  Created by wol on 15/9/21.
//  Copyright (c) 2015年 wol. All rights reserved.
//

#import "SendViewController.h"
#import "ThemeButton.h"
#import "ZoomImageView.h"
#import "MMDrawerController.h"
#import "DataService.h"
//#import <CoreLocation/CoreLocation.h>
@interface SendViewController (){

    //01.文本编辑栏
    UITextView *_textView;
    //02.工具栏
    UIView *_toolView;
    //03 显示缩略图
    ZoomImageView *_zoomImageView;
    //04 发送的图片
    UIImage *_sendImage;
    //05位置管理器
    CLLocationManager *_locationManager;
    UILabel *_locationLabel;
    //5 表情面板
    FaceScrollView *_faceViewPanel;
    
    

}

@end

@implementation SendViewController

- (void)dealloc{

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _createItems];
    [self _createEditorView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //弹出键盘
    [_textView becomeFirstResponder];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
#pragma mark - 键盘弹出通知
- (void)keyboardWillShow:(NSNotification *)notification{
    NSLog(@"%@",notification);
    //01取出键盘frame
    NSValue *boundsValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [boundsValue CGRectValue];
    //02键盘高度
    CGFloat height = frame.size.height;
    
    //03调整视图高度
    _toolView.bottom = kScreenHeight - height - 60;

    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //当导航栏不透明时，子视图的y的0位置在导航栏的下面
    self.navigationController.navigationBar.translucent = NO;
    _textView.frame = CGRectMake(0, 0, kScreenWidth, 120);
    //设置textview 内容偏移
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //弹出键盘_textView 为第一响应者
    [_textView becomeFirstResponder];
}

#pragma mark - 左右buttonItem
- (void)_createItems{
    //1.关闭按钮
    ThemeButton *closeButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    closeButton.normalImageName = @"button_icon_close.png";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:closeButton];
    [self.navigationItem setLeftBarButtonItem:leftItem];
    [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    //1.发送按钮
    ThemeButton *sendButton = [[ThemeButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    sendButton.normalImageName = @"button_icon_ok.png";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:sendButton];
    [self.navigationItem setRightBarButtonItem:rightItem];
    [sendButton  addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];
    

}
#pragma mark - 创建编辑视图
- (void)_createEditorView{
    
    //01 文本输入框
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    _textView.backgroundColor = [UIColor lightGrayColor];
    _textView.font = [UIFont systemFontOfSize:16.0f];
    _textView.editable = YES;
    //设置圆角、边框等
    _textView.layer.cornerRadius = 5;
    _textView.layer.borderWidth = 2;
    _textView.layer.borderColor = [UIColor cyanColor].CGColor;
    [self.view addSubview:_textView];
    
    //02工具栏
    _toolView = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 55)];
    _toolView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_toolView];
    //创建多个编辑按钮
    NSArray *imgButton = @[
                           @"compose_toolbar_1.png",
                           @"compose_toolbar_4.png",
                           @"compose_toolbar_3.png",
                           @"compose_toolbar_5.png",
                           @"compose_toolbar_6.png"
                           ];
    for (int i = 0; i < imgButton.count; i++) {
        ThemeButton *button = [[ThemeButton alloc]initWithFrame:CGRectMake(15+(kScreenWidth/5)*i,20 , 40, 33)];
        button.tag = 100 + i;
        NSString *imageName = imgButton[i];
        button.normalImageName = imageName;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_toolView addSubview:button];
        
    }
    
    //03创建label显示位置信息
    _locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    _locationLabel.font = [UIFont systemFontOfSize:13];
    _locationLabel.backgroundColor = [UIColor lightGrayColor];
    _locationLabel.hidden = YES;
    [_toolView addSubview:_locationLabel];
    
    

}

- (void)buttonAction:(UIButton  *)button{
    if (button.tag == 100) {
        //从相册选择图片
        [self _selectPhoto];
    }
     else if (button.tag == 103) {
        //显示位置
        [self _location];
        
     } else if (button.tag == 104){//显示、隐藏表情
         
         BOOL isFirstResponder = _textView.isFirstResponder;
         
         //输入框是否是第一响应者，如果是，说明键盘已经显示
         if (isFirstResponder) {
             //隐藏键盘
             [_textView resignFirstResponder];
             //显示表情
             [self _showFaceView];
             //隐藏键盘
             
         } else {
             //隐藏表情
             [self _hideFaceView];
             
             //显示键盘
             [_textView becomeFirstResponder];

         }
         
     }
    

}

- (void)_selectPhoto{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil]
    ;
    [actionSheet showInView:self.view];

}
//UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    UIImagePickerControllerSourceType  sourceType;
    if (buttonIndex == 0) { //拍照
        sourceType = UIImagePickerControllerSourceTypeCamera;
        BOOL isCamera = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
        if (!isCamera) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法使用摄像头" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
    }
    
    else if(buttonIndex == 1){//从相册选择
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
    }else{
    
        return;
    }
    
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    
    //1弹出相册控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    //2.取出照片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //3.显示缩略图
    if (_zoomImageView == nil){
        _zoomImageView = [[ZoomImageView alloc]initWithImage:image];
        _zoomImageView.frame = CGRectMake(10, _textView.bottom+10, 80, 80);
        [self.view addSubview:_zoomImageView];
        _zoomImageView.delegate = self;
    }
    
    _zoomImageView.image = image;
    _sendImage = image;
    
    
    


}

#pragma mark - 图片放大缩小的通知
- (void)imageWillZoomIn:(ZoomImageView *)imageView{

    //失去第一响应者
    [_textView resignFirstResponder];
}
- (void)imageWillZoomOut:(ZoomImageView *)imageView{

    
    [_textView becomeFirstResponder];
}

- (void)closeAction{
    NSLog(@"点击了关闭按钮");
    
    //通过window找到MMDRawer
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([window.rootViewController isKindOfClass:[MMDrawerController class]]) {
        MMDrawerController *mmDrawer = (MMDrawerController *)window.rootViewController;
        [mmDrawer closeDrawerAnimated:YES completion:NULL];
    }

    [_textView resignFirstResponder];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)sendAction{
    NSLog(@"点击了发送按钮");
    
    NSString *text = _textView.text;
    NSString *error = nil;
    if (text.length == 0) {
        error = @"微博内容为空";
    }else if (text.length > 140){
    
        error = @"微博内容超过140字符";
        
    }
    if (error != nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
  //  NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
  // [params setObject:text forKey:@"status"];
    //发送
  
    AFHTTPRequestOperation *operation = [DataService sendWeibo:text image:_sendImage block:^(id result) {
        NSLog(@"发送反馈%@",result);
        [self showStatusTip:@"发送完毕" show:NO operation:nil];
    }];
    [self showStatusTip:@"正在发送" show:YES operation:operation];
    
    [self closeAction];
    
   
    
}

/*定位精度，越精确月费电
 extern const CLLocationAccuracy kCLLocationAccuracyBest;
 extern const CLLocationAccuracy kCLLocationAccuracyNearestTenMeters;
 extern const CLLocationAccuracy kCLLocationAccuracyHundredMeters;
 extern const CLLocationAccuracy kCLLocationAccuracyKilometer;
 extern const CLLocationAccuracy kCLLocationAccuracyThreeKilometers;

*/
#pragma mark - 地理位置
- (void)_location{

    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        
        //版本信息
        //[[UIDevice currentDevice].systemVersion doubleValue];
        //判断系统版本信息.8.0版本以后的能调用代理方法获得授权.
        if (kVersion > 8.0) {
            [_locationManager requestWhenInUseAuthorization];

        }
         
     }
    //设置定位精度
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    _locationManager.delegate = self;
    //开始定位
    [_locationManager startUpdatingLocation];
    
}


//CLLocationDegrees latitude;  纬度
//CLLocationDegrees longitude; 经度

#pragma mark - 位置管理的代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    //01停止定位
    [manager stopUpdatingLocation];

    //02取得地理位置信息
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"经度%f,纬度%f",coordinate.longitude,coordinate.latitude);
    
    //地理位置反编码
    //一 新浪位置反编码 接口说明  http://open.weibo.com/wiki/2/location/geo/geo_to_address
    NSString *coordinateStr = [NSString stringWithFormat:@"%f,%f",coordinate.longitude,coordinate.latitude];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:coordinateStr forKey:@"coordinate"];
    
//block在使用全局变量会造成循环引用  weak时箭头不能调用
     __weak SendViewController  *weakSelf = self;
    
    [DataService requestAFUrl:geo_to_address httpMethod:@"GET" params:params data:nil block:^(id result) {
        NSArray *geos = [result objectForKey:@"geos"];
        if (geos.count > 0) {
            NSDictionary *geoDic = [geos lastObject];
            NSString *addr = [geoDic objectForKey:@"address"];
            NSLog(@"地址是%@",addr);
            
            
           __strong SendViewController *strongSelf = weakSelf;
           strongSelf->_locationLabel.hidden = NO;
           strongSelf->_locationLabel.text = addr;
//
           // _locationLabel.text = addr;
        }
    }];
    
    
    //二ios 内置反编码
    
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *place = [placemarks lastObject];
//        NSLog(@"使用iOS内置反编码获取的地理位置:%@",place.name);
//        NSLog(@"%@",place.country);
//    }];
    
    
}
    
    
#pragma mark - 表情处理
    
- (void)_showFaceView{
        
        //创建表情面板
        if (_faceViewPanel == nil) {
            
            
            _faceViewPanel = [[FaceScrollView alloc] init];
            [_faceViewPanel setFaceViewDelegate:self];
            //放到底部
            _faceViewPanel.top  = kScreenHeight-64;
            [self.view addSubview:_faceViewPanel];
        }
        
        //显示表情
        [UIView animateWithDuration:0.3 animations:^{
            
            _faceViewPanel.bottom = kScreenHeight-64;
            //重新布局工具栏、输入框
            _toolView.bottom = _faceViewPanel.top;
            
        }];
    }
    
    //隐藏表情
- (void)_hideFaceView {
        
        //隐藏表情
        [UIView animateWithDuration:0.3 animations:^{
            _faceViewPanel.top = kScreenHeight-64;
            
        }];
        
    }
- (void)faceDidSelect:(NSString *)text{
        NSLog(@"选中了%@",text);
        
        _textView.text = [NSString stringWithFormat:@"%@%@",_textView.text,text];
}
    




@end
