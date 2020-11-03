//! Specialized shape representing a rectangle.

const sf = @import("../sfml.zig");

pub const RectangleShape = struct {
    const Self = @This();

    // Constructor/destructor

    /// Creates a rectangle shape with a size. The rectangle will be white
    pub fn init(size: sf.Vector2f) !Self {
        var rect = sf.c.sfRectangleShape_create();
        if (rect == null)
            return sf.Error.nullptrUnknownReason;

        sf.c.sfRectangleShape_setFillColor(rect, sf.c.sfWhite);
        sf.c.sfRectangleShape_setSize(rect, size.toCSFML());

        return Self{ .ptr = rect.? };
    }

    /// Destroys a rectangle shape
    pub fn deinit(self: Self) void {
        sf.c.sfRectangleShape_destroy(self.ptr);
    }

    // Getters/setters

    /// Gets the fill color of this rectangle shape
    pub fn getFillColor(self: Self) sf.Color {
        return sf.Color.fromCSFML(sf.c.sfRectangleShape_getFillColor(self.ptr));
    }
    /// Sets the fill color of this rectangle shape
    pub fn setFillColor(self: Self, color: sf.Color) void {
        sf.c.sfRectangleShape_setFillColor(self.ptr, color.toCSFML());
    }

    /// Gets the size of this rectangle shape
    pub fn getSize(self: Self) sf.Vector2f {
        return sf.Vector2f.fromCSFML(sf.c.sfRectangleShape_getSize(self.ptr));
    }
    /// Sets the size of this rectangle shape
    pub fn setSize(self: Self, size: sf.Vector2f) void {
        sf.c.sfRectangleShape_setSize(self.ptr, size.toCSFML());
    }

    /// Gets the position of this rectangle shape
    pub fn getPosition(self: Self) sf.Vector2f {
        return sf.Vector2f.fromCSFML(sf.c.sfRectangleShape_getPosition(self.ptr));
    }
    /// Sets the position of this rectangle shape
    pub fn setPosition(self: Self, pos: sf.Vector2f) void {
        sf.c.sfRectangleShape_setPosition(self.ptr, pos.toCSFML());
    }

    /// Gets the origin of this rectangle shape
    pub fn getOrigin(self: Self) sf.Vector2f {
        return sf.Vector2f.fromCSFML(sf.c.sfRectangleShape_getOrigin(self.ptr));
    }
    /// Sets the origin of this rectangle shape
    pub fn setOrigin(self: Self, origin: sf.Vector2f) void {
        sf.c.sfRectangleShape_setOrigin(self.ptr, origin.toCSFML());
    }

    /// Gets the rotation of this rectangle shape
    pub fn getRotation(self: Self) f32 {
        return sf.c.sfRectangleShape_getRotation(self.ptr);
    }
    /// Sets the rotation of this rectangle shape
    pub fn setRotation(self: Self, angle: f32) void {
        sf.c.sfRectangleShape_setRotation(self.ptr, angle);
    }

    /// Gets the texture of this shape
    pub fn getTexture(self: Self) ?sf.Texture {
        var t = sf.c.sfRectangleShape_getTexture(self.ptr);
        if (t != null) {
            return sf.Texture{ .const_ptr = t.? };
        } else
            return null;
    }
    /// Sets the texture of this shape
    pub fn setTexture(self: Self, texture: sf.Texture) void {
        sf.c.sfRectangleShape_setTexture(self.ptr, texture.get(), 0);
    }
    /// Gets the sub-rectangle of the texture that the shape will display
    pub fn getTextureRect(self: Self) sf.FloatRect {
        return sf.FloatRect.fromCSFML(sf.c.sfRectangleShape_getTextureRect(self.ptr));
    }
    /// Sets the sub-rectangle of the texture that the shape will display
    pub fn setTextureRect(self: Self, rect: sf.FloatRect) void {
        sf.c.sfRectangleShape_getTextureRect(self.ptr, rect.toCSFML());
    }

    /// Pointer to the csfml structure
    ptr: *sf.c.sfRectangleShape
};

const tst = @import("std").testing;

test "rectangle shape: sane getters and setters" {
    var rect = try RectangleShape.init(sf.Vector2f{ .x = 30, .y = 50 });
    defer rect.deinit();

    tst.expectEqual(sf.Vector2f{ .x = 30, .y = 50 }, rect.getSize());

    rect.setFillColor(sf.Color.Yellow);
    rect.setSize(.{ .x = 15, .y = 510 });
    rect.setRotation(15);
    rect.setPosition(.{ .x = 1, .y = 2 });
    rect.setOrigin(.{ .x = 20, .y = 25 });

    // TODO : issue #2
    //tst.expectEqual(sf.c.sfYellow, rect.getFillColor());
    tst.expectEqual(sf.Vector2f{ .x = 15, .y = 510 }, rect.getSize());
    tst.expectEqual(@as(f32, 15), rect.getRotation());
    tst.expectEqual(sf.Vector2f{ .x = 1, .y = 2 }, rect.getPosition());
    tst.expectEqual(sf.Vector2f{ .x = 20, .y = 25 }, rect.getOrigin());
    // TODO : find why that doesn't work
    //tst.expectEqual(@as(?sf.Texture, null), rect.getTexture());
}
