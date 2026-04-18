--!optimize 2
--!native

local time_mod = require("@self/time")
local timer_mod = require("@self/timer")
local stopwatch_mod = require("@self/stopwatch")

--- Time-related structures and utilities.
local prelude = {}

prelude.time = time_mod
prelude.timer = timer_mod
prelude.stopwatch = stopwatch_mod

export type RawTime = time_mod.RawTime
export type Time = time_mod.Time
export type RawTimer = timer_mod.RawTimer
export type Timer = timer_mod.Timer
export type RawStopwatch = stopwatch_mod.RawStopwatch
export type Stopwatch = stopwatch_mod.Stopwatch

return prelude
