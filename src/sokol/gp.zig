const sg = @import("gfx.zig");
const std = @import("std");

pub const Error = enum(i32) {
    SGP_NO_ERROR = 0,
    SGP_ERROR_SOKOL_INVALID = 1,
    SGP_ERROR_VERTICES_FULL = 2,
    SGP_ERROR_UNIFORMS_FULL = 3,
    SGP_ERROR_COMMANDS_FULL = 4,
    SGP_ERROR_VERTICES_OVERFLOW = 5,
    SGP_ERROR_TRANSFORM_STACK_OVERFLOW = 6,
    SGP_ERROR_TRANSFORM_STACK_UNDERFLOW = 7,
    SGP_ERROR_STATE_STACK_OVERFLOW = 8,
    SGP_ERROR_STATE_STACK_UNDERFLOW = 9,
    SGP_ERROR_ALLOC_FAILED = 10,
    SGP_ERROR_MAKE_VERTEX_BUFFER_FAILED = 11,
    SGP_ERROR_MAKE_WHITE_IMAGE_FAILED = 12,
    SGP_ERROR_MAKE_NEAREST_SAMPLER_FAILED = 13,
    SGP_ERROR_MAKE_COMMON_SHADER_FAILED = 14,
    SGP_ERROR_MAKE_COMMON_PIPELINE_FAILED = 15,
};
pub const Blendmode = enum(i32) {
    SGP_BLENDMODE_NONE = 0,
    SGP_BLENDMODE_BLEND = 1,
    SGP_BLENDMODE_ADD = 2,
    SGP_BLENDMODE_MOD = 3,
    SGP_BLENDMODE_MUL = 4,
    _SGP_BLENDMODE_NUM = 5,
};

pub const VertexAttributeLocation = enum(i32) {
    SGP_VS_ATTR_COORD = 0,
    SGP_VS_ATTR_COLOR = 1,
};

pub const ISize = extern struct {
    w: i32 = 0,
    h: i32 = 0,
};
pub const IRect = extern struct {
    x: i32 = 0,
    y: i32 = 0,
    w: i32 = 0,
    h: i32 = 0,
};
pub const Rect = extern struct {
    x: f32 = 0,
    y: f32 = 0,
    w: f32 = 0,
    h: f32 = 0,
};
pub const TexturedRect = extern struct {
    dst: Rect = std.mem.zeroes(Rect),
    src: Rect = std.mem.zeroes(Rect),
};
pub const Vec2 = extern struct {
    x: f32 = 0,
    y: f32 = 0,
};
pub const Point = Vec2;
pub const Line = extern struct {
    a: Point = std.mem.zeroes(Point),
    b: Point = std.mem.zeroes(Point),
};
pub const Triangle = extern struct {
    a: Point = std.mem.zeroes(Point),
    b: Point = std.mem.zeroes(Point),
    c: Point = std.mem.zeroes(Point),
};
pub const Mat2x3 = extern struct {
    v: [2][3]f32 = std.mem.zeroes([2][3]f32),
};
pub const Color = extern struct {
    r: f32 = 0,
    g: f32 = 0,
    b: f32 = 0,
    a: f32 = 0,
};
pub const ColorU8 = extern struct {
    r: u8 = 0,
    g: u8 = 0,
    b: u8 = 0,
    a: u8 = 0,
};
pub const Vertex = extern struct {
    position: Vec2 = std.mem.zeroes(Vec2),
    texcoord: Vec2 = std.mem.zeroes(Vec2),
    color: ColorU8 = std.mem.zeroes(ColorU8),
};
pub const Uniform = extern struct {
    size: u32 = 0,
    content: [4]f32 = std.mem.zeroes([4]f32),
};
pub const TexturesUniform = extern struct {
    count: u32 = 0,
    images: [4]sg.Image = std.mem.zeroes([4]sg.Image),
    samplers: [4]sg.Sampler = std.mem.zeroes([4]sg.Sampler),
};
pub const State = extern struct {
    frame_size: ISize = std.mem.zeroes(ISize),
    viewport: IRect = std.mem.zeroes(IRect),
    scissor: IRect = std.mem.zeroes(IRect),
    proj: Mat2x3 = std.mem.zeroes(Mat2x3),
    transform: Mat2x3 = std.mem.zeroes(Mat2x3),
    mvp: Mat2x3 = std.mem.zeroes(Mat2x3),
    thickness: f32 = 0,
    color: ColorU8 = std.mem.zeroes(ColorU8),
    textures: TexturesUniform = std.mem.zeroes(TexturesUniform),
    uniform: Uniform = std.mem.zeroes(Uniform),
    blend_mode: Blendmode = std.mem.zeroes(Blendmode),
    pipeline: sg.Pipeline = std.mem.zeroes(sg.Pipeline),
    _base_vertex: u32 = 0,
    _base_uniform: u32 = 0,
    _base_command: u32 = 0,
};
pub const Desc = extern struct {
    max_vertices: u32 = 0,
    max_commands: u32 = 0,
    color_format: sg.PixelFormat = std.mem.zeroes(sg.PixelFormat),
    depth_format: sg.PixelFormat = std.mem.zeroes(sg.PixelFormat),
    sample_count: i32 = 0,
};
pub const PipelineDesc = extern struct {
    shader: sg.Shader = std.mem.zeroes(sg.Shader),
    primitive_type: sg.PrimitiveType = std.mem.zeroes(sg.PrimitiveType),
    blend_mode: Blendmode = std.mem.zeroes(Blendmode),
    color_format: sg.PixelFormat = std.mem.zeroes(sg.PixelFormat),
    depth_format: sg.PixelFormat = std.mem.zeroes(sg.PixelFormat),
    sample_count: i32 = 0,
    has_vs_color: bool = false,
};
extern fn sgp_setup(desc: [*c]const Desc) void;
pub fn setup(desc: Desc) void {
    sgp_setup(&desc);
}

