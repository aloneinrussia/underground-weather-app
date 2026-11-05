# underground-weather-app
A small project i made its a weather app using a api free/opensource feel free to use it coded by me in python 100%
UNDERGROUND is a Windows desktop weather application built with Python and PySide6. It displays current conditions, forecasts, air quality, and available pollen estimates from Open-Meteo.

# feat

- Current conditions, a seven-day forecast, and a twelve-hour temperature chart
- Air quality and available pollen estimates
- Fahrenheit and Celsius
- Saved locations, adjustable text size, high contrast, reduced motion, and automatic refresh
- Keyboard shortcuts: Ctrl+L search, Ctrl+R refresh, Ctrl+, preferences, Esc clear search
- Weather-dependent animated background
- Network requests run outside the UI thread

# req

- Windows 10 or later for the packaged desktop application
- Python 3.10 or later to run from source

# rfs

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install -r requirements.txt
python main.py
```

# Build

Build a self-contained Windows executable:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\build.ps1
```

The `dist` folder contains the executable and the files needed to install it. To install the app under your local Windows account and create an `UNDERGROUND Weather` desktop shortcut, run:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\dist\install.ps1
```

The installer places the application in `%LOCALAPPDATA%\Programs\UNDERGROUND` and creates a shortcut on your desktop. Settings are stored in `%LOCALAPPDATA%\UNDERGROUND\settings.json`.

To prepare a release archive:

```powershell
New-Item -ItemType Directory -Force .\release | Out-Null
Compress-Archive -Path .\dist\* -DestinationPath .\release\UNDERGROUND-1.1.0-windows.zip -Force
```

Test the release archive and desktop shortcut on a clean Windows account before publishing.

# Weather data and limitations

Weather forecasts and air-quality estimates are provided by [Open-Meteo](https://open-meteo.com/). Availability varies by location and parameter. Pollen values may be absent; absence is displayed as unavailable, not zero. Open-Meteo is credited in the application.

The "conditions to note" text is an informational heuristic, not an official severe-weather alert service. Consult your national or local meteorological authority for official warnings.

# Accessibility

Preferences include temperature units, interface text size, reduced motion, high contrast, and automatic refresh. The app also provides keyboard shortcuts, focus outlines, accessible names for major controls, and text summaries for the chart. Screen-reader behavior can vary by Qt version and platform.
