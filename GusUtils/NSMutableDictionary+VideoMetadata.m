//
//  NSMutableDictionary+VideoMetadata.m
//  Pods
//
//  Created by pisces on 03/02/2017.
//
//

#import "NSMutableDictionary+VideoMetadata.h"
#import "NSMutableDictionary+ImageMetadata.h"

@implementation NSMutableDictionary (VideoMetadataCategory)

#pragma mark - For video metadata

+ (NSMutableDictionary *)dictionaryWithMetadataItems:(NSArray<AVMetadataItem *> *)items {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    for (AVMetadataItem *item in items) {
        if ([item.commonKey isEqualToString:AVMetadataCommonKeyLocation]) {
            NSString *locationString = (NSString *) item.value;
            if (locationString.length >= 16) {
                NSString *latitude  = [locationString substringToIndex:8];
                NSString *longitude = [locationString substringWithRange:NSMakeRange(8, 9)];
                CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude.doubleValue longitude:longitude.doubleValue];
                [dict setLocation:location];
            }
        } else if ([item.commonKey isEqualToString:AVMetadataCommonKeyDescription]) {
            [dict setDescription:item.value];
        }
    }
    
    return dict;
}

- (NSArray *)metadataItems {
    CLLocationCoordinate2D coordinate = self.location.coordinate;
    
    AVMutableMetadataItem *locationItem = [[AVMutableMetadataItem alloc] init];
    locationItem.key = AVMetadataCommonKeyLocation;
    locationItem.keySpace = AVMetadataKeySpaceCommon;
    locationItem.locale = [NSLocale currentLocale];
    locationItem.value = [NSString stringWithFormat:@"%+08.8lf%+09.8lf", coordinate.latitude, coordinate.longitude];
    
    AVMutableMetadataItem *descriptionItem = [[AVMutableMetadataItem alloc] init];
    descriptionItem.key = AVMetadataCommonKeyDescription;
    descriptionItem.keySpace = AVMetadataKeySpaceCommon;
    descriptionItem.value = self.description;
    
    return @[locationItem, descriptionItem];
}

@end
