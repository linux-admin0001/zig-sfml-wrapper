//! Define a point with color and texture coordinates.

const sf = @import("../sfml.zig");

position: sf.Vector2f,
color: sf.Color,
tex_coords: sf.Vector2f,