local luau_time = require("../src")

local time = luau_time.time.new()
local stopwatch = luau_time.stopwatch.new()

time:advance_by(10)

assert(time:delta() == 10)

time:advance_by(17)

assert(time:elapsed() == 27)

time:set_wrap_period(5)

assert(time:elapsed_wrapped() == 2)

stopwatch:tick(10)

assert(stopwatch:elapsed() == 10)

stopwatch:pause()
stopwatch:tick(10)
assert(stopwatch:elapsed() == 10)

local timer = luau_time.timer.new(10, false)

timer:tick(8)

assert(timer:is_finished() == false)

timer:tick(2)

assert(timer:is_finished() == true)

assert(timer:just_finished() == true)

timer:set_mode(true)

timer:tick(20)
assert(timer:times_finished_this_tick() == 2)
