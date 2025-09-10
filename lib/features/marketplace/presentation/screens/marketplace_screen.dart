import 'package:flutter/material.dart';
import '../../../../dummy_data.dart';
import '../../../home/presentation/widgets/market_card.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Marketplace" , style: TextStyle(color: Color(0xFF1A3E74),fontWeight: FontWeight.w700, fontSize: 24, ),),
        // actions: const [
        //   CircleAvatar(child: Icon(Icons.ice_skating)),
        //   SizedBox(width: 12),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: dummyMarketItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisExtent: 240, // each card height
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return MarketCard(item: dummyMarketItems[index]);
          },
        ),
      ),
    );
  }
}
