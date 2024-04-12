import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/AppTypography.dart';

class DailyReminder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: (){},
      child: Ink(
        width: double.infinity,
        height: 95,
        decoration: BoxDecoration(
          color: Color(0xFF333242),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('Assets/Mask Group.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 285,
              height: 26,
              child: Padding(
                padding: const EdgeInsets.only(left: 22),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ежедневное напоминание',
                        style: AppTypography.f18w400),

                    Text('Медетируйте  3-10 MIN',
                        style: AppTypography.f18w400
                            .copyWith(fontSize: 11)),
                  ],
                ),
              ),
            ),
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Center(
                  child: SvgPicture.asset(
                    'Assets/icons/Vector.svg',
                    width: 12,
                    height: 12,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
