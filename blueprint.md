# Resistor Master Blueprint

## Overview

Resistor Master is a Flutter application designed for electronics enthusiasts and professionals. It provides a suite of tools to simplify resistor-related calculations and circuit analysis. This document outlines the existing features and the plan to evolve the application into the "Ultimate Edition" as specified in the SRS v4.0.

## Implemented Features

*   **Through-Hole Resistor Decoder:** Decodes 4, 5, and 6-band resistors based on their color codes.
*   **Through-Hole Reverse Lookup:** Converts a resistance value back to color bands.
*   **SMD Resistor Decoder:** Decodes 3-digit, 4-digit, and EIA-96 SMD resistor codes.
*   **E-Series Validator & Quantizer:** Validates resistor values against standard E-series (E6-E192) and finds the nearest standard value.
*   **Favorites:** Allows users to save frequently used resistor values.
*   **History:** Keeps a record of all decoded resistor values and calculations.
*   **Power Calculator:** Calculates power, voltage, current, or resistance.
*   **Voltage Divider Calculator:** Computes output voltage.
*   **L-Match Impedance Matching Calculator:** Designs impedance matching networks.
*   **Theming:** Supports light, dark, and system themes with a Material 3 design.

## Design

*   **Theme:** Uses Material 3 design principles with a deep purple seed color.
*   **Fonts:** Utilizes Google Fonts (Oswald, Roboto, Open Sans) for typography.
*   **Layout:** A central home screen provides navigation to all feature modules.

## Development Plan (SRS v4.0)

This section outlines the features to be implemented based on the Software Requirements Specification v4.0.

### Current Task: "Junk Box" Reverse Solver

Implementing REQ-4 from the SRS. This feature will find series and parallel combinations of resistors from a user-defined list to achieve a target resistance.

### Future Features

#### Domain 1: Identification & Fundamentals
*   **[REQ-1.4] Through-Hole Reverse Lookup:** **(Completed)**
*   **[REQ-2.3, 2.4] Advanced SMD Decoding:** **(Completed)**
*   **[REQ-3] E-Series Validator & Quantizer:** **(Completed)**

#### Domain 2: Circuit Design & Synthesis
*   **[REQ-4] "Junk Box" Reverse Solver:** **(In Progress)**
*   **[REQ-5.3, 5.4] Advanced Voltage Divider:** Add load analysis and output impedance calculation.
*   **[REQ-6] LED Array Wizard:** Calculate current-limiting resistors for LED setups.
*   **[REQ-7] Op-Amp Gain Calculator:** Design feedback networks for common op-amp configurations.

#### Domain 3: Power & Physics
*   **[REQ-8.2] Adiabatic Pulse Calculator:** Analyze resistor survivability during power surges.
*   **[REQ-9] Thermal Derating Engine:** Calculate effective power rating based on ambient temperature.
*   **[REQ-10] PCB Trace Resistance Calculator:** Model resistance and current capacity of PCB traces based on IPC standards.

#### Domain 4: RF & Signal Integrity
*   **[REQ-11] RF Attenuator Designer:** Design Pi, T, and Bridged-T attenuators.
*   **[REQ-12] Thermal Noise Calculator:** Calculate Johnson-Nyquist noise for a resistor.
*   **[REQ-13] High-Frequency Impedance Estimator:** Model parasitic ESL/ESR effects.

#### Domain 5: Sensors & Manufacturing
*   **[REQ-14] Thermistor Linearizer:** Convert resistance to temperature using Beta and Steinhart-Hart models.
*   **[REQ-15] Wheatstone Bridge Analyzer:** Calculate the output of a Wheatstone bridge.

#### UI/UX & Non-Functional Requirements
*   **[UI-2] Metric Suffix Input:** Allow users to type "k", "M", "u" in input fields.
*   **[NFR-4] Critical Warnings:** Implement safety warnings for exceeding component ratings.
