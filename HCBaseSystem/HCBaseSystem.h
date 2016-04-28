//
//  HCBaseSystem.h
//  HCBaseSystem
//
//  Created by HUANGXUTAO on 16/4/20.
//  Copyright © 2016年 seenvoice.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for HCBaseSystem.
FOUNDATION_EXPORT double HCBaseSystemVersionNumber;

//! Project version string for HCBaseSystem.
FOUNDATION_EXPORT const unsigned char HCBaseSystemVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <HCBaseSystem/PublicHeader.h>
#ifndef HCBaseSystem_H
#define HCBaseSystem_H
#import <HCBaseSystem/PublicEnum.h>
#import <HCBaseSystem/config.h>
#import <HCBaseSystem/textresource.h>
#import <HCBaseSystem/HCMessageGroup.h>
#import <HCBaseSystem/HCMessageItem.h>
#import <HCBaseSystem/HCTransferItem.h>
#import <HCBaseSystem/CMDOP_WT.h>
#import <HCBaseSystem/CMDS_WT.h>
#import <HCBaseSystem/CMDS_WT(base).h>
#import <HCBaseSystem/HCCallResultForWT.h>
#import <HCBaseSystem/HCDBHelper-initWT.h>
#import <HCBaseSystem/HCDBHelper(WT).h>
#import <HCBaseSystem/ResponseEntity.h>
#import <HCBaseSystem/UPloadParameters.h>
#import <HCBaseSystem/CMDLog.h>
#import <HCBaseSystem/CMD_LOGTIME.h>
#import <HCBaseSystem/UserManager.h>
#import <HCBaseSystem/HCImageSet.h>
#import <HCBaseSystem/HCSysRights.h>
#import <HCBaseSystem/HCUserConcern.h>
#import <HCBaseSystem/HCUserFriend.h>
#import <HCBaseSystem/HCUserSettings.h>
#import <HCBaseSystem/HCUserSummary.h>
#import <HCBaseSystem/UserInfo-Extend.h>
#import <HCBaseSystem/UserINformation.h>
#import <HCBaseSystem/CMD_ChangeUserAvatar.h>
#import <HCBaseSystem/CMD_ChangeUserIntro.h>
#import <HCBaseSystem/CMD_GetUserInfo.h>
#import <HCBaseSystem/CMD_Login.h>
#import <HCBaseSystem/CMD_Register.h>
#import <HCBaseSystem/CMD_RegisterPushToken.h>
#import <HCBaseSystem/CMD_SetUserInfo.h>
#import <HCBaseSystem/CMD_UpdateIP.h>
#import <HCBaseSystem/CMD_UserActivate.h>
#import <HCBaseSystem/CMD_UserLogout.h>
//#import <HCBaseSystem/Cover.h>
#import <HCBaseSystem/CMD_0001.h>
//#import <HCBaseSystem/UPloadRecord.h>
//#import <HCBaseSystem/MTVUploader.h>
//#import <HCBaseSystem/MBMTV.h>
//#import <HCBaseSystem/Music.h>
//#import <HCBaseSystem/Musician.h>
//#import <HCBaseSystem/MusicTag.h>
//#import <HCBaseSystem/MTV.h>
//#import <HCBaseSystem/MTVFile.h>
//#import <HCBaseSystem/CMD_DeleteSingleUserMaterial.h>
//#import <HCBaseSystem/CMD_DeleteMBMTV.h>
//#import <HCBaseSystem/CMD_DeleteMyMTV.h>
//#import <HCBaseSystem/CMD_UploadMBMTV.h>
//#import <HCBaseSystem/CMD_UploadMTV.h>
//#import <HCBaseSystem/CMD_CreateMTV.h>
#import <HCBaseSystem/UDDelegate.h>
#import <HCBaseSystem/CMD_GetDownloadToken.h>
#import <HCBaseSystem/CMD_GetUploadToken.h>
#import <HCBaseSystem/UDInfo.h>
#import <HCBaseSystem/UDManager(Helper).h>
#import <HCBaseSystem/UDManager.h>
#import <HCBaseSystem/CMD_BindGTCID.h>
#import <HCBaseSystem/TMManager.h>
#import <HCBaseSystem/UMSHareObject.h>
#import <HCBaseSystem/PageTag.h>
//#import <HCBaseSystem/MTVLocal.h>
//#import <HCBaseSystem/PlayRecord.h>
#import <HCBaseSystem/CMD_HeatBeat.h>
#import <HCBaseSystem/QTimespan.h>

#import <HCBaseSystem/HPGrowingTextView.h>
#import <HCBaseSystem/HPTextViewInternal.h>
//#import <HCBaseSystem/LoginViewNew.h>
#import <HCBaseSystem/SCGifImageView.h>
//#import <HCBaseSystem/ShareView.h>
#import <HCBaseSystem/UIMLabel.h>
#import <HCBaseSystem/UIMLabelEx.h>
#import <HCBaseSystem/UIPLaceHolderTextField.h>
#import <HCBaseSystem/UIPlaceHolderTextView.h>
#import <HCBaseSystem/UIWebImageViewN.h>

#import <HCBaseSystem/iVersion.h>

#import <HCBaseSystem/cmd_wt.h>
#import <HCBaseSystem/database_wt.h>
#import <HCBaseSystem/UpDown.h>
#import <HCBaseSystem/User_WT.h>
#import <HCBaseSystem/imagecontrols.h>
#import <HCBaseSystem/vdc.h>
#endif

