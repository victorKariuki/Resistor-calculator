# Resistor Calculator

Resistor Calculator is a Flutter application designed to assist electronics hobbyists and professionals with resistor-related calculations. Whether you're decoding a resistor's value from its color bands, deciphering an SMD code, or finding the nearest standard resistor value, this app has you covered.

## Features

*   **Resistor Color Code Calculator:** Easily determine the resistance value of a through-hole resistor by selecting its color bands. The app supports 4-band and 5-band resistors.
*   **SMD Resistor Decoder:** Quickly find the value of a surface-mount (SMD) resistor by entering its 3 or 4-digit code, or its EIA-96 code.
*   **"Junk Box" E-Series Solver:** Find the nearest standard resistor value from the common E-series (E6, E12, E24, E48, E96, E192). This feature is perfect for when you need to find a suitable replacement resistor from your collection of parts.

## Building and Running the Application

To build and run this application, you will need to have the Flutter SDK installed.

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd myapp
    ```
2.  **Get dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Run the app:**
    ```bash
    flutter run
    ```
4.  **Build a release APK:**
    ```bash
    flutter build apk
    ```
