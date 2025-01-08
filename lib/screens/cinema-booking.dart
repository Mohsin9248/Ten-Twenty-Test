import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr_test/widgets/button-style.dart';

import '../theme/app-colors.dart';
import '../theme/fonts.dart';

class CinemaBookingScreen extends StatefulWidget {
  @override
  _CinemaBookingScreenState createState() => _CinemaBookingScreenState();
}

class _CinemaBookingScreenState extends State<CinemaBookingScreen> {
  List<List<String>> seats = [
    ['available', 'available', 'available', 'vip', 'available'],
    ['available', 'vip', 'selected', 'vip', 'available'],
    ['available', 'vip', 'notAvailable', 'vip', 'available'],
    ['available', 'available', 'available', 'available', 'available'],
  ];

  int selectedSeatsCount = 1;
  double totalPrice = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 16),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "The King's Man",
              style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.black),
            ),
            Text(
              "In Theaters December 22, 2021",
              style: AppFonts.textStyle(context, 12, FontWeight.w500, AppColors.blue),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Representation
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'SCREEN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            // Seats Layout
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,  // Number of seats per row
                  crossAxisSpacing: 4,  // Reduced horizontal spacing
                  mainAxisSpacing: 4,   // Reduced vertical spacing
                ),
                itemCount: seats.length * 5,  // Adjust total number of seats
                itemBuilder: (context, index) {
                  int row = index ~/ 5;
                  int seat = index % 5;
                  String seatType = seats[row][seat];

                  return GestureDetector(
                    onTap: seatType == 'notAvailable'
                        ? null
                        : () {
                      setState(() {
                        if (seatType == 'selected') {
                          seats[row][seat] = 'available';
                          selectedSeatsCount--;
                          totalPrice -= 50;
                        } else if (seatType == 'available' || seatType == 'vip') {
                          seats[row][seat] = 'selected';
                          selectedSeatsCount++;
                          totalPrice += seatType == 'vip' ? 150 : 50;
                        }
                      });
                    },
                    child: SizedBox(
                      width: 16,  // Set width of the seat to less than 80%
                      height: 16, // Set height of the seat to less than 80%
                      child: SvgPicture.asset(
                        "assets/icons/seat.svg",
                        color: seatType == 'selected'
                            ? AppColors.golden
                            : seatType == 'notAvailable'
                            ? AppColors.grey
                            : seatType == 'vip'
                            ? AppColors.purple
                            : AppColors.blue,
                      ),
                    ),
                  );
                },
              ),
            ),
// Seat Type Legend
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      seatTypeIndicator(AppColors.golden, 'Selected'),
                      SizedBox(height: 12), // Reduced gap between widgets
                      seatTypeIndicator(AppColors.grey, 'Not available'),
                    ],
                  ),
                  SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      seatTypeIndicator(AppColors.purple, 'VIP (150\$)'),
                      SizedBox(height: 12), // Reduced gap between widgets
                      seatTypeIndicator(AppColors.blue, 'Regular (50\$)'),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24,),
            // Row and Seat Selection
            Container(
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],  // Set the desired background color here
                borderRadius: BorderRadius.circular(16),  // Optional: to round the corners
              ),
              padding: EdgeInsets.all(8),  // Optional: add some padding around the content
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Selected seats count
                  Text(
                    '$selectedSeatsCount',
                    style: AppFonts.textStyle(context, 20, FontWeight.w600, AppColors.black),  // Larger font for the seat count
                  ),
                  SizedBox(width: 4), // Spacing between the seat count and the slash
                  // Slash separator
                  Text(
                    '/',
                    style: AppFonts.textStyle(context, 18, FontWeight.w500, AppColors.black),  // Slightly smaller font for the slash
                  ),
                  SizedBox(width: 4), // Spacing between the slash and the total row text
                  // Total row
                  Text(
                    '3 row',
                    style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.blueDark),  // Regular font for the total row text
                  ),
                  SizedBox(width: 8), // Spacing between the row text and the close icon
                  // Close icon button
                  GestureDetector(
                    onTap: () {
                      // Handle close action here
                    },
                    child: Icon(
                      Icons.close,
                      size: 18,  // Adjust the icon size as needed
                      color: AppColors.black,  // Icon color
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24,),

            Row(
              children: [
                ElevatedButton(
                  style: customElevatedButtonStyleWhite(
                    height: MediaQuery.of(context).size.height / 16,
                    width: MediaQuery.of(context).size.width / 3.8,
                  ),
                  onPressed: () {
                    // Add your payment logic here
                  },
                  child: Column(
                    children: [
                      Text('Total Price',style: AppFonts.textStyle(context, 10, FontWeight.w400, AppColors.blueDark),),
                      Text(
                        "\$50",  // Add the dollar sign before the number
                        style: AppFonts.textStyle(context, 16, FontWeight.w600, AppColors.blueDark),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16,),
                ElevatedButton(
                  style: customElevatedButtonStyle(
                    height: MediaQuery.of(context).size.height / 16,
                    width: MediaQuery.of(context).size.width / 1.66,
                  ),
                  onPressed: () {
                    // Add your payment logic here
                  },
                  child: Text('Proceed to pay',style: AppFonts.textStyle(context, 16, FontWeight.w600, AppColors.whiteColor),),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget seatTypeIndicator(Color color, String label) {
    return Row(
      children: [
        SvgPicture.asset("assets/icons/seat.svg",color: color,),
       
        SizedBox(width: 8),
        Text(label,style: AppFonts.textStyle(context, 12, FontWeight.w500, AppColors.greyWritingColor),),
      ],
    );
  }
}
