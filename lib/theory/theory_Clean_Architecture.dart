// 🟩 DOMAIN LAYER


// i. ENTITIES:
// ==================
// Entities are your core business objects - the fundamental models that represent your business logic, independent of any framework or UI. Example 
// User, Product, Order Entity...

// Key Characteristics:

// Pure Dart classes (no Flutter dependencies)
// Contain only business logic and rules
// Independent of databases, APIs, or UI
// Most stable layer - rarely changes


// ii. REPOSITORIES
// ====================
// A contract/agreement that lists all data operations my app needs. Defines WHAT operations, not HOW to do them. Implementation happens in DATA LAYER

// Repository = List of operations for ONE entity
// E.g: UserRepository - Operation for User Data
// - Get user by ID - Get all users - Create new user - Update user info - Delete user - Search users by name(ProductRepository...)

// abstract class UserRepository {
//   Future<User> getUserById(String id);
//   Future<List<User>> getAllUsers();
//   Future<void> createUser(User user);
//   Future<void> updateUser(User user);
//   Future<void> deleteUser(String id);
//   Future<List<User>> searchUsers(String name);
// }

// abstract class AuthRepository {
//   Future<User> login(String email, String password);
//   Future<void> logout();
//   Future<void> register(String email, String password);
//   Future<bool> isLoggedIn();
//   Future<void> resetPassword(String email);
// }

// iii. UseCases
// =================
// A Use Case represents ONE business action or intention of the user.
// It uses repositories to execute business rules. They enforce the Single Responsibility principle (SRP) and focus on specific functionalities

// UseCases are single-purpose business actions that:

// Represent what the user wants to do
// Coordinate one or more repositories
// Contain business rules & validations
// Are called from BLoC / Presentation layer

// EXAMPLE
// // Use Case: Login User
// class LoginUser {
//   final AuthRepository repository;
  
//   LoginUser(this.repository);
  
//   Future<User> call(String email, String password) {
//     return repository.login(email, password);
//   }
// }

// // Use Case: Get All Products
// class GetProducts {
//   final ProductRepository repository;
  
//   GetProducts(this.repository);
  
//   Future<List<Product>> call() {
//     return repository.getProducts();
//   }
// }

// abstract class Failure {
//   final String message;
//   Failure(this.message);
// }

// class ServerFailure extends Failure {
//   ServerFailure(super.message);
// }

// class CacheFailure extends Failure {
//   CacheFailure(super.message);
// }

// class NetworkFailure extends Failure {
//   NetworkFailure(super.message);
// }
// ```
// ====================================================================

// ## Domain Layer Summary:
// ```
// 🟩 DOMAIN LAYER
// │
// ├── 📁 entities/
// │   ├── user.dart
// │   ├── product.dart
// │   └── order.dart
// │
// ├── 📁 repositories/
// │   ├── user_repository.dart (abstract)
// │   ├── product_repository.dart (abstract)
// │   └── auth_repository.dart (abstract)
// │
// ├── 📁 usecases/
// │   ├── login_user.dart
// │   ├── get_products.dart
// │   ├── add_to_cart.dart
// │   └── create_order.dart
// │
// └── 📁 failures/ (optional)
//     └── failures.dart

// ========================================================================


// 🟪 DATA LAYER


// i. Model
// ============

// A Model is the DATA LAYER version of an Entity i.e It extends Entities(Domain)
// It handles converting data between your app and external sources (API, Database).

// class UserModel extends User {
//   UserModel({
//     required super.name,
//     required super.email,
//   });

//   // Convert JSON to Model
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       name: json['name'],
//       email: json['email'],
//     );
//   }

//   // Convert Model to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'email': email,
//     };
//   }
// }

// UserModel user = UserModel.fromJson(jsonData);


// ii. Repositories
// ==================

// It fulfills the Repository contract from Domain Layer
// This is where you actually fetch/save data from API, Database, etc. CRUD operations

// EXAMPLE:
// class UserRepositoryImpl implements UserRepository {
//   final RemoteDataSource remoteDataSource;
//   final LocalDataSource localDataSource;

//   UserRepositoryImpl({
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });

//   @override
//   Future<User> getUserById(String id) async {
//     try {
//       // Try to get from API
//       final userModel = await remoteDataSource.getUserById(id);
//       return userModel;
//     } catch (e) {
//       // If fails, get from local database
//       final userModel = await localDataSource.getUserById(id);
//       return userModel;
//     }
//   }

//   @override
//   Future<void> saveUser(User user) async {
//     final userModel = UserModel(
//       id: user.id,
//       name: user.name,
//       email: user.email,
//     );
    
//     await remoteDataSource.saveUser(userModel);
//     await localDataSource.cacheUser(userModel);
//   }
// }


// iii. DATA SOURCE
// ===================
// The class that directly talks to external sources (API, Database, Cache)
// Fetches from API/InternetFetches or from phone storage


// EXAMPLE:
// abstract class RemoteDataSource {
//   Future<UserModel> getUserById(String id);
//   Future<void> saveUser(UserModel user);
// }

// class RemoteDataSourceImpl implements RemoteDataSource {
//   final Dio dio; // HTTP client
  
//   RemoteDataSourceImpl(this.dio);

//   @override
//   Future<UserModel> getUserById(String id) async {
//     final response = await dio.get('https://api.example.com/users/$id');
    
//     if (response.statusCode == 200) {
//       return UserModel.fromJson(response.data);
//     } else {
//       throw ServerException();
//     }
//   }

//   @override
//   Future<void> saveUser(UserModel user) async {
//     await dio.post(
//       'https://api.example.com/users',
//       data: user.toJson(),
//     );
//   }
// }


// SOLID PRINCIPLE
// =====================

// 1. S - Single Responsibibilty Principle
// One Class One Job - One class for save, send ...

// 2. O - Open/Closed Principle
// Open for extension (new classes extends the parent), Closed for modification

// 3. L - Liskov Substitution Principle
// Child class should work anywhere parent works i.e All Parent Func should also work for child

// 4. I - Interface Segregation Principle
// Don't force Abstract classes to have methods all child dont need instead create more Abstract classes
// so the child class that needs them all can [class AllInOnePrinter implements Printer, Scanner, Fax ]

// 5. D - Dependency Inversion Principle
// Depend on interfaces, not concrete classes. Work on Contract doesnt know how just call.

// ====================================================================================================================================================

// CLEAN ARCHITECTURE LOGIN REQUEST EXAMPLE

// 1.  USER INTERACTION
// 2.  BLOC - BUSINESS LOGIC
// 3.  USECASES - BUSINESS LOGIC
// 4.  REPOSITORIES - DATA OPERATIONS
// 5.  DATA SOURCES - DATA RETRIEVAL
// 6.  DATA SOURCES - SERVER RESPONSE
// 7.  REPOSITORIES - DATA RETURN
// 8.  USECASES - BUSINESS LOGIC
// 9.  BLOC - BUSINESS LOGIC
// 10. VIEW - USER RESULT


// 🟦 PRESENTATION LAYER

// UI Components
// BLoC State Management
// Widgets
// Screens
// Navigation
// Themes
// Animations
// User Interactions