extern fn sgp_shutdown() void;
pub fn shutdown() void {
    return sgp_shutdown();
}

extern fn sgp_is_valid() bool;
pub fn isValid() bool {
    return sgp_is_valid();
}

extern fn sgp_get_last_error() Error;
pub fn getLastError() Error {
    return sgp_get_last_error();
}

extern fn sgp_get_error_message(err: Error) [*c]const u8;
pub fn getErrorMessage(err: Error) [:0]const u8 {
    return std.mem.span(sgp_get_error_message(err));
}

extern fn sgp_make_pipeline(desc: [*c]const PipelineDesc) sg.Pipeline;
pub fn makePipeline(desc: PipelineDesc) sg.Pipeline {
    return sgp_make_pipeline(&desc);
}

extern fn sgp_begin(width: i32, height: i32) void;
pub fn begin(width: i32, height: i32) void {
    return sgp_begin(width, height);
}

extern fn sgp_flush() void;
pub fn flush() void {
    return sgp_flush();
}

extern fn sgp_end() void;
pub fn end() void {
    return sgp_end();
}

extern fn sgp_project(left: f32, right: f32, top: f32, bottom: f32) void;
pub fn project(left: f32, right: f32, top: f32, bottom: f32) void {
    return sgp_project(left, right, top, bottom);
}

extern fn sgp_reset_project() void;
pub fn resetProject() void {
    return sgp_reset_project();
}

extern fn sgp_push_transform() void;
pub fn pushTransform() void {
    return sgp_push_transform();
}

extern fn sgp_pop_transform() void;
pub fn popTransform() void {
    return sgp_pop_transform();
}

extern fn sgp_reset_transform() void;
pub fn resetTransform() void {
    return sgp_reset_transform();
}

extern fn sgp_translate(x: f32, y: f32) void;
pub fn translate(x: f32, y: f32) void {
    return sgp_translate(x, y);
}

extern fn sgp_rotate(theta: f32) void;
pub fn rotate(theta: f32) void {
    return sgp_rotate(theta);
}

extern fn sgp_rotate_at(theta: f32, x: f32, y: f32) void;
pub fn rotateAt(theta: f32, x: f32, y: f32) void {
    return sgp_rotate_at(theta, x, y);
}

extern fn sgp_scale(sx: f32, sy: f32) void;
pub fn scale(sx: f32, sy: f32) void {
    return sgp_scale(sx, sy);
}

extern fn sgp_scale_at(sx: f32, sy: f32, x: f32, y: f32) void;
pub fn scaleAt(sx: f32, sy: f32, x: f32, y: f32) void {
    return sgp_scale_at(sx, sy, x, y);
}

extern fn sgp_set_pipeline(pipeline: sg.Pipeline) void;
pub fn setPipeline(pipeline: sg.Pipeline) void {
    return sgp_set_pipeline(pipeline);
}

extern fn sgp_reset_pipeline() void;
pub fn resetPipeline() void {
    return sgp_reset_pipeline();
}

extern fn sgp_set_uniform(data: ?*const anyopaque, size: u32) void;
pub fn setUniform(data: ?*const anyopaque, size: u32) void {
    return sgp_set_uniform(data, size);
}

extern fn sgp_reset_uniform() void;
pub fn resetUniform() void {
    return sgp_reset_uniform();
}

extern fn sgp_set_blend_mode(blend_mode: Blendmode) void;
pub fn setBlendMode(blend_mode: Blendmode) void {
    return sgp_set_blend_mode(blend_mode);
}

extern fn sgp_reset_blend_mode() void;
pub fn resetBlendMode() void {
    return sgp_reset_blend_mode();
}

extern fn sgp_set_color(r: f32, g: f32, b: f32, a: f32) void;
pub fn setColor(r: f32, g: f32, b: f32, a: f32) void {
    return sgp_set_color(r, g, b, a);
}

extern fn sgp_reset_color() void;
pub fn resetColor() void {
    return sgp_reset_color();
}

extern fn sgp_set_image(channel: i32, image: sg.Image) void;
pub fn setImage(channel: i32, image: sg.Image) void {
    return sgp_set_image(channel, image);
}

extern fn sgp_unset_image(channel: i32) void;
pub fn unsetImage(channel: i32) void {
    return sgp_unset_image(channel);
}

