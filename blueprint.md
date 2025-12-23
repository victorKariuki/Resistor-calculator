# Resistor Master - Blueprint

## Overview

**Purpose:** To create the definitive "God Mode" engineering utility for resistor analysis, as specified in the SRS. The application is a cross-platform tool for identification, circuit synthesis, power analysis, and RF modeling.

**Target Users:** Students, Hobbyists/Makers, Embedded Engineers, and RF/Analog Engineers.

---

## Implemented Features (Final Version)

### Version 1.0 (Feature Complete)

*   **Dependencies:** `provider`, `google_fonts`, and `shared_preferences` added.
*   **Theming:** Full Material 3 theming with light/dark mode toggle implemented.
*   **Navigation:** A home screen has been added to navigate between the different features.
*   **Core Feature: Through-Hole Decoder (3, 4, 5, & 6-Band):**
    *   (REQ-1.1) Implemented 3, 4, 5, and 6-band resistor selection.
    *   (REQ-1.2) The system displays Resistance, Tolerance, and TCR (for 6-band).
    *   (REQ-1.3) A visual vector graphic of the resistor updates in real-time.
    *   UI includes color selectors for each band and a real-time results display.
*   **Core Feature: Reverse Lookup:**
    *   (REQ-1.4) Implemented reverse lookup for all band counts.
*   **Core Feature: SMD Decoder:**
    *   (REQ-2.1) A new view for SMD resistor decoding has been created.
    *   (REQ-2.2) The system can decode both standard 3/4-digit codes and the EIA-96 system.
*   **Core Feature: Favorites & History:**
    *   (REQ-3.1 - 3.6) Users can save favorite values and view a history of recent calculations.
*   **Core Feature: Power & Heat Analysis:**
    *   A calculator for Ohm's Law, power dissipation, and basic thermal analysis.
    *   Inputs for two of the following: Voltage (V), Current (A), Resistance (Ω).
    *   Calculates the remaining value and Power (W).
    *   Includes a thermal analysis section to input thermal resistance (°C/W) and ambient temperature (°C) to estimate the component's temperature.
*   **Core Feature: Circuit Synthesis (Voltage Divider):**
    *   A voltage divider calculator.
    *   Inputs for Vin, Vout, and one of the following: R1, R2, or desired current.
    *   Calculates the required resistor values and suggests the closest standard E-series values.
*   **Core Feature: RF & Analog Analysis (L-Match Impedance):**
    *   An L-Network impedance matching calculator.
    *   Inputs for Source Impedance, Load Impedance, and Frequency.
    *   Calculates the required Inductor (L) and Capacitor (C) values for the matching network.
