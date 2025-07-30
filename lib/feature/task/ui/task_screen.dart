import 'package:flutter/material.dart';
import 'package:task/core/utils/color_manger.dart';
import 'package:task/core/utils/constans.dart';
import 'package:task/core/utils/style_manager.dart';
import 'package:task/core/widget/bottom_bar.dart';
import 'package:task/feature/task/data/db_helper.dart';
import 'package:task/feature/task/model/mail_product_model.dart';
import 'package:task/feature/task/ui/widget/product.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Product> products = [];
  Future<void> fetchProducts() async {
    final data = await DBHelper.getAllBurgers();
    setState(() {
      products =
          data.map((item) {
            return Product(
              name: item['name'],
              imageUrl: item['image'],
              price: item['price'],
            );
          }).toList();
    });
  }

  final List<String> categories = [
    "أفضل العروض",
    "مستورد",
    "أجبان قابلة للدهن",
    "أجبان",
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(width: 160),
                    Center(
                      child: Text(
                        "التصنيفات",
                        style: headline1.copyWith(
                          color: ColorManager.deepTeal,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Spacer(flex: 2),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: List.generate(categories.length, (index) {
                    final isSelected = selectedIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          chipTheme: Theme.of(
                            context,
                          ).chipTheme.copyWith(showCheckmark: false),
                        ),
                        child: ChoiceChip(
                          selectedColor: Colors.blue.shade100,
                          label: Row(
                            children: [
                              if (isSelected)
                                const Icon(
                                  Icons.check,
                                  size: 18,
                                  color: Color(0xFF1A73E8),
                                ),
                              if (isSelected) const SizedBox(width: 4),
                              Text(
                                categories[index],
                                style: TextStyle(
                                  color:
                                      isSelected
                                          ? const Color(0xFF1A73E8)
                                          : Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          selected: isSelected,
                          backgroundColor: const Color(0xFFF1F3F4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          onSelected: (_) {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 20),
              selectedIndex != 0
                  ? Container()
                  : products.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    shrinkWrap: true,
                    childAspectRatio: 0.7,
                    physics: NeverScrollableScrollPhysics(),
                    children:
                        products
                            .map(
                              (product) => ProductCard(
                                product: product,
                                onQuantityChanged: () => setState(() {}),
                              ),
                            )
                            .toList(),
                  ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomCartBar(
        total: AppConstants.totalValue,
        onTap: () {
          // DBHelper().seedInitialBurger();
          // setState(() {
          //   DBHelper().seedInitialBurger();
          // });
          // print("Cart tapped, all burgers cleared");
          // DBHelper().removeDuplicateBurgers();
        },
      ),
    );
  }
}
