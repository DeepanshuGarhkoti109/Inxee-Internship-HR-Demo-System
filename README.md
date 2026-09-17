# Inxee Internship HR Demo System

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)](https://flutter.dev/)
[![Web](https://img.shields.io/badge/Web-Runner-4CAF50?style=for-the-badge)](demo_app/index.html)
[![Offline](https://img.shields.io/badge/Mode-Offline%20Demo-FF9800?style=for-the-badge)](#quick-start)

An end-to-end HR and attendance management application featuring an employee portal, admin dashboard, attendance punch clock, leave workflow, and payroll preview. The project includes both a Flutter version and a locally runnable web demo with offline dummy data.

---

## Project Overview

This demo simulates a modern HR management system with both employee and administrative workflows. It is built to run without Firebase or backend configuration, making it simple to demonstrate locally in a browser or desktop environment.

### Key Features

- Employee punch-in and punch-out tracking
- Leave application and approval workflow
- Salary and payslip preview
- Admin panel for employee oversight
- OTP and password login simulation
- Offline local dataset for instant demo use

---

## Demo Screenshots

|                    Employee Dashboard                     |                 Admin Panel                 |
| :-------------------------------------------------------: | :-----------------------------------------: |
| ![Employee Dashboard](assets/demo/employee_dashboard.jpg) | ![Admin Panel](assets/demo/admin_panel.jpg) |

---

## Quick Start

No Flutter SDK or Firebase configuration is required for the local demo.

```bash
git clone https://github.com/DeepanshuGarhkoti109/Inxee-Internship-HR-Demo-System.git
cd Inxee-Internship-HR-Demo-System
npm start
```

Then open:

```text
http://localhost:8080
```

### Demo Login Credentials

| Role     | Email                       | Password    |
| :------- | :-------------------------- | :---------- |
| Employee | deepanshuGarhkoti@gmail.com | password123 |
| Admin    | admin@inxee.com             | password123 |
| OTP Demo | Any phone/email             | 1234        |

---

## System Modules

### Employee Portal

- Punch in and punch out with attendance tracking
- Apply leave in half-day or full-day modes
- View payslips and profile information
- Secure login using password or OTP flow

### Admin Portal

- Attendance overview and workforce metrics
- Leave approval and rejection controls
- Employee directory and profile management
- Salary and payslip review workflow

---

## Local Data Model

The project uses a local dummy dataset to simulate realistic HR operations:

- Employees
- Attendance logs
- Leave requests
- Salary records

All actions update the in-memory state instantly for the demo environment.

---

## Repository Structure

```text
Inxee-Internship-HR-Demo-System/
├── assets/
│   └── demo/
│       ├── employee_dashboard.jpg
│       └── admin_panel.jpg
├── demo_app/
│   ├── index.html
│   ├── styles.css
│   └── app.js
├── lib/
│   ├── Common_panels/
│   ├── employee_panels/
│   ├── panels_ADMIN/
│   ├── database/
│   ├── screens/
│   └── main.dart
├── package.json
├── pubspec.yaml
├── README.md
└── LICENSE
```

---

## Running the Flutter Version

If Flutter is installed locally:

```bash
flutter pub get
flutter run
```

This supports browser, desktop, or mobile targets depending on your environment.

---

## License

This project is licensed under the MIT License. It is intended for internship/demo and educational use.
