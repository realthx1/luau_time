--[[
    Stopwatches are used to track elapsed time.
    This example showcases how to use them.
]]

local luau_time = require("@luau_time")

local stopwatch = luau_time.stopwatch.new()

-- Stopwatches are advanced with `tick()`.
stopwatch:tick(10)

-- To check a stopwatch's elapsed time, `elapsed()` is used.
-- Output: 10
print(stopwatch:elapsed())

-- Stopwatches can be paused, preventing `tick()` from advancing them.
stopwatch:pause()
stopwatch:tick(10)
-- Output: 10
print(stopwatch:elapsed())
