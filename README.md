# Respyr iOS Mobile Application

Respyr is an iOS mobile application designed to streamline training sessions for AHA (American Heart Association) training centers. This app provides training center administrators with essential features to assess students, host sessions, and track their progress throughout the course. Respyr is built using the SwiftUI framework, which enables a modern and intuitive user interface. Asynchronous operations are handled using the Combine framework, ensuring a smooth user experience. Firebase is integrated as the backend technology, offering robust data storage and synchronization capabilities.

## Features

1. **Assess Students**: Respyr allows training center administrators to assess students' knowledge and skills during training sessions. Administrators can create assessments with multiple-choice questions, fill-in-the-blank questions, and interactive scenarios. The app provides a user-friendly interface for administering and evaluating these assessments.

2. **Host Sessions**: Training center administrators can host training sessions using Respyr. They can create sessions, set the schedule, and invite students to join. Respyr provides real-time communication capabilities to facilitate interaction between administrators and students during the session.

3. **Track Student Progress**: Respyr enables training center administrators to track the progress of students throughout the course. Administrators can view individual student performance, including assessment scores, participation in sessions, and completion of course materials. This information helps identify areas where students may need additional support or intervention.

4. **User Authentication**: Respyr employs secure user authentication to ensure that only authorized individuals can access the application. Administrators and students have their own accounts, and authentication is managed through Firebase Authentication. This feature safeguards sensitive training data and maintains the privacy of users.

## Technologies Used

Respyr leverages the following technologies:

- **SwiftUI**: The app's user interface is built using SwiftUI, Apple's modern declarative framework for creating user interfaces across all Apple platforms. It enables developers to build robust, visually appealing interfaces with less code.

- **Combine**: Respyr utilizes Combine, Apple's asynchronous programming framework, to handle asynchronous operations such as networking requests, data processing, and event handling. Combine simplifies handling of asynchronous events and supports reactive programming patterns.

- **Firebase**: Respyr integrates with Firebase, Google's mobile and web development platform. Firebase provides various services, including Cloud Firestore for real-time data synchronization and storage, Firebase Authentication for user management and authentication, and Firebase Cloud Messaging for push notifications.

## Usage
Use of this application requires a Firebase Firestore repository. Once a create a Firebase project and paste the google plist into the root folder of the project. finally, enable firestore. After pulling this repo. Launch the application using XCode, and create a basic user account to get started. 


## License

Respyr is currently proprietary software developed by Kevin John Parke. All rights reserved.

Note: This readme file is a fictional example and should be customized to match your specific application.



