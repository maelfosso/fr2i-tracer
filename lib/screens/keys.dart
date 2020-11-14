import 'package:flutter/widgets.dart';

class ArchSampleKeys {
  // Home Screens
  static const homeScreen = Key('__homeScreen__');
  static const addDataFab = Key('__addDataFab__');
  static const snackbar = Key('__snackbar__');
  static Key snackbarAction(String id) => Key('__snackbar_action_${id}__');

  // Datas
  static const todoList = Key('__todoList__');
  static const todosLoading = Key('__todosLoading__');
  static final todoItem = (String id) => Key('DataItem__${id}');
  static final todoItemCheckbox =
      (String id) => Key('DataItem__${id}__Checkbox');
  static final todoItemTask = (String id) => Key('DataItem__${id}__Task');
  static final todoItemNote = (String id) => Key('DataItem__${id}__Note');

  // Tabs
  static const tabs = Key('__tabs__');
  static const todoTab = Key('__todoTab__');
  static const statsTab = Key('__statsTab__');

  // Extra Actions
  static const extraActionsButton = Key('__extraActionsButton__');
  static const toggleAll = Key('__markAllDone__');
  static const clearCompleted = Key('__clearCompleted__');

  // Filters
  static const filterButton = Key('__filterButton__');
  static const allFilter = Key('__allFilter__');
  static const activeFilter = Key('__activeFilter__');
  static const completedFilter = Key('__completedFilter__');

  // Stats
  static const statsCounter = Key('__statsCounter__');
  static const statsLoading = Key('__statsLoading__');
  static const statsNumActive = Key('__statsActiveItems__');
  static const statsNumCompleted = Key('__statsCompletedItems__');

  // Details Screen
  static const editDataFab = Key('__editDataFab__');
  static const deleteDataButton = Key('__deleteDataFab__');
  static const todoDetailsScreen = Key('__todoDetailsScreen__');
  static final detailsDataItemCheckbox = Key('DetailsData__Checkbox');
  static final detailsDataItemTask = Key('DetailsData__Task');
  static final detailsDataItemNote = Key('DetailsData__Note');

  // Add Screen
  static const addDataScreen = Key('__addDataScreen__');
  static const saveNewDataFab = Key('__saveNewDataFab__');
  static const nameField = Key('__nameField__');
  static const sexField = Key('__sexField__');
  static const ageField = Key('__ageField__');
  static const longituteField = Key('__longitudeField__');
  static const latitudeField = Key('__latitudeField__');
  static const altitudeField = Key('__altitudeField__');

  // Edit Screen
  static const editDataScreen = Key('__editDataScreen__');
  static const saveEditedDataFab = Key('__saveEditedDataFab__');
}