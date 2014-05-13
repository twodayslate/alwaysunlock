#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import "CydiaSubstrate.h"

@interface SBLockScreenManager
-(BOOL)attemptUnlockWithPasscode:(id)arg1;
@end

@interface LibPass
+(id)sharedInstance;
-(void)unlockWithCodeEnabled:(BOOL)arg1;
- (void) togglePasscode;
@end

@interface FSSwitchDataSource
@end

@interface alwaysunlockSwitch : NSObject <FSSwitchDataSource>
@end

static BOOL enabled = YES;

%hook SBLockScreenManager
-(BOOL)attemptUnlockWithPasscode:(id)arg1 {
	if(!%orig) {
		if(enabled) {
			[[%c(LibPass) sharedInstance] togglePasscode]; //this shouldn't be needed
			[[%c(LibPass) sharedInstance] unlockWithCodeEnabled:YES];
			[[%c(LibPass) sharedInstance] unlockWithCodeEnabled:NO]; //this shouldn't be needed
			return YES;
		}
	}
	return %orig;
}
%end

@implementation alwaysunlockSwitch
-(FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier{
	return (enabled?FSSwitchStateOn:FSSwitchStateOff);
}
-(void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier{
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