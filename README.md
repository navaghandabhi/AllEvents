# Event App

## Overview

Event App is a Flutter application that accesses with Google Log-in and adds users' data to Firestore and displays a list of events in a grid layout using a staggered grid view. Users can tap on an event to view its details. This project demonstrates the use of `GetX` for state management and routing, and `flutter_staggered_grid_view` for the grid layout.


<table width="100%">
  <tbody>
    <tr>
      <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/067752ca-a007-48de-b459-0a104426ae30" alt="Splash Screen" style="width:200px; margin-right:40px;"></td>
      <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/19c8b35f-f03f-4623-b3ed-88c05a625b00" alt="Intro Screen 1"style="width:200px; margin-right:40px;"></td>
       <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/ee77de4a-c991-4971-8f98-acdb6bdbb6ed" alt="Intro Screen 2" style="width:200px; margin-right:40px;"></td>
       <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/351e5ade-be70-4806-bab4-199b4fe4a6f8" alt="Login" style="width:200px; margin-right:40px;"></td>
    </tr>
    <tr>
      <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/0e287ba3-b9f0-4002-9d42-60371833ed0e" alt="Home" style="width:200px; margin-right:40px;"></td>
      <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/b5229dd1-9b59-4aaf-876c-c8debf549b25" alt="Home"style="width:200px; margin-right:40px;"></td>
       <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/4a21e451-920c-4aed-8890-e8042c9fe53f" alt="Category" style="width:200px; margin-right:40px;"></td>
       <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/2bd1b7c5-3495-4ad3-9320-da4d40ecb296" alt="Category" style="width:200px; margin-right:40px;"></td>
    </tr>
    <tr>
      <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/9ff5c4b1-875d-4bd3-a113-4540766f1897" alt="category filtered home screen" style="width:200px; margin-right:40px;"></td>
      <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/813e3e00-f2a5-4b8e-9471-2f2ea6e3ef44" alt="detail screen"style="width:200px; margin-right:40px;"></td>
       <td width="1%"><img src="https://github.com/navaghandabhi/AllEvents/assets/142008642/5b97a6f6-15b3-4905-87d3-7cb171865044" alt="Webview" style="width:200px; margin-right:40px;"></td>
    </tr>
  </tbody>
</table>


## Features
- Google log-in 
- Displays a list of events in a staggered grid view.
- Tap on an event to view its details.
- Uses `GetX` for state management and routing.
- Caches images using `CachedNetworkImage`.




## Getting Started


### Prerequisites

Ensure you have Flutter installed on your machine. You can download Flutter from [flutter.dev](https://flutter.dev). Follow the official documentation for installation instructions.

Please make sure to use the latest version of Flutter 3.22.0



### Installation

1. **Clone the repository:**
```
git clone https://github.com/yourusername/event_app.git
```



2. **Add Firebase to the project**

```
Enable Google sign-in in Firebase Authentication
```

```
Enable Firestore database and create documents "users" and give read and write permission
```



3. **Run Project **
   before running the project follow these commands
```
flutter upgrade
```

```
flutter clean
```

```
flutter pub get
```

```
flutter run
```
