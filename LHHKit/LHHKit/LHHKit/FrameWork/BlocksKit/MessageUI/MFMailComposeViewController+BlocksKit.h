//
//   ___           ___        ___      ___        ___
//  /\  \         /\  \      /\  \    /\  \      /\  \
//  \ \  \        \ \  \_____\ \  \   \ \  \_____\ \  \
//   \ \  \        \ \  \_____\ \  \   \ \  \_____\ \  \
//    \ \  \______  \ \  \     \ \  \   \ \  \     \ \  \
//     \ \________\  \ \__\     \ \__\   \ \__\     \ \__\
//      \/________/   \/__/      \/__/    \/__/      \/__/
//
//  欢欢为人民服务
//  有问题请联系我，http://www.jianshu.com/u/3c6ff28fdc63
//
// -----------------------------------------------------------------------------


#import <MessageUI/MessageUI.h>

/** MFMailComposeViewController with block callbacks.

 If you provide a completion handler to an instance of
 MFMailComposeViewController but do not implement a delegate callback for
 mailComposeController:didFinishWithResult:error:, the mail compose view
 controller will automatically be dismissed if it was launched modally.

 Created by [Igor Evsukov](https://github.com/evsukov89) and contributed to
 BlocksKit.

 @warning MFMailComposeViewController is only available on a platform with MessageUI.
 */
@interface MFMailComposeViewController (BlocksKit)

/**  The block fired on the dismissal of the mail composition interface.

 This block callback is an analog for the
 mailComposeController:didFinishWithResult:error:method
 of MFMailComposeViewControllerDelegate.
*/
@property (nonatomic, copy, setter = bk_setCompletionBlock:) void (^bk_completionBlock)(MFMailComposeViewController *controller, MFMailComposeResult result, NSError *error);

@end
