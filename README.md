## AI-Led Development Log

During the development of **BurgerApp**, an AI assistant (accessed via a proxy interface to ChatGPT) was used twice to assist in generating code and shaping the app structure.

---

### 🔹 Occasion 1: ViewModel for Quantity Management

- **Prompt:**  
  "Create a Dart ViewModel class for ProductCard in BurgerApp with `quantity`, `increment`, `decrement`, and notifyListeners."

- **AI Response:**  
  The AI (via Proxy) suggested creating a class using `ChangeNotifier` to manage the quantity, instead of calling `setState()` within each card widget.

- **Implementation:**  
  A `ProductQuantityViewModel` was implemented and integrated into the `ProductCard` widget. The ViewModel updates the UI automatically on quantity change and adjusts `AppConstants.totalValue` accordingly.

---

### 🔹 Occasion 2: SQLite Product Data Model

- **Prompt:**  
  "Generate a Dart model class for a Product stored in SQLite with fields: name (String), price (double), image (String). Include fromMap and toMap methods."

- **AI Response:**  
  The AI returned a `Product` model class with serialization methods (`fromMap()` and `toMap()`) to convert between SQLite rows and Dart objects.

- **Implementation:**  
  This model was applied inside `DBHelper.getAllBurgers()` to map data retrieved from SQLite into `Product` objects used across the app.

---

## 📝 Commit Messages (Pushes)

1. `feat: use AI-generated ChangeNotifier ViewModel for quantity state in ProductCard`
2. `feat: added SQLite data model class for Product using AI-generated structure via Proxy AI`
