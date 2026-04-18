--!native
--!optimize 2

local merge = require("./utils/composition").merge

--- Functions for the Time struct.
local mod = {}
local scope = {}

--- A generic clock that tracks how much it has advanced since its previous update and since its creation.
export type Time = RawTime & typeof(scope)
export type RawTime = {
	--- The number of seconds the clock advanced by since the last update.
	_delta: number,
	--- The number of seconds the clock has advanced by in total.
	_elapsed: number,
	--- The modulus used to calculate the elapsed_wrapped, defaults to 3600 seconds.
	_wrap_period: number,
	--- The number of seconds the clock has advanced by in total, module the wrap_period.
	_elapsed_wrapped: number,
}

local function from_raw(data: RawTime): Time
	return merge(data, scope)
end

--[=[
    Creates a new clock with a specific number of seconds elapsed.
    Clocks are updated manually with either `advance_by` or `advance_to` functions.
    The modulus used to calculate `elapsed_wrapped` can be set using `set_wrap_period`.

    Refer to [/examples/time.luau](./examples/time.luau) for a practical example.

    @param sec -- Seconds to advance a new clock to.
    @return A new clock.
]=]
local function from_seconds(sec: number): Time
	return from_raw({
		_delta = 0,
		_elapsed = sec,
		_wrap_period = 3600,
		_elapsed_wrapped = sec,
	})
end

--[=[
    Creates a new clock with elapsed and delta set to 0.

    Check `from_seconds` for more information.

    @return A new clock.
]=]
local function new(): Time
	return from_seconds(0)
end

--[=[
    Advances the clock by a specific number of seconds.

    @param sec -- Seconds to advance the clock by.
]=]
local function advance_by(self: Time, sec: number)
	local elapsed = self._elapsed + sec
	local wrap_period = self._wrap_period
	local elapsed_wrapped = (self._elapsed_wrapped + sec) % wrap_period

	self._elapsed = elapsed
	self._elapsed_wrapped = elapsed_wrapped
	self._delta = sec
end

--[=[
    Advances the clock to a specific number of seconds.

    @param sec -- Seconds to advance the clock to.
]=]
local function advance_to(self: Time, sec: number)
	local delta = sec - self._elapsed
	local wrap_period = self._wrap_period

	self._delta = delta
	self._elapsed = sec
	self._wrap_period = wrap_period
	self._elapsed_wrapped = sec % wrap_period
end

--[=[
    Sets the clock's modulus used for calculating `elapsed_wrapped` to a new number in seconds.

    @param sec -- Number of seconds to set the modulus to.
]=]
local function set_wrap_period(self: Time, period: number)
	local elapsed_wrapped: number = self._elapsed_wrapped % period

	self._wrap_period = period
	self._elapsed_wrapped = elapsed_wrapped
end

--[=[
    Returns the modulus used for calculating `elapsed_wrapped` of the clock.

    @return Wrap period as a number of seconds.
]=]
local function wrap_period(self: Time): number
	return self._wrap_period
end

--[=[
    Returns how much time has advanced in total.

    @return Elapsed time as a number of seconds.
]=]
local function elapsed(self: Time): number
	return self._elapsed
end

--[=[
    Returns how much time has advanced in total module the `wrap_period`.

    @return Wrapped elapsed time as a number of seconds.
]=]
local function elapsed_wrapped(self: Time): number
	return self._elapsed_wrapped
end

--[=[
    Returns how much time has advanced since last update of the clock.

    @return Delta time as a number of seconds.
]=]
local function delta(self: Time): number
	return self._delta
end

scope.wrap_period = wrap_period
scope.elapsed = elapsed
scope.elapsed_wrapped = elapsed_wrapped
scope.delta = delta
scope.advance_by = advance_by
scope.advance_to = advance_to
scope.set_wrap_period = set_wrap_period

mod.new = new
mod.from_seconds = from_seconds
mod._scope = scope

return mod
