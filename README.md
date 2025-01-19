# Mausam - Weather Forecasting App

## Overview
Mausam - Weather Forecasting App is a cross-platform mobile application built using Flutter. It fetches real-time weather data from the OpenWeather API and provides a clean and user-friendly interface to display current weather details and a 3-day forecast. Users can search for a city's weather, toggle between Celsius and Fahrenheit, and save their preferences.

---

## Features

- **Search Bar**: Allows users to search for weather updates by city name.
- **Current Weather**: Displays temperature, humidity, and weather description.
- **3-Day Forecast**: Provides a scrollable list of weather details for the next three days.
- **Unit Preferences**: Toggle between Celsius and Fahrenheit.
- **Local Storage**: Saves the last searched city and unit preferences using Hive.
- **Error Handling**: Displays appropriate messages for errors like invalid city names or no internet connection.

---

## Screenshots
(Include screenshots of your app's UI here if available.)
<img src="https://github.com/narsimha-na/mausam/blob/main/sc2.png" width="150" height="280">

<img src="https://github.com/narsimha-na/mausam/blob/main/sc1.png" width="150" height="280">

---

## Installation

### Prerequisites
- Flutter SDK ([Installation Guide](https://flutter.dev/docs/get-started/install)).
- An API key from OpenWeather ([Sign Up Here](https://openweathermap.org/api)).

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/narsimha-na/mausam.git
   cd mausam
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Create a `.env` file in the project root and add your OpenWeather API key:
   ```
   API_KEY=your_openweather_api_key
   ```
4. Run the app:
   ```bash
   flutter run
   ```

---

## Project Structure
```
weather_forecast/
├── lib/
│   ├── main.dart            # App entry point
│   ├── weather_provider.dart # State management
│   ├── weather_screen.dart   # UI for the main screen
├── assets/
│   └── icon.png             # App icon
├── test/
│   └── weather_provider_test.dart # Unit tests for provider
├── pubspec.yaml             # Dependency and asset declarations
├── README.md                # Project instructions
```

---

## API Integration

### OpenWeather API
The app uses the following endpoints:

1. **Current Weather**
   ```
   https://api.openweathermap.org/data/2.5/weather?q={city_name}&appid={API_KEY}&units=metric
   ```

2. **3-Day Forecast**
   ```
   https://api.openweathermap.org/data/2.5/forecast?q={city_name}&appid={API_KEY}&units=metric
   ```

Replace `{city_name}` with the city entered by the user and `{API_KEY}` with your OpenWeather API key.

---

## Challenges and Solutions

1. **Handling API Errors**
   - **Challenge**: Managing errors such as invalid city names or no internet connection.
   - **Solution**: Implemented error handling using `try-catch` and displayed user-friendly messages using `SnackBar`.

2. **State Management**
   - **Challenge**: Efficiently managing app states across different widgets.
   - **Solution**: Used the `Provider` package for clean and reactive state management.

3. **Responsive UI**
   - **Challenge**: Ensuring the app design works seamlessly across different screen sizes.
   - **Solution**: Used Flutter's `MediaQuery` and responsive widgets like `Flexible` and `Expanded`.

4. **Unfamiliarity with Provider**
   - **Challenge**: Limited experience with Provider, being more familiar with BLoC and GetX.
   - **Solution**: Researched Provider through documentation and examples, gaining proficiency for implementation.

---

## Future Improvements

1. **Enhanced Features**:
   - Add wind speed, air pressure, and sunrise/sunset times.
   - Display additional weather metrics such as UV index.

2. **Improved UI**:
   - Add animations and custom icons for different weather conditions.

3. **Offline Mode**:
   - Cache last fetched weather data for offline access.

4. **Notifications**:
   - Provide weather reminders and alerts for significant weather changes.

5. **Heat Maps**:
   - Include maps-based weather visualizations like temperature and precipitation heat maps.

6. **Multiple Locations**:
   - Allow users to save and manage weather updates for multiple cities.

---

## Contribution

Contributions are welcome! Please fork the repository, make your changes, and submit a pull request.

---
