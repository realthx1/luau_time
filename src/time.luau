--!native

--- A generic clock that tracks how much it has advanced since its previous update and since its creation.
export type Time = {
	--- The number of seconds the clock advanced by since the last update.
	read delta: number,
	--- The number of seconds the clock has advanced by in total.
	read elapsed: number,
	--- The modulus used to calculate the elapsed_wrapped, defaults to math.huge.
	read wrap_period: number,
	--- The number of seconds the clock has advanced by in total, module the wrap_period.
	read elapsed_wrapped: number,
}

--[=[
    A generic clock that tracks how much it has advanced since its previous update and since its creation.

    Usage example:
    ```luau
        TODO
    ```
]=]
local mod = {}

--- Creates a new clock with elapsed set to a number of seconds.
--- @param sec -- Seconds to set elapsed to.
--- @return New clock.
local function from_seconds(sec: number): Time
	return {
		delta = 0,
		elapsed = sec,
		wrap_period = math.huge,
		elapsed_wrapped = sec,
	}
end

--- Copies the clock and advances it by a specific number of seconds.
--- @param sec -- Seconds to advance a clock by.
--- @return New clock.
local function advance_by(target: Time, sec: number): Time
	local elapsed: number = target.elapsed + sec
	local wrap_period = target.wrap_period
	local elapsed_wrapped: number = (target.elapsed_wrapped + sec) % wrap_period
	return {
		delta = sec,
		elapsed = elapsed,
		wrap_period = wrap_period,
		elapsed_wrapped = elapsed_wrapped,
	}
end

--- Copies a clock and advances it to a specific number of seconds.
--- @param sec -- Seconds to advance a clock to.
--- @return New clock.
local function advance_to(target: Time, sec: number): Time
	local delta: number = sec - target.elapsed
	local wrap_period: number = target.wrap_period
	return {
		delta = delta,
		elapsed = sec,
		wrap_period = wrap_period,
		elapsed_wrapped = sec % wrap_period,
	}
end

--- Copies a clock and sets its wrap_period to a new value in seconds.
--- @param sec -- Number of seconds to set wrap_period to.
--- @return New clock.
local function set_wrap_period(target: Time, period: number): Time
	local elapsed_wrapped: number = target.elapsed_wrapped % period
	return {
		delta = target.delta,
		elapsed = target.elapsed,
		wrap_period = period,
		elapsed_wrapped = elapsed_wrapped,
	}
end

mod.from_seconds = from_seconds
mod.advance_by = advance_by
mod.advance_to = advance_to
mod.set_wrap_period = set_wrap_period

return mod
