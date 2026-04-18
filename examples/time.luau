--[[
    Time is a generic clock which is used to track time.
    This example showcases how it can be used.
]]

local luau_time = require("@luau_time")

local time = luau_time.time.new()

-- To advance a clock `advance_by` and `advance_to` are used.
-- The clock is advanced by 10 seconds.
time:advance_by(10)

-- To check how much a clock has advanced `delta()` is used.
-- Output: 10
print(time:delta())

time:advance_by(17)

-- To check how much a clock has advanced in total `elapsed()` is used.
-- Output: 27
print(time:elapsed())

-- A clock's time can be wrapped by a modulus. The modulus is set with `set_wrap_period()`.
-- By default wrap period is set to 3600 seconds.
time:set_wrap_period(5)

-- Output: 2
print(time:elapsed_wrapped())
