# Resistor Toolkit Blueprint

## Overview

This document outlines the architecture and future development plans for the Resistor Toolkit application. The app provides a collection of tools for electronics enthusiasts and professionals to work with resistors.

## Current Features

*   **Resistor Color Code Decoder:** Decodes the value of a resistor based on its color bands.
*   **SMD Resistor Decoder:** Decodes the value of a surface-mount device (SMD) resistor.
*   **E-Series Finder:** Finds standard resistor values in the E-series (E6, E12, E24, etc.).
*   **Junk Box Solver:** Helps find a target resistance value using a combination of resistors from a "junk box."
*   **Power Analysis:** Calculates power dissipation in a resistor.
*   **Voltage Divider Calculator:** Calculates the output voltage of a voltage divider circuit.
*   **L-Match Impedance Matching:** Calculates the component values for an L-match impedance matching network.
*   **Favorites:** Allows users to save their favorite resistor values.
*   **History:** Keeps a history of recent calculations.
*   **Light/Dark Mode:** Supports both light and dark themes.

## Refactoring Plan

### 1. Separate UI from Business Logic

**Goal:** Improve maintainability and testability by separating the UI from the business logic.

*   **Action:** For each feature, I will create a separate "logic" or "controller" class to handle the business logic. The UI will then call methods on this class to perform calculations and update the state.
*   **Example:** In the `decoder_view.dart`, the resistor calculation logic will be moved to a `DecoderLogic` class.

### 2. Optimize State Management

**Goal:** Improve the efficiency of state management and reduce unnecessary widget rebuilds.

*   **Action:**
    *   I will use `ValueNotifier` for simple, local state within individual widgets.
    *   I will use `Consumer` widgets to rebuild only the parts of the UI that depend on the state.
    *   I will ensure that `ChangeNotifier` is used only for complex state that needs to be shared across multiple widgets.

### 3. Enhance Code Readability

**Goal:** Make the code easier to understand and maintain.

*   **Action:**
    *   I will add comments to explain complex logic.
    *   I will use more descriptive variable and function names.
    *   I will ensure consistent formatting throughout the codebase.

### 4. Review and Optimize Widgets

**Goal:** Improve the performance of the UI.

*   **Action:**
    *   I will use `const` constructors for widgets that do not change.
    *   I will break down large widgets into smaller, more manageable ones.
    *   I will use `ListView.builder` for long lists of items.

### 5. Centralize and Improve Routing

**Goal:** Make the navigation logic more robust and easier to manage.

*   **Action:** The routing is already well-structured in `router.dart`. I will review it for any potential improvements, such as using named routes more consistently.

### 6. Consolidate Theme and Styling

**Goal:** Ensure a consistent look and feel throughout the application.

*   **Action:** The theme is defined in `theme_provider.dart`. I will review this file to ensure that all colors, fonts, and other styles are defined in one place and used consistently.
