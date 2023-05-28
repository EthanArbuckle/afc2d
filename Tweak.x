#import <Foundation/Foundation.h>
#import <dlfcn.h>

static void *orig_AFCServerContextSetRootPath;
static void AFCServerContextSetRootPath_hook(void *ctx, NSString *path) {

    if (path != NULL && [path containsString:@"/private/var/mobile/Media"]) {
        ((void (*)(void *, id))orig_AFCServerContextSetRootPath)(ctx, @"/");
        return;
    }

    ((void (*)(void *, id))orig_AFCServerContextSetRootPath)(ctx, path);
}

static void (*_MSHookFunction)(void *symbol, void *replace, void **result);
%ctor {

    void *lhHandle = dlopen("/fs/jb/Library/Frameworks/CydiaSubstrate.framework/CydiaSubstrate", 0);
    if (lhHandle) {
        
        _MSHookFunction = dlsym(lhHandle, "MSHookFunction");
        
        void *AFCServerContextSetRootPath = dlsym(dlopen("/usr/lib/libafc.dylib", 0), "AFCServerContextSetRootPath");
        if (AFCServerContextSetRootPath) {
            _MSHookFunction(AFCServerContextSetRootPath, (void *)AFCServerContextSetRootPath_hook, (void **)&orig_AFCServerContextSetRootPath);
        }
    }
}