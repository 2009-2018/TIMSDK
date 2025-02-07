#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^TAsyncImageComplete)(NSString *path, UIImage *image);

@interface THelper : NSObject
+ (NSString *)genImageName:(NSString *)uuid;
+ (NSString *)genSnapshotName:(NSString *)uuid;
+ (NSString *)genVideoName:(NSString *)uuid;
+ (NSString *)genFileName:(NSString *)uuid;
+ (NSString *)genVoiceName:(NSString *)uuid withExtension:(NSString *)extent;
+ (BOOL)isAmr:(NSString *)path;
+ (BOOL)convertAmr:(NSString*)amrPath toWav:(NSString*)wavPath;
+ (BOOL)convertWav:(NSString*)wavPath toAmr:(NSString*)amrPath;
+ (void)asyncDecodeImage:(NSString *)path complete:(TAsyncImageComplete)complete;
+ (void)makeToast:(NSString *)str;
+ (void)makeToastError:(NSInteger)error msg:(NSString *)msg;
+ (void)makeToastActivity;
+ (void)hideToastActivity;
+ (NSString *)randAvatarUrl;
@end
