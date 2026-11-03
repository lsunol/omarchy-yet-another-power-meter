# Yet Another Power Meter

An [Omarchy](https://omarchy.org/) bar widget that shows the laptop's
instantaneous power draw in watts, so you can see what drains your battery.

![screenshot](screenshot.png)

- Discharging: `8.7 W`. Charging: `+25.0 W`.
- Reads `/sys/class/power_supply/BAT0/power_now` every 3 seconds.
- Fixed-width slot, so the neighbouring widgets never shift.
- Uses the bar's own font and size.

## Install

```bash
omarchy plugin add https://github.com/lsunol/omarchy-yet-another-power-meter.git --enable
omarchy restart shell
```

Update with `omarchy plugin update`, remove with `omarchy plugin remove yet-another-power-meter`.

## Notes

- The battery is hardcoded to `BAT0`. Edit `Widget.qml` if yours is named differently.
- If you edit the widget, run `omarchy restart shell`: hot reload may keep the old QML.

## License

MIT
