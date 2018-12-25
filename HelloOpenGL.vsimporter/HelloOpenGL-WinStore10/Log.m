#import "Log.h"

static void append(NSString *msg) {
	static int count = 0;

	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex : 0];
	NSString *path = [documentsDirectory stringByAppendingPathComponent : @"logfile.txt"];

	// create if needed
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
		fprintf(stderr, "Creating file at %s", [path UTF8String]);
		[[NSData data] writeToFile:path atomically : YES];
	}
	// append
	NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath : path];
	if (count == 0)
		[handle truncateFileAtOffset : 0];
	else
		[handle truncateFileAtOffset : [handle seekToEndOfFile]];
	[handle writeData : [msg dataUsingEncoding : NSUTF8StringEncoding]];
	// [handle writeData : [@"\r\n" dataUsingEncoding : NSUTF8StringEncoding]];
	[handle closeFile];
	count += 1;
}

@implementation Log

void _Log(NSString *prefix, const char *file, int lineNumber, const char *funcName, NSString *format, ...) {
	va_list ap;
	va_start(ap, format);
	format = [format stringByAppendingString : @"\n"];
	NSString *msg = [[NSString alloc] initWithFormat:[NSString stringWithFormat : @"%@", format] arguments : ap];
	va_end(ap);
	NSString* msg1 = [NSString stringWithFormat : @"%s%5s:%3d - %s", [prefix UTF8String], funcName, lineNumber, [msg UTF8String]];
	fprintf(stderr, "%s\n", [msg1 UTF8String]);
	append(msg1);
}
@end
