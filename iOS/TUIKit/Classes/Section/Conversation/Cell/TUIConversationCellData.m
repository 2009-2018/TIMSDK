#import "TUIConversationCellData.h"
#import "THeader.h"
#import "UIImage+TUIKIT.h"
#import "TIMUserProfile+DataProvider.h"
#import "ReactiveObjC/ReactiveObjC.h"
#import "TIMMessage+DataProvider.h"
#import "TUIKit.h"

@implementation TUIConversationCellData


- (CGFloat)heightOfWidth:(CGFloat)width
{
    return TConversationCell_Height;
}

- (BOOL)isEqual:(TUIConversationCellData *)object
{
    return [self.convId isEqual:object.convId];
}

@end
