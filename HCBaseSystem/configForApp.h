//
//  configForApp.h
//  HCBaseSystem
//
//  Created by HUANGXUTAO on 16/4/21.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#ifndef configForApp_h
#define configForApp_h

//最大的上传文件大小
#define CT_MAXUPLOADFILESIZE    400*1024*1024
#define CT_DEALURL              @"http://deal.seenvoice.com/%d"
#define CT_SERVICEURL           @"http://service.seenvoice.com/%d"
//#define CT_ABOUTUSURL       @"http:/app.suixing.com/about"
//#define CT_ABOUTUSURL       @"http://a.suixing.com/aboutus.html"
#define CT_ABOUTUSURL           @"http://about.seenvoice.com/"
#define CT_FUNINTROURL          @"http://a.seenvoice.com/demo.html"



//关于底层发送到前端的消息的宏
#define NT_APPREACTIVE          @"CMD_APPREACTIVE"
#define NT_MSGNOTI              @"MSG_NOTIFICATION"  //内容：msg:"title..."
#define NT_MSGCENTER            @"MSG_CENTER"        //内容：msg:"title..."



#define NOTICE_CHANGECITY       @"CHANGECITY"
#define NOTICE_BILLCHANGED      @"CHANGEBILL"


//#pragma mark - notice
#define NT_MERGESUCCEED             @"NT_MERGESUCCEED"
#define NT_SHOWMAIN                 @"NT_SHOWMAINUI"
#define NT_SHOWSETTINGS             @"NT_SHOWSETTINGSUI"
#define NT_HIDESETTINGS             @"NT_HIDESETTINGSUI"
#define NT_POPCURRENT               @"NT_POPCURRENTUI"
#define NT_RECORDVIDEO              @"NT_RECORDVIDEO"
#define NT_EDITVIDEO                @"NT_EDITVIDEO"
#define NT_MERGEVIDEO               @"NT_MERGEVIDEO"
#define NT_SELECTVIDEO              @"NT_SELECTVIDEO"


#define NT_STARTRECORD              @"NT_STARTRECORD"
#define NT_STOPRECORD               @"NT_STOPRECORD"
#define NT_RECORDMETERCHANGED       @"NT_RECORDMETERCHANGED"
#define NT_CANSENDSTATUSCHANGED     @"NT_CANSENDSTATUSCHANGED"

#pragma mark - navigation
#define NT_BACKTOHOME           @"MSG_BACKTOHOME"
#define NT_GOTONEXT             @"MSG_GOTONEXT"
#define NT_IWANTSING                @"NT_IWANTSING"
#define NT_RETURNTOMAIN             @"NT_RETURNTOMAIN"
#define NT_GOTOMINE                 @"NT_GOTOMINE"

#define NT_BEGINPLAYAUDIO           @"NT_BEGINPLAYAUDIO"
#define NT_ISPLAYINGAUDIO           @"NT_ISPLAYINGAUDIO"
#define NT_ENDPLAYAUDIO             @"NT_ENDPLAYAUDIO"

#define NT_RECORDAUDIOSUCCEED       @"NT_RECORDAUDIOSUCCEED"

#endif /* configForApp_h */
