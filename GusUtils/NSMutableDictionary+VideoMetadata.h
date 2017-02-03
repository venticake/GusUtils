//
//  NSMutableDictionary+VideoMetadata.h
//  Pods
//
//  Created by pisces on 03/02/2017.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NSMutableDictionary (VideoMetadataCategory)
+ (NSMutableDictionary *)dictionaryWithMetadataItems:(NSArray<AVMetadataItem *> *)items;
@property (nonatomic, readonly) NSArray<AVMetadataItem *> *metadataItems;
@end
