//
//  BPTestBase.h
//  TestZone
//
//  Created by JiFu on 2/16/14.
//  Copyright (c) 2014 gmacsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
//Package Key
#define BPKeyArguments @"Arguments"
#define BPKeyItemName @"ItemName"
#define BPKeyPackageName @"PackageName"
#define BPKeyFunctionName @"FunctionName"
#define BPKeyContext @"Context"
#define BPKeyActions @"Actions"

//Context Key
#define BPKeyFailAction @"FailAction"
#define BPKeyTimeOut @"TimeOut"
#define BPKeyTestAction @"TestAction"
#define PDCAAttribution @"Attribution"
#define BPTestPriority @"PriorityFamily"
//Arguments Key
#define BPkeySecond @"Second"
#define BPkeyUUT @"UUT"
#define BPKeyDeviceID @"DeviceID"
#define BPKeyExpectStr @"ExpectStr"
#define BPKeyExpectStr2 @"ExpectStr2"
#define BPKeyIfFinalLine @"FinalLine"
#define BPKeyPatternStr @"PatternStr"
#define BPKeyPatternStr1 @"PatternStr1"
#define BPKeyPatternStr2 @"PatternStr2"
#define BPKeyPatternStr3 @"PatternStr3"

#define BPKeyMinValue @"MinValue"
#define BPKeyMaxValue @"MaxValue"

#define BPKeyNeedHexToInt @"NeedHexToInt"

#define BPKeyCfgType @"CfgType"
#define BPKeyAddPost @"AddPost"
#define BPKeyPostFix @"PostFix"
#define BPKeyCommand @"Command"
#define BPKeyStoringKeyName @"StoringKeyName"
#define BPKeyShellCommand @"ShellCommand"
#define BPKeyInfoKey @"InfoKey"
#define BPKeyInfoValue @"InfoValue"

#define BPKeyIgnoreItem @"IgnoreItem"

#define BPKeyBufferName  @"BufferName"
#define BPKeyCompareKey1 @"CompareKey1" // compare key pairs 1
#define BPKeyCompareKey2 @"CompareKey2" // compare key pairs 2
#define BPKeyBufferName1 @"BufferName1"  // henry added for store data
#define BPKeyBufferName2 @"BufferName2"  // henry added for store data
#define BPKeyRefferencBufferName1 @"RefferencBufferName1"  // henry added for store data
#define BPKeyRefferencBufferName2 @"RefferencBufferName2"  // henry added for store data
#define BPKeyRefferenceValue @"RefferencValue"
#define BPKeyPreReplace @"PreReplace"
#define BPKeyPostReplace @"PostReplace"


#define BPKeyUnit @"Unit"
#define BPKeySFCKey @"SFCKey"
#define BPRefKey @"RefKey"
#define BPRefKey1 @"RefKey1"
#define BPRefKey2 @"RefKey2"
#define BPKeyTestSpec @"TestSpec"
#define BPKeySeparator @"Separator"

//Notification name defined
#define BPTestFinished @"BPTestFinished"
#define BPTestAborted @"BPTestAborted"
#define BPTestReady @"BPTestReady"
#define BPTestAllFinished @"BPTestAllFinished"

//application default settings
#define LOG_DIRECTORY_ROOT @"/vault"
#define LOG_DIRECTORY_HOME @"/vault/BPLOG/"
#define LOG_FAIL_WIN_PATH @"/Volumes/WINDOWS/BP_DFU"
#define LOG_DIRECTORY_AUTO @"/AUTO"

#define LOG_DIRECTORY_CSV  @"/vault/BPLOG/CSV"
#define LOG_DIRECTORY_UART @"/vault/BPLOG/UART/"
#define LOG_DIRECTORY_BACKUP @"/vault/BPLOG/BACKUP/"
#define LOG_DIRECTORY_DCSD @"/vault/DCSD"
#define GH_INFO_JSON_PATH @"/vault/data_collection/test_station_config/gh_station_info.json"
#define STATION_INFO_PATH @"/Users/gdlocal/Desktop/Restore Info.txt"
//other variable
#define BPNullString @"N/A"
//Fixture Command list
//voltage control command

#define BPCMD_TURN_ON_BATT @"BATT_VCC_ON\r\n"
#define BPCMD_TURN_OFF_BATT @"BATT_VCC_OFF\r\n"

#define BPCMD_TURN_ON_USB @"USB_P5V0_ON\r\n"
#define BPCMD_TURN_OFF_USB @"USB_P5V0_OFF\r\n"

#define BPCMD_TURN_ON_FORCE_DFU @"FORCE_DFU_ON\r\n"
#define BPCMD_TURN_OFF_FORCE_DFU @"FORCE_DFU_OFF\r\n"

