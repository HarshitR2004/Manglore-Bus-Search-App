# Mangalore Bus Routes App

A Flutter application that helps users find and navigate bus routes in Mangalore. The app provides easy access to bus route information, search functionality, and detailed route views.

## Features Implemented ✅

### 1. View All Bus Routes
- Paginated list view of all available bus routes
- Each list item displays:
    - Bus number
    - Starting location
    - Destination location
- Clean and intuitive user interface
- Smooth scrolling with pagination support

### 2. Search Functionality
- Search routes by from location
- Search routes by to location
- Combined search (both from and to locations)
- Real-time search results
- Clear error handling when no routes are found

### 3. Route Details
- Detailed view for each bus route
- Complete route information including all stops
- Easy-to-read layout
- Quick access from both search results and main list

### 4. Error Handling
- Comprehensive error handling for API failures
- User-friendly error messages
- Retry functionality for failed requests
- Network connectivity error handling
- Loading states for better user experience

## Planned Features 🚀

### 1. Offline Support
- Cache frequently accessed routes
- Offline search capability
- Local storage for recent searches

### 2. User Preferences
- Save favorite routes
- Custom theme options
- Route history tracking

### 3. Enhanced Search
- Search by landmarks
- Fuzzy search for location names
- Filter routes by time of day

### 4. UI Enhancements
- Dark mode support
- Accessibility improvements
- Route sharing functionality

## Known Bugs 🐛

1. **Pagination Reset Issue**: Sometimes the pagination count resets when returning from the search screen
    
2. **Search Delay**: Search results may take longer to load with certain combinations of locations
    
3. **Route Display Truncation** :Very long route descriptions might get truncated on smaller devices

## References 📚

- [Flutter Official Documentation](https://docs.flutter.dev/)
- [Net Ninja Flutter Tutorial](https://www.youtube.com/playlist?list=PL4cUxeGkcC9jLYyp2Aoh6hcWuxFDX6PBJ)

## Screenshots and Recodring📱

[Screen Recording of the app](https://drive.google.com/file/d/1DNRf3iNIOpUogIZ8AvtjreJTzIiRWVhe/view?usp=sharing)

## Home Screen
![Home Screen](Screenshots/Screenshot_20241112_093711.png)

## Search Screen
![Search Screen](Screenshots/Screenshot_20241112_093730.png)

## Search Result
![Search Result](Screenshots/Screenshot_20241112_093755.png)

## Route Details
![Route Details](Screenshots/Screenshot_20241112_093857.png)

## Operating System 💻

- **Development OS**: Windows
- **Tested on**: Windows 11

## API Integration 🌐

The app integrates with the following API endpoints:

[API Documentation](https://app-bootcamp.iris.nitk.ac.in/docs)

- `/bus_routes/` - Get all bus routes (paginated)
- `/bus_routes/search/` - Search routes by location
- `/bus_routes/{bus_number}` - Get specific route details


## Project Structure 📁

```
lib/
  ├── main.dart
  ├── models/
  │   ├── bus_route.dart
  │   └── paginated_response.dart
  ├── services/
  │   └── api_service.dart
  └── screens/
      ├── home_screen.dart
      ├── search_screen.dart
      └── route_detail_screen.dart
```
## Design Tools & UI/UX Interest 🎨

- **Degisn Tools**: No specific design tools used
- **UI/UX Intrest**: Keen to explore and learn about the UI/UX domain




