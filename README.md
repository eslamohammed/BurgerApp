## AI-Led Development Log

تم استخدام AI (مثل ChatGPT) مرتين خلال تطوير تطبيق **BurgerApp**، لتوليد كود ومساعدة في التصميم.

---

### 🔹 Occasion 1: ViewModel لإدارة الكمية (Quantity)

- **Prompt:**  
  "Create a Dart ViewModel class for ProductCard in BurgerApp with `quantity`, `increment`, `decrement`, and notifyListeners."

- **AI Response:**  
  اقترح AI عمل كلاس باستخدام `ChangeNotifier` يحتوي على عدد الطلبات ودوال للتحكم فيه، بدلًا من استخدام `setState` في كل كارت.

- **Implementation:**  
  تم استخدام `ProductQuantityViewModel` وربطها بـ `ProductCard` لتحديث الـ UI تلقائيًا عند تغيير الكمية، وتم ربط القيمة الإجمالية داخل `AppConstants.totalValue`.

---

### 🔹 Occasion 2: SQLite Product Data Model

- **Prompt:**  
  "Generate a Dart model class for a Product stored in SQLite with fields: name (String), price (double), image (String). Include fromMap and toMap methods."

- **AI Response:**  
  أنشأ كلاس `Product` يحتوي على `fromMap()` و `toMap()` لتحويل البيانات ما بين SQLite و Dart object.

- **Implementation:**  
  استخدمت هذا الموديل في `DBHelper.getAllBurgers()` لتحويل صفوف قاعدة البيانات إلى كائنات `Product` داخل التطبيق.

---

## 📝 Commit Messages (Pushes)

1. `feat: use AI-generated ChangeNotifier ViewModel for quantity state in ProductCard`
2. `feat: added SQLite data model class for Product using AI-generated structure`