#define BPCMD_TURN_ON_HI5 @"HI5_POWER_ON\r\n"
#define BPCMD_TURN_OFF_HI5 @"HI5_POWER_OFF\r\n"

#define BPCMD_TURN_ON_ACC1_CONN @"ACC1_CONN_ON\r\n"
#define BPCMD_TURN_OFF_ACC1_CONN @"ACC1_CONN_OFF\r\n"

#define BPCMD_TURN_ON_DET_L @"DET_L_ON\r\n"
#define BPCMD_TURN_OFF_DET_L @"DET_L_OFF\r\n"

//cylinder control command
#define BPCMD_CTRL_K1_ON @"CTRL_K1_ON\r\n"
#define BPCMD_CTRL_K1_OFF @"CTRL_K1_OFF\r\n"

#define BPCMD_CTRL_K2_ON @"CTRL_K2_ON\r\n"
#define BPCMD_CTRL_K2_OFF @"CTRL_K2_OFF\r\n"

#define BPCMD_CTRL_K3_ON @"CTRL_K3_ON\r\n"
#define BPCMD_CTRL_K3_OFF @"CTRL_K3_OFF\r\n"

#define BPCMD_CTRL_K4_ON @"CTRL_K4_ON\r\n"
#define BPCMD_CTRL_K4_OFF @"CTRL_K4_OFF\r\n"

#define BPCMD_CTRL_START @"CTRL_START\r\n"

#define BPCMD_CTRL_END @"CTRL_END\r\n"

//LED light control command
//#define BPCMD_CTRL_UUT1_P @"CTRL_UUT1_F\r\n"
//#define BPCMD_CTRL_UUT1_F @"CTRL_UUT1_P\r\n"
//#define BPCMD_CTRL_UUT1_C @"CTRL_UUT1_C\r\n"


//#define BPCMD_CTRL_UUT2_P @"CTRL_UUT2_F\r\n"
//#define BPCMD_CTRL_UUT2_F @"CTRL_UUT2_P\r\n"
//#define BPCMD_CTRL_UUT2_C @"CTRL_UUT2_C\r\n"

//#define BPCMD_CTRL_UUT3_P @"CTRL_UUT3_F\r\n"
//#define BPCMD_CTRL_UUT3_F @"CTRL_UUT3_P\r\n"
//#define BPCMD_CTRL_UUT3_C @"CTRL_UUT3_C\r\n"

//#define BPCMD_CTRL_UUT4_P @"CTRL_UUT4_F\r\n"
//#define BPCMD_CTRL_UUT4_F @"CTRL_UUT4_P\r\n"
//#define BPCMD_CTRL_UUT4_C @"CTRL_UUT4_C\r\n"


//Get Senser value
#define BPCMD_GET_UP_SENSOR_VALUE @"CTRL_GET_S1\r\n"
#define BPCMD_GET_DOWN_SENSOR_VALUE @"CTRL_GET_S2\r\n"
//#define BPCMD_GET_IN_SENSOR_VALUE @"CTRL_GET_S4\r\n"
//#define BPCMD_GET_OUT_SENSOR_VALUE @"CTRL_GET_S3\r\n"
//others command
#define BPCMDGetFixtureVersion @"VER\r\n"
#define BPCMDResetFixture @"RESET\r\n"


//#define DEBUG_MODE


typedef enum _Device{
    Fixtrue =1,
    UnitUnderTest =2 ,
    HostServer =3
}BPDevice;


typedef enum _FailAction{
    FailContinue=0,//fail continue is the default action;
    FailRetry=1,
    FailStop=2,
    FailAsPass=3,
    NullAsPass=4
}FailActions;

typedef enum _TestAction{
    TestActionNormal=0, //test it;show in table;pudding test result ; *default is 0
    TestActionNoPudding=1,//test it;show in table; no pudding
    TestActionSkip=2, // no testting ;just show in table ;no pudding
    TestActionSync=3,//  wait for other channel complete at the same time. test it;show in table;pudding test result ; *default is 0
    TestActionRstIgnore=4, // test it, show in table, pudding test result, and the result is not affect the result of CB.
    TestActionDisable=5// no test ;no show;no pudding
}TestActions;

typedef enum _tResult{
    kFail =0,
    kPass = 1,
    kSkip,
    kPending,
    kFinishByAbort,
    kDisabled,
    kError
}tResult;

typedef enum _eStatus{
    NormalTest=0,
    SuspendTest,
    AbortTest,
}eStatus;

typedef struct _ChannelMask{
    BOOL ch1;
    BOOL ch2;
    BOOL ch3;
    BOOL ch4;
}ChannelMask;


