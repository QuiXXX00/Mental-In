import 'dart:ffi';
import 'package:flutter/cupertino.dart';

import '../../utils/colors2.dart';
import '../../utils/fonts.dart';
import 'CoinData.dart';

class ConteinerGame extends StatelessWidget {
  ConteinerGame(
      {super.key,
      required this.imageUrl,
      required this.textDescription,
      required this.maxCount,
      required this.currentCount});

  final String imageUrl;
  final int maxCount;
  final int currentCount;
  final String textDescription;

  List<Widget> _generatePriceItem(List<CoinData> coinsInfo) {
    List<Widget> children = [];

    for (var i in coinsInfo) {
      children.add(PriceItem(data: i));
      children.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 4),
          child: Text(
            '+',
            style: AppFonts.price.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }
    children.removeLast();
    return children;
  }

  List<CoinData> hui = List.generate(
      3, (index) => CoinData(imageUrl: 'assets/Coins.png', value: '1,520'));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 250,
      padding: EdgeInsets.all(6),
      // decoration: ShapeDecoration(
      //   color: AppColors.city,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 160,
            height: 160,
            padding: EdgeInsets.all(4),
            decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                image: DecorationImage(
                    image: AssetImage(imageUrl), fit: BoxFit.cover)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 17,
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        color: Color(0xFFEB2121),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        'НОВОЕ',
                        style: AppFonts.font12w400,
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/img.png')
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            width: 204,
            height: 30,
            child: Text(
              textDescription,
              style: AppFonts.sale.copyWith(color: AppColors.textSecondary),
            ),
          )
        ],
      ),
    );
  }
}

class PriceItem extends StatelessWidget {
  const PriceItem({super.key, required this.data});

  final CoinData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            data.imageUrl,
            width: 16,
            height: 16,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            data.value,
            style: AppFonts.price.copyWith(color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
