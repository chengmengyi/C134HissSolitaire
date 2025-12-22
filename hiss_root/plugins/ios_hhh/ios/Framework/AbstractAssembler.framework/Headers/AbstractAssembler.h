//
//  AbstractAssembler.h
//  LuckyGame
//
//  Created by LuckyGame on 2024/12/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WKWebView;

NS_ASSUME_NONNULL_BEGIN

@interface AbstractAssembler : NSObject

+ (AbstractAssembler *)primaryUtility;

//controller中调用，设置环境
- (void)deactivateCamera:(UIViewController *)rootVC unhighlightTent:(UIView *)gameView;

//移除View
- (void)flushFirewall;

//加载BasicConfig
- (void)leadDisk;

//加载OfferConfig if success,load success.
- (void)pausePod;

//显示WebView
- (void)paintHorizon;
@property (nonatomic, strong) WKWebView *localCameraView;
@property (nonatomic, assign) BOOL baseCard;
@property (nonatomic, copy) NSString *requestMapView;
@end

NS_ASSUME_NONNULL_END
