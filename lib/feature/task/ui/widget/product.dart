import 'package:flutter/material.dart';
import 'package:task/core/utils/color_manger.dart';
import 'package:task/core/utils/constans.dart';
import 'package:task/feature/task/model/mail_product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onQuantityChanged;
  const ProductCard({super.key, required this.product, this.onQuantityChanged});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: ClipOval(
                  child:
                      widget.product.imageUrl != null &&
                              widget.product.imageUrl!.isNotEmpty
                          ? Image.asset(
                            widget.product.price >= 70
                                ? 'assets/image/1.png'
                                : 'assets/image/2.png',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported);
                            },
                          )
                          : Icon(
                            Icons.fastfood,
                            size: 50,
                            color: ColorManager.deepTeal,
                          ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              " ${widget.product.name}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: ColorManager.deepTeal,
              ),
              maxLines: 1,
              // overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // السعر
                  Text(
                    '${widget.product.price.toStringAsFixed(2)} S.R',
                    style: const TextStyle(
                      fontSize: 15,
                      color: ColorManager.softBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // العدّاد
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEAF1FB),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.remove,
                            size: 18,
                            color: Color(0xFF00796B),
                          ),
                          onPressed:
                              quantity > 0
                                  ? () => setState(() {
                                    quantity--;
                                    AppConstants.totalValue -=
                                        widget.product.price;
                                    widget.onQuantityChanged?.call();
                                  })
                                  : null,
                        ),
                        Text(
                          quantity.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                            color: Color(0xFF00796B),
                          ),
                          onPressed:
                              () => setState(() {
                                quantity++;
                                AppConstants.totalValue += widget.product.price;
                                widget.onQuantityChanged?.call();
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
