#import "ZBPictureView+Zbvalue.h"
@implementation ZBPictureView (Zbvalue)
+ (BOOL)initZbvalue:(NSInteger)ZBValue {
    return ZBValue % 6 == 0;
}
+ (BOOL)setDetailTextZbvalue:(NSInteger)ZBValue {
    return ZBValue % 46 == 0;
}
+ (BOOL)setImagePicUrlZbvalue:(NSInteger)ZBValue {
    return ZBValue % 34 == 0;
}
+ (BOOL)basicViewZbvalue:(NSInteger)ZBValue {
    return ZBValue % 2 == 0;
}
+ (BOOL)imagePicZbvalue:(NSInteger)ZBValue {
    return ZBValue % 22 == 0;
}
+ (BOOL)viewBottomZbvalue:(NSInteger)ZBValue {
    return ZBValue % 25 == 0;
}
+ (BOOL)labImgZbvalue:(NSInteger)ZBValue {
    return ZBValue % 31 == 0;
}
+ (BOOL)labDetailZbvalue:(NSInteger)ZBValue {
    return ZBValue % 45 == 0;
}
+ (BOOL)getPhonePhotoZbvalue:(NSInteger)ZBValue {
    return ZBValue % 27 == 0;
}
+ (BOOL)actionSheetClickedbuttonatindexZbvalue:(NSInteger)ZBValue {
    return ZBValue % 8 == 0;
}
+ (BOOL)imagePickerControllerDidfinishpickingmediawithinfoZbvalue:(NSInteger)ZBValue {
    return ZBValue % 28 == 0;
}
+ (BOOL)imagePickerControllerDidCancelZbvalue:(NSInteger)ZBValue {
    return ZBValue % 37 == 0;
}

@end
