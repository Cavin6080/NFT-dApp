import 'package:alan_voice/alan_voice.dart';
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nft/app/widgets/animated_scroll_view_item.dart';
import 'package:nft/app/widgets/custom_animated_scale.dart';
import 'package:nft/app/widgets/custom_text_field.dart';
import 'package:nft/contract_linking.dart';
import 'package:nft/logic.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<HomeController>();
    AlanVoice.addButton(
      "99b3f541de1a702448cb65a189de34ea2e956eca572e1d8b807a3e2338fdd0dc/stage",
      buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT,
    );
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            "assets/images/bg.png",
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            toolbarHeight: 100,
            title: SizedBox(
              width: 320,
              child: Text.rich(
                maxLines: 3,
                softWrap: true,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "explore ".toUpperCase(),
                      style: GoogleFonts.lato(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'collect',
                      style: GoogleFonts.lato(
                        letterSpacing: 1,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' and sell more',
                      style: GoogleFonts.lato(
                        letterSpacing: 1,
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: ' NFT 🔥'.toUpperCase(),
                      style: GoogleFonts.lato(
                        letterSpacing: 1,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 25),
                GetBuilder<HomeController>(
                  builder: (logic) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: ListView.separated(
                          itemCount:
                              logic.quotes.length > 0 ? logic.quotes.length : 1,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          // shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            // return 1 > 0
                            return logic.quotes.length > 0
                                ? CustomAnimatedScale(
                                    onTap: () {},
                                    child: AnimatedScrollViewItem(
                                      child: GlassmorphicContainer(
                                        width: double.infinity,
                                        height: 150,
                                        borderRadius: 20,
                                        blur: 20,
                                        alignment: Alignment.bottomCenter,
                                        border: 2,
                                        linearGradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            const Color(0xFFffffff)
                                                .withOpacity(0.4),
                                            const Color(0xFFFFFFFF)
                                                .withOpacity(0.05),
                                          ],
                                          stops: const [
                                            0.1,
                                            1,
                                          ],
                                        ),
                                        borderGradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            const Color(0xFFffffff)
                                                .withOpacity(0.5),
                                            const Color((0xFFFFFFFF))
                                                .withOpacity(0.5),
                                          ],
                                        ),
                                        child: Stack(
                                          children: [
                                            const Positioned(
                                              top: 12,
                                              left: 12,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.blue,
                                              ),
                                            ),
                                            Positioned(
                                              top: 18,
                                              left: 46,
                                              child: Text(
                                                "${Faker().person.name()}",
                                                style: GoogleFonts.nunitoSans(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    20,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 20.0,
                                                  ),
                                                  child: Text(
                                                    textAlign: TextAlign.left,
                                                    logic.quotes[index],
                                                    // "cavin ",
                                                    maxLines: 4,
                                                    style: GoogleFonts.ubuntu(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 10,
                                              right: 10,
                                              child: Icon(
                                                Icons.favorite_border_outlined,
                                                color: Colors.pink.shade50,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : CustomAnimatedScale(
                                    onTap: () {
                                      Get.dialog(
                                        barrierDismissible: true,
                                        CustomDialog(),
                                      );
                                    },
                                    child: GlassmorphicContainer(
                                      width: double.infinity,
                                      height: 150,
                                      borderRadius: 20,
                                      blur: 40,
                                      alignment: Alignment.bottomCenter,
                                      border: 2,
                                      linearGradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            const Color(0xFFffffff)
                                                .withOpacity(0.4),
                                            const Color(0xFFFFFFFF)
                                                .withOpacity(0.05),
                                          ],
                                          stops: const [
                                            0.1,
                                            1,
                                          ]),
                                      borderGradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          const Color(0xFFffffff)
                                              .withOpacity(0.5),
                                          const Color((0xFFFFFFFF))
                                              .withOpacity(0.5),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Create your first NFT",
                                          style: GoogleFonts.farsan(
                                            fontSize: 22,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 20);
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Get.dialog(
                barrierDismissible: true,
                CustomDialog(),
              );
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}

class CustomDialog extends StatelessWidget {
  CustomDialog({Key? key}) : super(key: key);

  final HomeController logic = Get.find();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GlassmorphicContainer(
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.bottomCenter,
        border: 2,
        linearGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFffffff).withOpacity(0.5),
              const Color(0xFFFFFFFF).withOpacity(0.09),
            ],
            stops: const [
              0.1,
              1,
            ]),
        borderGradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.transparent,
            Colors.transparent,
          ],
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 250,
        ),
        height: 300,
        width: 100,
        // color: Colors.red,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Form(
                    key: logic.registerFormKey,
                    child: TextInputField(
                      hinttext: 'Enter your NFT text',
                      editingController: logic.controller,
                      multiValidator: MultiValidator(
                        [
                          RequiredValidator(
                            errorText: "Your NFT text is emtpy",
                          )
                        ],
                      ),
                      hintStyle: GoogleFonts.amaranth(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () => logic.onTap(),
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.withOpacity(0.8),
                          Colors.blue.shade400,
                        ],
                        stops: const [0.4, 1],
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {},
              //   style: ButtonStyle(
              //     backgroundColor:
              //         MaterialStateProperty.all(Colors.blue),
              //   ),
              //   child: Text(
              //     "SUBMIT",
              //     style: GoogleFonts.amaranth(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w500,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
