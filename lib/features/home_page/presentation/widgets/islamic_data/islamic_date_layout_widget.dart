import 'package:flutter/material.dart';
import 'package:iccmw/features/app_theme/utils/app_theme_data.dart';
import 'package:iccmw/features/home_page/presentation/widgets/islamic_data/islamic_data_widget.dart';
import 'package:iccmw/features/home_page/presentation/widgets/prayer_table/prayer_list_widget.dart';
import 'package:intl/intl.dart';

class IslamicDateLayoutWidget extends StatefulWidget {
  const IslamicDateLayoutWidget({super.key});

  @override
  State<IslamicDateLayoutWidget> createState() =>
      IslamicDateLayoutWidgetState();
}

class IslamicDateLayoutWidgetState extends State<IslamicDateLayoutWidget> {
  final PageController _pageController = PageController();
  final now = DateTime.now();
  final formatter = DateFormat('EEEE d MMMM yyyy');
  final formatterDay = DateFormat('dd');
  late String nowDay = formatterDay.format(now);

  // String nowDate = nowToday.toString();

  late Map<String, dynamic> prayersData = {};

  final List<DateTime> dates = List.generate(
    460,
    (index) => DateTime.now().add(Duration(days: index - 0)),
  );
  late int _currentIndex = 0;

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < dates.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 350,
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: dates.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  final currentDate = dates[index];
                  // print(currentDate);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: _goToPrevious,
                              // icon: const Icon(Icons.arrow_back_ios),
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: commonComponentColor,
                              ),
                            ),
                            IslamicDataWidget(selectedDate: currentDate),
                            IconButton(
                              onPressed: _goToNext,
                              icon: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: commonComponentColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: PrayerListWidget(selectedDate: currentDate)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
