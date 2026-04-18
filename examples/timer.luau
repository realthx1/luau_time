--[[
    Timers are used to track elapsed time and detect when it reaches a certain duration.
    This example showcases how timers are used.
]]

local luau_time = require("@luau_time")

-- Timers are creates with a certain duration. Once a timer reaches the duration, it enters the finished state.
local timer = luau_time.timer.new(10, false)

-- A timer is advanced with `tick()`.
timer:tick(8)

-- Output: false
print(timer:is_finished())

timer:tick(2)

-- Output: true
print(timer:is_finished())

-- To detect when a timer has finished since its last tick, `just_finished()` is used.
print(timer:just_finished())

-- Timers can be repeating.
timer:set_mode(true)

timer:tick(20)
-- Output: 2
print(timer:times_finished_this_tick())
