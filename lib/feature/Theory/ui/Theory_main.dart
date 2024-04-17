import 'package:flutter/material.dart';

import '../../../utils/colors2.dart';
import '../../../widgets/bar/AppBarAvatar.dart';
import '../../Recimendation/widget/PlayWid.dart';
import '../../auth/firebase/get_data.dart';
import '../widgets/TheoryCont.dart';

class Theory extends StatefulWidget {
  @override
  State<Theory> createState() => _TheoryState();
}

class _TheoryState extends State<Theory> {
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAvatar(text: 'Справочник'),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ThepryCont(
                  time: '10',
                  chapter: 'Стресс',
                  description: 'Абстрогируйтесь от проблем',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/stat');
                  },
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ThepryCont(
                  time: '20',
                  chapter: 'Выгорание',
                  description: 'Зажгите огонь внутри себя ',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/stat2');
                  },
                )),
          ),
          SliverToBoxAdapter(
            child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ThepryCont(
                  time: '20',
                  chapter: 'Медитации',
                  description: 'Найдите свой внутренний мир ',
                  onTap: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/stat3');
                  },
                )),
          )
        ],
      ),
    );
  }
}
