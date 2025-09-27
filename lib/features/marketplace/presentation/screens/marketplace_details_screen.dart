import 'package:flutter/material.dart';
import 'package:flutter_ladydenily/core/common/images/images.dart';
import 'package:flutter_ladydenily/core/common/widgets/appbar.dart';
import 'package:flutter_ladydenily/core/extensions/button_extensions.dart';
import 'package:flutter_ladydenily/core/theme/app_colors.dart';
import 'package:flutter_ladydenily/core/widgets/texts.dart';
import 'package:flutter_ladydenily/features/others/widgets/stars.dart';

class MarketplaceDetailsScreen extends StatelessWidget {
  const MarketplaceDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Legendary Book',
          style: TextStyle(
            color: AppColors.appBarTitle,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(18),
                child: Column(
                  children: [
                    CustomText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisl ligula, egestas ac magna vel, porta condimentum orci.',
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),

                    SizedBox(height: 14),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Center(
                        child: Image.asset(ImagesString.stockMarket),
                      ),
                    ),

                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: AppColors.bestSellerBoxColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            child: CustomText(
                              'Best Seller',
                              style: TextStyle(
                                color: AppColors.titleTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            SizedBox(
                              height: 22,
                              child: StarRating(rating: 4.5, size: 22),
                            ),
                            SizedBox(
                              height: 22,
                              child: CustomText(
                                '(4.5)',
                                style: TextStyle(
                                  color: AppColors.titleTextColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 12),
                    CustomText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nisl ligula, egestas ac magna vel, porta condimentum orci. Nunc pharetra ante sit amet vehicula finibus. Nam laoreet convallis magna non pellentesque. Suspendisse a purus tempor, scelerisque nulla vitae, dignissim urna. Vestibulum tincidunt condimentum nisl, ut finibus nulla ultrices quis. Fusce volutpat faucibus erat, vel dictum libero ultrices ac. Nullam vel varius tortor, at lobortis quam. Suspendisse semper urna id est cras amet.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 100),

              Container(
                color: AppColors.paymentColor,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12,
                          left: 16,
                          right: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              'Total',
                              style: TextStyle(
                                color: AppColors.titleTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            CustomText(
                              '\$120.00',
                              style: TextStyle(
                                color: AppColors.titleTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 8),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: context.secondaryButton(
                              onPressed: () {},
                              text: 'Add to Cart',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: context.primaryButton(
                              onPressed: () {},
                              text: 'Shop Now',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
