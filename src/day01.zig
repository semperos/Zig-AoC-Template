const std = @import("std");
const data = @embedFile("../data/day01.txt");

pub fn main() !void {
    var iter = split(u8, data, "\n");
    var line = iter.next();
    var previousValue = try parseInt(u32, line.?, 10);
    var totalUppages: u32 = 0;
    while (line != null and !std.mem.eql(u8, line.?, "")) : (line = iter.next()) {
        const num = try parseInt(u32, line.?, 10);
        if (previousValue < num) {
            totalUppages += 1;
        }
        previousValue = num;
    }
    std.log.info("Day 1, Problem 1: {d}", .{totalUppages});

    var iter2 = split(u8, data, "\n");
    var line2 = iter2.next();
    const num1 = try parseInt(u32, line2.?, 10);
    line2 = iter2.next().?;
    var num2 = try parseInt(u32, line2.?, 10);
    line2 = iter2.next().?;
    var num3 = try parseInt(u32, line2.?, 10);

    var previousWindowedValue = num1 + num2 + num3;
    var totalWindowedUppages: u32 = 0;

    while (line2 != null and !std.mem.eql(u8, line2.?, "")) : (line2 = iter2.next()) {
        const num4 = try parseInt(u32, line2.?, 10);
        const newWindowedValue = num2 + num3 + num4;
        if (previousWindowedValue < newWindowedValue) {
            totalWindowedUppages += 1;
        }
        previousWindowedValue = newWindowedValue;
        num2 = num3;
        num3 = num4;
    }
    std.log.info("Day 1, Problem 2: {d}", .{totalWindowedUppages});
}

// Useful stdlib functions
const split = std.mem.split;
const parseInt = std.fmt.parseInt;
