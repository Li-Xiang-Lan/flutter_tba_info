//
//  NetworkHelper.h
//  FlutterSupport
//
//  Created by brushTalk on 04/03/2024.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

NS_ASSUME_NONNULL_BEGIN

@interface NetworkHelper : NSObject

+ (NSString *)netInfo;

@end

NS_ASSUME_NONNULL_END
