# Project Blueprint

## Overview

This is a financial tracking and budgeting application built with Flutter and Riverpod. The application allows users to track their income and expenses, create budgets, and monitor their spending habits. The application uses a simple and intuitive interface to make it easy for users to manage their finances.

## Style and Design

- **Theming:** The application supports both light and dark themes, and users can toggle between them. The theme is implemented using `provider` and `google_fonts` for a modern and consistent look and feel.

## Features

- **User Authentication:** Users can sign up, log in, and log out of the application.
- **Transaction Management:** Users can add, edit, and delete transactions. I have created a transaction model, a notifier to manage the state of the transactions, and screens for adding and editing transactions. 
- **Category Management:** Users can create, view, and delete their own custom categories.
- **Budgeting:** Users can create and manage budgets for different spending categories.
- **Spending Analysis:** The application provides a visual summary of the user's spending habits with a pie chart.
- **Budget Warnings:** The application warns users when a transaction exceeds their budget for a particular category.
- **Data Persistence:** The application uses Firebase Firestore to store the user's data, including transactions, categories, and budgets. This ensures that the user's data is saved even when the application is closed.
- **Search Functionality:** Users can search for transactions by title in the finance dashboard.
- **Reports Screen:** A new screen that provides users with a summary of their spending habits over a selected period of time.
- **Spending Bar Chart:** The "Reports" screen includes a bar chart that shows the user's spending by category.
