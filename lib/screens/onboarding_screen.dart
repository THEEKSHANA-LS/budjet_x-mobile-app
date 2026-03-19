import 'package:budjet_x/constants/colors.dart';
import 'package:budjet_x/data/onboarding_data.dart';
import 'package:budjet_x/screens/onboarding/front_page.dart';
import 'package:budjet_x/screens/onboarding/shared_onbording_screen.dart';
import 'package:budjet_x/screens/user_data_screen.dart';
import 'package:budjet_x/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller for page view...
  final PageController _controller = PageController();
  bool showDetailPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //onboarding screens...
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailPage = index == 3;
                    });
                  },
                  children: [
                    const FrontPage(),
                    SharedOnbordingScreen(
                      title: OnboardingData.onbordingDataList[0].title,
                      imagePath: OnboardingData.onbordingDataList[0].imagePath,
                      description:
                          OnboardingData.onbordingDataList[0].description,
                    ),
                    SharedOnbordingScreen(
                      title: OnboardingData.onbordingDataList[1].title,
                      imagePath: OnboardingData.onbordingDataList[1].imagePath,
                      description:
                          OnboardingData.onbordingDataList[1].description,
                    ),
                    SharedOnbordingScreen(
                      title: OnboardingData.onbordingDataList[2].title,
                      imagePath: OnboardingData.onbordingDataList[2].imagePath,
                      description:
                          OnboardingData.onbordingDataList[2].description,
                    ),
                  ],
                ),

                //page view indicators...
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),

                //navigation buttons...
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: !showDetailPage
                        ? GestureDetector(
                            onTap: () {
                              _controller.animateToPage(
                                _controller.page!.toInt() + 1,
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            },
                            child: CustomButton(
                              buttonName: showDetailPage
                                  ? "Get Started"
                                  : "Next",
                              buttonColor: kMainColor,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              //Navigate to the user data screen...
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserDataScreen(),
                                ),
                              );
                            },
                            child: CustomButton(
                              buttonName: showDetailPage
                                  ? "Get Started"
                                  : "Next",
                              buttonColor: kMainColor,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


