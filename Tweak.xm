#import <flipswitch/FSSwitchDataSource.h>
#import <flipswitch/FSSwitchPanel.h>
#import <libPass/libPass.h>

BOOL enabled = YES;

@interface alwaysunlockSwitch : NSObject <FSSwitchDataSource>
@end

@interface alwaysunlock : NSObject <LibPassDelegate>
@end

@implementation alwaysunlock
-(BOOL)shouldAllowPasscode:(NSString*)password
{
    return enabled ? YES : NO;
}
@end

@implementation alwaysunlockSwitch
-(FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}
-(void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	switch (newState){
	case FSSwitchStateIndeterminate: return;
		case FSSwitchStateOff: { enabled = NO; return; }
		case FSSwitchStateOn: { enabled = YES; return; }

	}
}
- (NSString *)titleForSwitchIdentifier:(NSString *)switchIdentifier {
        return @"alwaysunlock";
}
@end

%ctor
{
    [[LibPass sharedInstance] registerDelegate:[[[alwaysunlock alloc] init] retain]];
}