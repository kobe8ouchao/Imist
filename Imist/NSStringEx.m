//
//  NSStringEx.m
//  audioBook
//
//  Created by fyz on 12-01-06.
//  Copyright fyz. All rights reserved.
//

#import "NSStringEx.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (C)

- (BOOL) isEmptyNull{
    if(self==nil) {
        return YES;
    }
    if([self isEqualToString:@""]) {
        return YES;
    }
    if([self length] == 0) {
        return YES;
    }
    if([[self stringByTrimmingCharactersInSet:
                [NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if([self isEqualToString:@"<nil>"]){
        return YES;
    }
    return NO;
}

- (NSString *) md5
{
	const char *cStr = [self UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			]; 
}
+(NSDate*)dateFromDateString:(NSString *)aString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dateFromString = [dateFormatter dateFromString:aString];
    return dateFromString;
}
+ (NSDate *) dateFromString: (NSString *) aString
{
    @try {
        struct tm created;
        if (strptime([aString UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([aString UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        time_t createdAt = mktime(&created);
        NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:createdAt];
        return date;

    }
    @catch (NSException *exception) {
        return nil;
    }
}
- (NSString*) urlEncodedString {
    
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          ( CFStringRef) self,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge  NSString*) encodedCFString];
    
    if(!encodedString)
        encodedString = @"";
    return encodedString;
}


@end