extern fn sgp_reset_image(channel: i32) void;
pub fn resetImage(channel: i32) void {
    return sgp_reset_image(channel);
}

extern fn sgp_set_sampler(channel: i32, sampler: sg.Sampler) void;
pub fn setSampler(channel: i32, sampler: sg.Sampler) void {
    return sgp_set_sampler(channel, sampler);
}

extern fn sgp_reset_sampler(channel: i32) void;
pub fn resetSampler(channel: i32) void {
    return sgp_reset_sampler(channel);
}

extern fn sgp_viewport(x: i32, y: i32, w: i32, h: i32) void;
pub fn viewport(x: i32, y: i32, w: i32, h: i32) void {
    return sgp_viewport(x, y, w, h);
}

extern fn sgp_reset_viewport() void;
pub fn resetViewport() void {
    return sgp_reset_viewport();
}

extern fn sgp_scissor(x: i32, y: i32, w: i32, h: i32) void;
pub fn scissor(x: i32, y: i32, w: i32, h: i32) void {
    return sgp_scissor(x, y, w, h);
}

extern fn sgp_reset_scissor() void;
pub fn resetScissor() void {
    return sgp_reset_scissor();
}

extern fn sgp_reset_state() void;
pub fn resetState() void {
    return sgp_reset_state();
}

extern fn sgp_clear() void;
pub fn clear() void {
    return sgp_clear();
}

extern fn sgp_draw(primitive_type: sg.PrimitiveType, vertices: [*c]const Vertex, count: u32) void;
pub fn draw(primitive_type: sg.PrimitiveType, vertices: [*c]const Vertex, count: u32) void {
    return sgp_draw(primitive_type, vertices, count);
}

extern fn sgp_draw_points(points: [*c]const Point, count: u32) void;
pub fn drawPoints(points: []const Point) void {
    return sgp_draw_points(@ptrCast(points.ptr), @intCast(points.len));
}

extern fn sgp_draw_point(x: f32, y: f32) void;
pub fn drawPoint(x: f32, y: f32) void {
    return sgp_draw_point(x, y);
}

extern fn sgp_draw_lines(lines: [*c]const Line, count: u32) void;
pub fn drawLines(lines: []const Line) void {
    return sgp_draw_lines(@ptrCast(lines.ptr), @intCast(lines.len));
}

extern fn sgp_draw_line(ax: f32, ay: f32, bx: f32, by: f32) void;
pub fn drawLine(ax: f32, ay: f32, bx: f32, by: f32) void {
    return sgp_draw_line(ax, ay, bx, by);
}

extern fn sgp_draw_lines_strip(points: [*c]const Point, count: u32) void;
pub fn drawLinesStrip(points: []const Point) void {
    return sgp_draw_lines_strip(@ptrCast(points.ptr), @intCast(points.len));
}

extern fn sgp_draw_filled_triangles(triangles: [*c]const Triangle, count: u32) void;
pub fn drawFilledTriangles(triangles: []const Triangle, count: u32) void {
    return sgp_draw_filled_triangles(@ptrCast(triangles.ptr), count);
}

extern fn sgp_draw_filled_triangle(ax: f32, ay: f32, bx: f32, by: f32, cx: f32, cy: f32) void;
pub fn drawFilledTriangle(ax: f32, ay: f32, bx: f32, by: f32, cx: f32, cy: f32) void {
    return sgp_draw_filled_triangle(ax, ay, bx, by, cx, cy);
}

extern fn sgp_draw_filled_triangles_strip(points: [*c]const Point, count: u32) void;
pub fn drawFilledTrianglesStrip(points: []const Point) void {
    return sgp_draw_filled_triangles_strip(@ptrCast(points.ptr), @intCast(points.len));
}

extern fn sgp_draw_filled_rects(rects: [*c]const Rect, count: u32) void;
pub fn drawFilledRects(rects: []const Rect) void {
    return sgp_draw_filled_rects(@ptrCast(rects.ptr), @intCast(rects.len));
}

extern fn sgp_draw_filled_rect(x: f32, y: f32, w: f32, h: f32) void;
pub fn drawFilledRect(x: f32, y: f32, w: f32, h: f32) void {
    return sgp_draw_filled_rect(x, y, w, h);
}

extern fn sgp_draw_textured_rects(channel: i32, rects: [*c]const TexturedRect, count: u32) void;
pub fn drawTexturedRects(channel: i32, rects: []const TexturedRect) void {
    return sgp_draw_textured_rects(channel, @ptrCast(rects.ptr), @intCast(rects.len));
}

extern fn sgp_draw_textured_rect(channel: i32, dest_rect: Rect, src_rect: Rect) void;
pub fn drawTexturedRect(channel: i32, dest_rect: Rect, src_rect: Rect) void {
    return sgp_draw_textured_rect(channel, dest_rect, src_rect);
}

extern fn sgp_query_state() [*c]State;
pub fn queryState() *State {
    return @ptrCast(sgp_query_state());
}

extern fn sgp_query_desc() Desc;
pub fn queryDesc() Desc {
    return sgp_query_desc();
}
