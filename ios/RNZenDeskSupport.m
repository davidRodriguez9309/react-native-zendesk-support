//
//  RNZenDeskSupport.m
//
//  Created by David Rodriguez
//

// RN <= 0.61 support
#if __has_include(<React/RCTBridge.h>)
#import <React/RCTConvert.h>
#else
#import "RCTConvert.h"
#endif

#import "RNZenDeskSupport.h"
#import <ZendeskSDK/ZendeskSDK.h>
#import <ZendeskCoreSDK/ZendeskCoreSDK.h>
@implementation RNZenDeskSupport

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(initialize:(NSDictionary *)config){
    NSString *appId = [RCTConvert NSString:config[@"appId"]];
    NSString *zendeskUrl = [RCTConvert NSString:config[@"zendeskUrl"]];
    NSString *clientId = [RCTConvert NSString:config[@"clientId"]];
    
    [ZDKZendesk initializeWithAppId:appId clientId:clientId zendeskUrl:zendeskUrl];
    [ZDKSupportUI initializeWithZendesk:[ZDKZendesk instance]];
}

RCT_EXPORT_METHOD(setupIdentity:(NSDictionary *)identity){
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *email = [RCTConvert NSString:identity[@"customerEmail"]];
        NSString *name = [RCTConvert NSString:identity[@"customerName"]];
        id<ZDKObjCIdentity> userIdentity = [[ZDKObjCAnonymous alloc] initWithName:name email:email];
        [[ZDKZendesk instance] setIdentity:userIdentity];
    });
}

RCT_EXPORT_METHOD(showHelpCenterWithOptions:(NSDictionary *)options) {
    dispatch_async(dispatch_get_main_queue(), ^{

        ZDKHelpCenterUiConfiguration * requestConfig = [ZDKHelpCenterUiConfiguration new];
        requestConfig.showContactOptions = YES;
        UIViewController *helpCenter = [ZDKHelpCenterUi buildHelpCenterOverviewUiWithConfigs:@[requestConfig]];

        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        UIViewController *rootViewController = (UIViewController *)window.rootViewController;

        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController: helpCenter];
        [navController.navigationBar setBarTintColor:UIColor.whiteColor];
        [navController.navigationBar setValue:@(YES) forKeyPath:@"hidesShadow"];
        [rootViewController presentViewController:navController animated:true completion:nil];
    });
}

RCT_EXPORT_METHOD(showCategoriesWithOptions:(NSArray *)categories options:(NSDictionary *)options) {
    dispatch_async(dispatch_get_main_queue(), ^{
        //        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        //        UIViewController *vc = [window rootViewController];
        //        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        //        helpCenterContentModel.groupType = ZDKHelpCenterOverviewGroupTypeCategory;
        //        helpCenterContentModel.groupIds = categories;
        //        helpCenterContentModel.hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
        //        if (helpCenterContentModel.hideContactSupport) {
        //            [ZDKHelpCenter setNavBarConversationsUIType:ZDKNavBarConversationsUITypeNone];
        //        }
        //        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        //        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showSectionsWithOptions:(NSArray *)sections options:(NSDictionary *)options) {
    dispatch_async(dispatch_get_main_queue(), ^{
        //        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        //        UIViewController *vc = [window rootViewController];
        //        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        //        helpCenterContentModel.groupType = ZDKHelpCenterOverviewGroupTypeSection;
        //        helpCenterContentModel.groupIds = sections;
        //        helpCenterContentModel.hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
        //        if (helpCenterContentModel.hideContactSupport) {
        //            [ZDKHelpCenter setNavBarConversationsUIType:ZDKNavBarConversationsUITypeNone];
        //        }
        //        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        //        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showLabelsWithOptions:(NSArray *)labels options:(NSDictionary *)options) {
    dispatch_async(dispatch_get_main_queue(), ^{
        //        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        //        UIViewController *vc = [window rootViewController];
        //        ZDKHelpCenterOverviewContentModel *helpCenterContentModel = [ZDKHelpCenterOverviewContentModel defaultContent];
        //        helpCenterContentModel.labels = labels;
        //        helpCenterContentModel.hideContactSupport = [RCTConvert BOOL:options[@"hideContactSupport"]];
        //        if (helpCenterContentModel.hideContactSupport) {
        //            [ZDKHelpCenter setNavBarConversationsUIType:ZDKNavBarConversationsUITypeNone];
        //        }
        //        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        //        [ZDKHelpCenter presentHelpCenterOverview:vc withContentModel:helpCenterContentModel];
    });
}

RCT_EXPORT_METHOD(showHelpCenter) {
    [self showHelpCenterWithOptions:nil];
}

RCT_EXPORT_METHOD(showCategories:(NSArray *)categories) {
    [self showCategoriesWithOptions:categories options:nil];
}

RCT_EXPORT_METHOD(showSections:(NSArray *)sections) {
    [self showSectionsWithOptions:sections options:nil];
}

RCT_EXPORT_METHOD(showLabels:(NSArray *)labels) {
    [self showLabelsWithOptions:labels options:nil];
}

RCT_EXPORT_METHOD(callSupport:(NSDictionary *)customFields) {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        UIViewController *vc = [window rootViewController];
        NSMutableArray *fields = [[NSMutableArray alloc] init];
        for (NSString* key in customFields) {
            id value = [customFields objectForKey:key];
            //            [fields addObject: [[ZDKCustomField alloc] initWithFieldId:@(key.integerValue) andValue:value]];
        }
        //        [ZDKConfig instance].customTicketFields = fields;
        //        [ZDKRequests presentRequestCreationWithViewController:vc];
    });
}

RCT_EXPORT_METHOD(supportHistory){
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        UIViewController *vc = [window rootViewController];
        //        [ZDKRequests presentRequestListWithViewController:vc];
    });
}
@end
