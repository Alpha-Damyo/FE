import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

const int won = 225;
bool _isPrice = false;
int _selectedIndex = -1;
var allcnt;

class calculatePrice extends StatefulWidget {
  const calculatePrice({super.key});

  @override
  State<calculatePrice> createState() => _calculatePriceState();
}

class _calculatePriceState extends State<calculatePrice> {
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.h, left: 16.w),
          child: const Text(
            '나의 담배가격 계산해보기',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 100.h,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedIndex == index) {
                          _selectedIndex = -1;
                        } else {
                          _selectedIndex = index;
                        }
                      });
                    },
                    child: Container(
                      height: 29.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                      ),
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: _selectedIndex == index
                            ? Border.all(
                                color: Theme.of(context).colorScheme.primary,
                              )
                            : Border.all(
                                color: const Color(0xffE4E7EB),
                              ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'test $index',
                          style: const TextStyle(
                            color: Color(0xFF464D57),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                child: const Text(
                  '직접 입력하기',
                  style: TextStyle(
                    color: Color(0xFF454D56),
                    fontSize: 12,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _isPrice = !_isPrice;
                    _priceController.clear();
                    allcnt = 0;
                    print(_isPrice);
                  });
                },
              ),
              if (_isPrice)
                SizedBox(
                  width: 100.w,
                  child: TextField(
                    controller: _priceController,
                    textAlign: TextAlign.right,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) {
                      setState(() {
                        if (!_isFieldEmpty(_priceController)) {
                          allcnt = int.parse(_priceController.text);
                        } else {
                          allcnt = 0;
                        }
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: '개비 수를 입력해주세요.',
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    style: const TextStyle(
                      color: Color(0xFF454D56),
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  (_isPrice) ? _priceController.text + ' 개비' : '63 개비',
                  style: const TextStyle(
                    color: Color(0xFF454D56),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                child: Text(
                  (_isPrice) ? formatCurrency(allcnt) : '13,500원',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF0099FC),
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String formatCurrency(var cnt) {
    int price = cnt * won;
    final formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '');
    return '${formatter.format(price)}원';
  }

  bool _isFieldEmpty(TextEditingController controller) {
    return controller.text.trim().isEmpty;
  }
}
