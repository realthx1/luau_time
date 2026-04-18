--!native
--!optimize 2

local merge = require("./utils/composition").merge

--- Functions for the Stopwatch struct.
local mod = {}
local scope = {}

--[=[
    A Stopwatch is a struct that tracks elapsed time when started.

    To advance the stopwatch `tick()` MUST be called.
]=]
export type Stopwatch = RawStopwatch & typeof(scope)
export type RawStopwatch = {
	_elapsed: number,
	_is_paused: boolean,
}

local function from_raw(data: RawStopwatch): Stopwatch
	return merge(data, scope)
end

--[=[
    Creates a new stopwatch with a specific number of seconds advanced.
    Stopwatches can be used to track much time has advanced.
    Stopwatches can be paused using `pause()` to prevent it from advancing.

    Refer to [/examples/stopwatch.luau](../examples/stopwatch.luau) for a practical example.

    @param sec -- Seconds to set elapsed to.
    @return A new stopwatch.
]=]
local function from_seconds(sec: number): Stopwatch
	return from_raw({
		_elapsed = sec,
		_is_paused = false,
	})
end

--[=[
    Creates a new stopwatch with elapsed time set to 0.

    Check `from_seconds` for more information.

    @return A new stopwatch.
]=]
local function new(): Stopwatch
	return from_seconds(0)
end

--[=[
    Resets the stopwatch, setting elapsed to 0.
    This does not change is_paused.
]=]
local function reset(self: Stopwatch)
	self._elapsed = 0
end

--[=[
    Sets elapsed time of the stopwatch.

    @param sec -- a number of seconds to set elapsed time to.
]=]
local function set_elapsed(self: Stopwatch, sec: number)
	self._elapsed = sec
end

--[=[
    Pauses the stopwatch, preventing `tick()` from changing elapsed time.
]=]
local function pause(self: Stopwatch)
	self._is_paused = true
end

--[=[
    Unpauses the stopwatch, allowing `tick()` to change elapsed time.
]=]
local function unpause(self: Stopwatch)
	self._is_paused = false
end

--[=[
    Returns true if the stopwatch is paused.

    @return A boolean which indicates if the stopwatch is paused.
]=]
local function is_paused(self: Stopwatch): boolean
	return self._is_paused
end

--[=[
    Returns elapsed time in seconds of the stopwatch.

    @return A number of seconds elapsed.
]=]
local function elapsed(self: Stopwatch): number
	return self._elapsed
end

--[=[
    Advances the stopwatch by a specific number of seconds.
    Elapsed time won't advance if the stopwatch is paused.

    @return A number of seconds elapsed.
]=]
local function tick(self: Stopwatch, sec: number)
	if self._is_paused then return end
	self._elapsed += sec
end

scope.reset = reset
scope.set_elapsed = set_elapsed
scope.pause = pause
scope.unpause = unpause
scope.is_paused = is_paused
scope.elapsed = elapsed
scope.tick = tick

mod.new = new
mod.from_seconds = from_seconds
mod._scope = scope

return mod
