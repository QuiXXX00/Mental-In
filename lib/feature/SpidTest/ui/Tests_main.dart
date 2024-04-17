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
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: TestContainerWidget(
                title: 'Тест Айзенка',
                time: '10-15',
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/testik');
                },
                description: 'Он способен определить нейропсихическую лабильность, экстраверсию – интроверсию. В 1968г. к нему была добавлена шкала психотизма. С тех пор адаптированный тест Айзенка известен миру, как опросник «EPQ»(его иногда называют «PEN»).',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: TestContainerWidget(
                title: 'Тест для определения психологического возраста',
                time: '5-10',
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/testik2');
                },
                description: 'Перед вами 10 вопросов. Выберите тот вариант ответа («А», «Б» или «В»), который наиболее соответствует вашим убеждениям и мнению в отношении себя.',
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: TestContainerWidget(
                title: 'Шкала тревоги Спилбергера',
                time: '15-20',
                onTap: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed('/testik3');
                },
                description: 'В первом блоке (20 вопросов):Прочитайте внимательно каждое из приведенных предложений.Выбирайте ответ в зависимости от того, как вы себя чувствуете в данный момент.Во втором блоке (20 вопросов):Прочитайте внимательно каждое из приведенных предложений.Выбирайте ответ в зависимости от того, как вы себя чувствуете обычно.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
