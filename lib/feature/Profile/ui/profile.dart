import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart/feature/auth/firebase/save_data.dart';
import 'package:smart/utils/colors2.dart';
import 'package:smart/utils/pickimg.dart';

import '../../../utils/AppTypography.dart';
import '../../../widgets/bar/AppBarBack.dart';
import '../../../widgets/buttons/custom_text_batton.dart';
import '../../auth/firebase/get_data.dart';
import '../widget/FractionallyCont.dart';
import '../widget/StatConteiner.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Uint8List? _image;
  var user = FirebaseAuth.instance.currentUser;
  String? imgLink;
  List<String> users = [];
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    GetData().getusers().then((List<String> value) => setState(() {
          users = value;
        }));
    GetData().gettasks().then((List<String> value) => setState(() {
          tasks = value;
        }));
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
      StoreData()
          .uploadImageToStorage('profile_img/${user!.uid}', _image!)
          .then((value) {
        setState(() {
          imgLink = value;
          StoreData().postProfileToFirestore(imgLink!);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          text: '',
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('userProfile')
                .snapshots(),
            builder: (context, snapshot) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColors.violet, width: 3),
                          ),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot
                                .data!.docs[users.indexOf(user!.uid)]
                                .get('Profileimg')),
                            radius: 50,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          bottom: -12,
                          right: -8,
                          child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              color: AppColors.violet,
                            ),
                            onPressed: selectImage,
                          ),
                        )
                      ]),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                        '${snapshot.data!.docs[users.indexOf(user!.uid)].get('name')}',
                        style: AppTypography.f24w400),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 25),
                    child: Row(
                      children: [
                        Text(
                          'Статистика',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                            letterSpacing: 0.02,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidget(
                          iconPath: 'Prof2.svg',
                          countText:
                              '${snapshot.data!.docs[users.indexOf(user!.uid)].get('Tests')}',
                          descriptionText: 'Тестов пройдено',
                        ),
                        CustomWidget(
                          iconPath: 'Prof4.svg',
                          countText:
                              '${snapshot.data!.docs[users.indexOf(user!.uid)].get('healthlvl')}',
                          descriptionText: 'Уровень персонажа',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomWidget(
                          iconPath: 'Prof3.svg',
                          countText: '${tasks.length}',
                          descriptionText: 'Заданий выполнено',
                        ),
                        CustomWidget(
                          iconPath: 'Prof1.svg',
                          countText:
                              '${snapshot.data!.docs[users.indexOf(user!.uid)].get('CountTexts')}',
                          descriptionText: 'Статей прочитано',
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Достижения',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: [
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: MeditationWidget(
                              currentCount: snapshot
                                  .data!.docs[users.indexOf(user!.uid)]
                                  .get('CountTexts'),
                              count: 5,
                              description: 'Прочитать статью',
                              text: 'Чтец',
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: MeditationWidget(
                              currentCount: tasks.length,
                              count: 5,
                              description: 'Выполнить задание',
                              text: 'Первые шаги',
                            )),
                        const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: MeditationWidget(
                              currentCount: 0,
                              count: 20,
                              description: 'Помедитировать',
                              text: 'Медитатор',
                            )),
                        Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            child: MeditationWidget(
                              currentCount: snapshot
                                  .data!.docs[users.indexOf(user!.uid)]
                                  .get('Tests'),
                              count: 5,
                              description: 'Пройти тест',
                              text: 'Тестер',
                            )),

                      ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomTextButton(isActive: true, text: 'Выход', callback: () { FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false); }, height: 30, width: 100, border: 90,),
                  ),

                ],
              );
            }));
  }
}
