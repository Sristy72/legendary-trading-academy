import 'package:flutter/cupertino.dart';
import 'package:flutter_ladydenily/core/network/api_client.dart';
import 'package:flutter_ladydenily/features/calender/data/calender_repository_impl.dart';
import 'package:flutter_ladydenily/features/calender/models/event_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarController extends GetxController {
  final _repository = CalenderRepositoryImpl(apiClient: ApiClient());

  final selectedDate = DateTime.now().obs;
  final currentMonth = DateTime.now().obs;
  final dayScroll = ScrollController().obs;
  
  // Using simplified list since API returns list for a date
  final events = <EventModel>[].obs; 
  final isLoading = false.obs;

  List<DateTime> get daysInMonth {
    final first = DateTime(
      currentMonth.value.year,
      currentMonth.value.month,
      1,
    );
    final nextMonth = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
      1,
    );
    final last = nextMonth.subtract(const Duration(days: 1));
    return List.generate(
      last.day,
      (i) => DateTime(first.year, first.month, i + 1),
    );
  }

  @override
  void onInit() {
    super.onInit();
    // Fetch initial events
    fetchEvents(selectedDate.value);
  }

  @override
  void onReady() {
    super.onReady();
    _scrollToSelected();
  }

  Future<void> fetchEvents(DateTime date) async {
    isLoading.value = true;
    final formattedDate = DateFormat('yyyy-MM-dd').format(date);
    
    final result = await _repository.getEvents(formattedDate);
    
    result.fold(
      (failure) {
        isLoading.value = false;
        // Handle error quietly or show empty
        print('Error fetching events: ${failure.message}');
        events.clear();
      },
      (success) {
        isLoading.value = false;
        events.assignAll(success.data);
      },
    );
  }

  void goPrevMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month - 1,
      1,
    );
  }

  void goNextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
      1,
    );
  }

  void selectDate(DateTime date) {
    selectedDate.value = date;
    fetchEvents(date); // Fetch on selection
    _scrollToSelected();
  }

  void _scrollToSelected() {
    try {
      if (!dayScroll.value.hasClients) return;
      
      final controllerRef = dayScroll.value;
      final index = selectedDate.value.day - 1.2;
      final itemExtent = 64.0 + 7.0;
      final offset = (index * itemExtent) - 16;
      
      controllerRef.animateTo(
        offset.clamp(0, controllerRef.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } catch (e) {
      print('Scroll error: $e');
    }
  }
}
