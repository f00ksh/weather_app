# Weather App – Google Pixel Weather Clone ☁️📱

A modern Flutter weather application inspired by the **Google Pixel Weather app**, delivering accurate forecasts with a sleek and customizable interface.



## Features

- **Real-time Weather Data:** Get current weather conditions including temperature, "feels like," humidity, wind speed, and more.
- **10-Day Forecast:** Plan ahead with detailed daily forecasts.
- **Customizable Dashboard:** Arrange weather information cards to suit your preferences.
- **Multiple Locations:** Save and track weather for multiple cities.
- **Background Updates:** Receive weather notifications even when the app is closed.
- **Dynamic Theming:** Automatically switches between light and dark themes based on the time of day.

## Technologies Used

### Weather Data

- **Open Meteo** is used as the weather data provider.
  - Free and open-source API
  - No API key required
  - High-precision 7-day forecasts (with global coverage)
  - Hourly and daily weather variables

### Weather Icons

- Official **Google Weather Icons** from [`mrdarrengriffin/google-weather-icons`](https://github.com/mrdarrengriffin/google-weather-icons)
  - High-quality SVG and PNG formats
  - Day and night variations
  - Comprehensive set of weather conditions
  - Consistent design language




## Project Structure

```
weather_app/
├── assets/                  # App assets (icons, animations)
├── lib/                     # Source code
│   ├── core/                # Core functionality
│   │   ├── routes/          # App navigation
│   │   ├── shared/          # Shared widgets
│   │   └── theme/           # App theming
│   ├── models/              # Data models
│   ├── services/            # API and device services
│   ├── viewmodels/          # State management
│   ├── views/               # UI components
│   │   ├── pages/           # Full screens
│   │   └── widgets/         # Reusable UI components
│   └── main.dart            # App entry point
└── test/                    # Unit and widget tests
```




## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgements

- [Open Meteo](https://open-meteo.com/) for providing the weather data API
- [Google Weather Icons](https://github.com/mrdarrengriffin/google-weather-icons) for the icon set
- [Riverpod](https://riverpod.dev/) for state management
## 📸 Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/ce6ce853-dbda-4202-8013-c60442860399" width="200"/>
  <img src="https://github.com/user-attachments/assets/4d6cc88e-fa87-4ddb-b15e-e1178838d5a4" width="200"/>
  <img src="https://github.com/user-attachments/assets/084843de-9486-4763-b887-fbd2608b5b09" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/db6efd61-bd01-4eaa-ad18-3b12ff45b04e" width="200"/>
  <img src="https://github.com/user-attachments/assets/83808d37-f9cd-462e-a273-2efe396b6942" width="200"/>
  <img src="https://github.com/user-attachments/assets/3abbff32-609b-4002-9061-287ca718e3ac" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/f0f8066d-76a5-41dd-a3fa-93175b37891d" width="200"/>
  <img src="https://github.com/user-attachments/assets/3f343379-134e-4dbe-ba97-1decc0a2c002" width="200"/>
  <img src="https://github.com/user-attachments/assets/99a4b304-08ce-4155-b558-f8a755d6e6bb" width="200"/>
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/e3dcdfab-fc17-413d-87f8-a8506a6e7062" width="200"/>
  <img src="https://github.com/user-attachments/assets/4343fc5e-38b5-497f-8442-457915b6732c" width="200"/>
  <img src="https://github.com/user-attachments/assets/84710712-8181-48a3-b605-a4f98b82411f" width="200"/>
</p>
