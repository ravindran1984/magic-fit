# Magic Fit - workout app

Overview

The Magic Fit Workout App  is a flutter application designed to help users manage and track their workouts. The apps allows user to create, edit and delete workout, including details about the exercises, weights and repetitions.

# Features in the Magic Fit Workout App

Create new workouts : User can create a new workout with multiple sets with exercise, weight and repetitions
Edit existing workouts : User can modify the details of the existing workout
Delete workout : User can delete a single set/multiple sets in the workout and also delete the complete workout.
Detailed workout view : Detail view of each workout including exercise, weight and Repetitions

# Architecture

## MVVM (Model-View-ViewModel)

The application uses the MVVM architecture pattern to separate concerns and manage state effectively:

Model: Represents the data structure. For example, Workout and WorkoutSet models.
View: The UI components that display data to the user. For example, WorkoutScreen and WorkoutDetailScreen.
ViewModel: Handles business logic and interacts with the model. For example, WorkoutProvider and WorkoutDetailProvider manage state and logic.


# Provider

Provider is used for state management in this app. It allows efficient and scalable management of state across the application

# Third-party packages
Following third party packages are used in this application: 

provider - used for state management,
Hive - used for offline storage of workouts,
google fonts - provides a collection of fonts that can be used in the application, 
intl - used for formatting date time

few other packages are used under dev dependencies like hive generator, build runner for hive code generators and integration_test

# Screenshots

### Workout Screen
![Workout Screen](https://github.com/user-attachments/assets/ab035476-aa49-4d05-8cbe-ca7f8fb3c5d9)
![Workout List Screen](https://github.com/user-attachments/assets/5bd3678d-4879-4712-b5ab-844bae147999)
![Workout Detail Screen](https://github.com/user-attachments/assets/4f6ce19e-59bb-4d9b-b56f-d82610162c9a)



