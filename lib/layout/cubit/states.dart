abstract class AppStates {}


class AppInitialState extends AppStates {}


class AppChangeBottomNavState extends AppStates {}


class AppLoadingHomeDataState extends AppStates {}

class AppSuccessHomeDataState extends AppStates {}

class AppErrorHomeDataState extends AppStates {}


class AppSuccessCategoriesDataState extends AppStates {}

class AppErrorCategoriesDataState extends AppStates {}


class AppChangeFavoritesState extends AppStates {}

class AppSuccessChangeFavoritesState extends AppStates {}

class AppErrorChangeFavoritesState extends AppStates {}


class AppLoadingGetFavoritesDataState extends AppStates {}

class AppSuccessGetFavoritesDataState extends AppStates {}

class AppErrorGetFavoritesDataState extends AppStates {}


class AppGetCategoryState extends AppStates {}

class AppChooseCategoryState extends AppStates {}

class AppGetCartProductsState extends AppStates {}


class SearchInitialState extends AppStates {}

class SearchLoadingState extends AppStates {}

class SearchSuccessState extends AppStates {}

class SearchErrorState extends AppStates {}

