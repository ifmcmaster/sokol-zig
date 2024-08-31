pub const fontstash = @import("fontstash/fontstash.zig");

pub const Allocator = extern struct {
    alloc_fn: ?*const fn (size: usize, user_data: ?*anyopaque) void = null,
    free_fn: ?*const fn (ptr: *anyopaque, user_data: ?*anyopaque) void = null,
    user_data: ?*anyopaque = null,
};

pub const Desc = extern struct {
    width: i32, // initial width of font atlas texture (default: 512, must be power of 2)
    height: i32, // initial height of font atlas texture (default: 512, must be power of 2)
    allocator: Allocator = .{}, // optional memory allocation overrides
};

extern fn sfons_create(desc: *const Desc) *fontstash.Context;
pub fn create(desc: *const Desc) *fontstash.Context {
    return sfons_create(desc);
}

extern fn sfons_flush(ctx: *fontstash.Context) void;
pub fn flush(ctx: *fontstash.Context) void {
    sfons_flush(ctx);
}

extern fn sfons_destroy(ctx: *fontstash.Context) void;
pub fn destroy(ctx: *fontstash.Context) void {
    sfons_destroy(ctx);
}

extern fn sfons_rgba(r: u8, g: u8, b: u8, a: u8) u32;
pub fn rgba(r: u8, g: u8, b: u8, a: u8) u32 {
    return sfons_rgba(r, g, b, a);
}
