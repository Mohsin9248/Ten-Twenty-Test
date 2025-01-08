import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hr_test/screens/cinema-booking.dart';
import 'package:hr_test/theme/app-colors.dart';
import 'package:hr_test/theme/fonts.dart';

class MovieBookingScreen extends StatefulWidget {
  const MovieBookingScreen({Key? key}) : super(key: key);

  @override
  _MovieBookingScreenState createState() => _MovieBookingScreenState();
}

class _MovieBookingScreenState extends State<MovieBookingScreen> {
  // List to track selected seats
  List<int> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            _buildDateSelector(context),
            const SizedBox(height: 35),
            Container(
              height: MediaQuery.of(context).size.height * 0.32,
              child: ListView.builder(
                reverse: true, // For right to left
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(left: 16, right: 16),
                itemCount: 3, // Adjust based on number of showtimes
                itemBuilder: (context, index) => _buildShowtimeCard(context),
              ),
            ),
            const Spacer(), // Pushes the button to the bottom
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                     Get.to(CinemaBookingScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    primary: AppColors.blue, // Button background color
                  ),
                  child: Text(
                    'Select Seats',
                    style: AppFonts.textStyle(context, 16, FontWeight.w600, AppColors.whiteColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context) {
    // Declare a state variable for the selected date
    String selectedDate = '5 Mar'; // Default selected date

    // Method to handle date selection
    void _onDateSelected(String date) {
      setState(() {
        selectedDate = date;
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Text(
            'Date',
            style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.black),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              _buildDateChip(context, '5 Mar', selectedDate == '5 Mar', _onDateSelected),
              _buildDateChip(context, '6 Mar', selectedDate == '6 Mar', _onDateSelected),
              _buildDateChip(context, '7 Mar', selectedDate == '7 Mar', _onDateSelected),
              _buildDateChip(context, '8 Mar', selectedDate == '8 Mar', _onDateSelected),
              _buildDateChip(context, '9 Mar', selectedDate == '9 Mar', _onDateSelected),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateChip(BuildContext context, String date, bool isSelected, Function onDateSelected) {
    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        child: Chip(
          label: Text(
            date,
            style: AppFonts.textStyle(
              context,
              12,
              FontWeight.w600,
              isSelected ? AppColors.whiteColor : AppColors.black,
            ),
          ),
          backgroundColor: isSelected ? AppColors.blue : Colors.grey[100],
        ),
      ),
    );
  }


  Widget _buildShowtimeCard(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '12:30',
                style: AppFonts.textStyle(context, 12, FontWeight.w500, AppColors.black),
              ),
              const SizedBox(width: 8),
              Text(
                'Cinetech + Hall 1',
                style: AppFonts.textStyle(context, 12, FontWeight.w400, AppColors.greyWritingColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(child: _buildSeatLayout()),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'From ',
                style: AppFonts.textStyle(context, 12, FontWeight.w500, AppColors.grey),
              ),
              Text(
                '50\$',
                style: AppFonts.textStyle(context, 12, FontWeight.bold, AppColors.black),
              ),
              Text(
                ' or ',
                style: AppFonts.textStyle(context, 12, FontWeight.w500, AppColors.grey),
              ),
              Text(
                '2500 bonus',
                style: AppFonts.textStyle(context, 12, FontWeight.bold, AppColors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSeatLayout() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.blue.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: 80,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedSeats.contains(index)) {
                  selectedSeats.remove(index);
                } else {
                  selectedSeats.add(index);
                }
              });
            },
            child: Center(
                child: SvgPicture.asset(
                  'assets/icons/seat_small.svg',
                  color: _getSeatColor(index),
                ),
              ),
          );
        },
      ),
    );
  }

  Color _getSeatColor(int index) {
    // Simulate some seats being available, taken, or selected
    if (index % 7 == 0) return AppColors.grey; // taken
    if (index % 5 == 0) return AppColors.blue.withOpacity(0.7); // pre-selected
    return Colors.blue.withOpacity(0.3); // available
  }
}
