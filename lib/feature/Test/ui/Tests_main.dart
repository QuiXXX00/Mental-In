import 'package:flutter/material.dart';
import 'package:smart/widgets/bar/AppBarAvatar.dart';
import '../widget/CustomTestButton.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAvatar(text: 'Тесты'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TestContainerWidget(
                title: 'Узнать свой психологический возвраст',
                time: '10-15',
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pushNamed('/testik');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
