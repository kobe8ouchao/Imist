//
//  NSStringEx.h
//  audioBook
//
//  Created by fyz on 12-01-06.
//  Copyright fyz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (C)
- (BOOL) isEmptyNull;
- (NSString *) md5;
+(NSDate*)dateFromDateString:(NSString *)aString;
+ (NSDate *) dateFromString: (NSString *) aString;
- (NSString*) urlEncodedString;
@end
