#import "TCommonCell.h"
@class TIMUserProfile;
NS_ASSUME_NONNULL_BEGIN

@interface TCommonContactSelectCellData : TCommonCellData

- (void)setProfile:(TIMUserProfile *)profile;

@property NSURL *avatarUrl;
@property NSString *title;
@property UIImage *avatarImage;
@property NSString *identifier;

@property (nonatomic,getter=isSelected) BOOL selected;
@property (nonatomic,getter=isEnabled) BOOL enabled;

@end

NS_ASSUME_NONNULL_END
