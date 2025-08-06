# Dynamic API Client for Flutter Dashboard

This project has been updated to use a **Dynamic API Client** instead of the OpenAPI Generator. This change eliminates the need for code generation while maintaining full API functionality.

## 🚀 Key Benefits

- **No Code Generation**: No need to run `build_runner` or regenerate API code
- **Dynamic Updates**: API changes are automatically available without app rebuilds  
- **Smaller Bundle Size**: No generated code means smaller app size
- **Runtime Discovery**: Discover and use new endpoints at runtime
- **Flexible Error Handling**: Standard Dio error handling patterns
- **Type Safety**: Maintained through service method signatures

## 📦 Architecture

### Core Components

1. **`DynamicApiClient`** - Fetches and parses OpenAPI spec, makes dynamic API calls
2. **`CorpApiService`** - Convenient wrapper providing typed methods for all endpoints
3. **`ServiceLocator`** - Manages service dependencies and initialization
4. **`AuthInterceptor`** - Handles authentication and token refresh automatically

### File Structure

```
lib/
├── services/
│   ├── dynamic_api_client.dart    # Core dynamic API client
│   ├── corp_api_service.dart      # Convenient API service wrapper  
│   └── service_locator.dart       # Service dependency management
├── util/
│   └── corp_interceptor.dart      # Updated auth interceptor
└── main.dart                      # Updated app initialization
```

## 🛠️ Usage

### Basic Setup

The API client is automatically initialized in `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final navigatorKey = GlobalKey<NavigatorState>();
  
  // Initialize services
  await ServiceLocator().initialize(
    baseUrl: "https://thecorporation.space",
    navigatorKey: navigatorKey,
  );
  
  runApp(MyApp(navigatorKey: navigatorKey));
}
```

### Making API Calls

#### Option 1: Using the Service (Recommended)

```dart
// Login
final response = await corpApiService.login(
  username: 'your_username',
  password: 'your_password',
  otp: 123456, // optional
);

// Get user profile
final profile = await corpApiService.getProfile();

// Send tribute
final result = await corpApiService.sendTribute(
  receiverHandle: 'recipient',
  amount: 100,
  message: 'Thanks!',
);
```

#### Option 2: Direct API Client Access

```dart
final dynamicClient = ServiceLocator().dynamicApiClient;

final response = await dynamicClient.call(
  'login',
  data: {
    'username': 'your_username',
    'password': 'your_password',
    'otp': 123456,
  },
);
```

### Available Service Methods

#### Authentication
- `login()`, `register()`, `logout()`, `refreshToken()`
- `changePassword()`, `getStatus()`

#### Information  
- `getCorporateers()`, `getCurrentFunding()`

#### Influence System
- `getProfile()`, `getUserInfluenceStats()`, `sendTribute()`
- `getTributeHistory()`, `updateAccount()`

#### Auctions
- `listAuctions()`, `createAuction()`, `placeBet()`
- `closeAuction()`, `deleteAuction()`

#### Structure
- `getUserProfile()`, `getUserDepartments()`, `getUserDivisions()`
- `getUserRoles()`, `joinDivision()`, `leaveDivision()`

#### Admin Functions
- `adminAddTribute()`, `createRank()`, `editRank()`, `deleteRank()`
- `createDepartment()`, `updateDepartment()`, `deleteDepartment()`

### Error Handling

```dart
try {
  final response = await corpApiService.login(
    username: username,
    password: password,
  );
  
  // Handle success
  if (response.data['msg'] == 'logged_in') {
    // Login successful
  }
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Handle unauthorized
  } else if (e.response?.statusCode == 400) {
    // Handle bad request
  }
} catch (e) {
  // Handle other errors
}
```

### Response Format

Responses are standard Dio `Response<dynamic>` objects:

```dart
final response = await corpApiService.getProfile();

// Access response data
final influence = response.data['influence'] as int;
final rank = response.data['rank'] as String;

// Check status code
if (response.statusCode == 200) {
  // Success
}
```

## 🔍 Discovering API Endpoints

You can explore available endpoints at runtime:

```dart
final dynamicClient = ServiceLocator().dynamicApiClient;

// Get all endpoints
final endpoints = dynamicClient.endpoints;

// Get endpoints by tag
final securityEndpoints = dynamicClient.getEndpointsByTag('Security');

// Get specific endpoint info
final loginEndpoint = dynamicClient.getEndpoint('login');
print('Login path: ${loginEndpoint?.path}');
print('Login method: ${loginEndpoint?.method}');
print('Required parameters: ${loginEndpoint?.parameters}');
```

## 🔧 Configuration

### Development vs Production

```dart
// main.dart
const bool isDevelopment = true;
const corpApiUrl = isDevelopment 
    ? "http://localhost:5000"
    : "https://thecorporation.space";
```

### Custom Interceptors

```dart
// Add custom interceptors to the Dio instance
final dio = ServiceLocator().dio;
dio.interceptors.add(LogInterceptor()); // Add logging
```

## 🚨 Migration from OpenAPI Generator

See [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) for detailed migration instructions.

### Quick Migration Checklist

- [ ] Remove `openapi_generator_annotations` from `pubspec.yaml`
- [ ] Remove `build_runner` dependency (if only used for OpenAPI)
- [ ] Remove `corp_api` local dependency
- [ ] Update imports: Remove `import 'package:corp_api/corp_api.dart'`
- [ ] Replace generated API calls with service method calls
- [ ] Update response handling from `.data!.property` to `.data['property']`
- [ ] Test all API functionality

## 🧪 Testing

The dynamic client makes testing easier:

```dart
// Mock the service for testing
class MockCorpApiService extends CorpApiService {
  MockCorpApiService() : super(MockDynamicApiClient());
  
  @override
  Future<Response> login({required String username, required String password, int? otp}) async {
    return Response(
      data: {'msg': 'logged_in', 'corp_access_pass': 'mock_token'},
      statusCode: 200,
      requestOptions: RequestOptions(),
    );
  }
}
```

## 📱 Environment Setup

1. **Install Dependencies**:
   ```bash
   flutter pub get
   ```

2. **Run the App**:
   ```bash
   flutter run
   ```

3. **Build for Production**:
   ```bash
   flutter build web
   # or
   flutter build apk
   ```

## 🔐 Authentication

Authentication is handled automatically by the `AuthInterceptor`:

- Access tokens are automatically added to requests
- Tokens are refreshed when they expire
- Users are redirected to login when tokens are invalid
- Secure storage is used for token persistence

## 🌐 API Specification

The client automatically fetches the OpenAPI specification from:
- **Production**: `https://thecorporation.space/api/apispec.json`
- **Development**: `http://localhost:5000/api/apispec.json`

## 📄 License

This project follows the same license as the original repository.

## 🤝 Contributing

When adding new API endpoints or modifying existing ones:

1. Update the server's OpenAPI specification
2. The Flutter app will automatically pick up changes on next launch
3. Add convenience methods to `CorpApiService` if needed
4. Update documentation

No code generation or build steps required! 🎉
