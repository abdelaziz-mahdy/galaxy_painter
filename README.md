### README.md

# Galaxy Painter

This Flutter application is a demonstration of how to render a galaxy on a Flutter canvas. The galaxy includes spiral arms, stars, planets, random stars, and galaxy dust. The stars twinkle and the planets move in a circular pattern to create a dynamic and visually appealing effect.

## Features

- **Spiral Arms**: Rendered with a gradient to simulate the look of a real galaxy.
- **Stars**: Placed along the spiral arms, twinkling at random intervals.
- **Planets**: Larger celestial bodies that move slowly in circular paths within the spiral arms.
- **Random Stars**: Stars scattered randomly across the canvas, also twinkling at random intervals.
- **Galaxy Dust**: Brownish particles scattered to give a more realistic appearance.

## Getting Started

### Prerequisites

- Flutter SDK: [Flutter installation guide](https://flutter.dev/docs/get-started/install)
- A code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio)

### Installation

1. **Clone the repository:**

```bash
git clone https://github.com/abdelaziz-mahdy/galaxy_painter
cd galaxy_painter
```

2. **Install dependencies:**

```bash
flutter pub get
```

### Running the Application

1. **Start the application:**

```bash
flutter run
```

This will launch the app on your connected device or emulator.

## Project Structure

- **lib/**
  - **main.dart**: The entry point of the application. Initializes the GalaxyController and starts the animation.
  - **galaxy_controller.dart**: Manages the state of the stars, planets, random stars, and galaxy dust. Controls the movement and twinkling effect.
  - **galaxy_painter.dart**: CustomPainter class responsible for rendering the galaxy on the canvas.
  - **threshold_value_notifier.dart**: A utility class to handle threshold-based ValueNotifier.
