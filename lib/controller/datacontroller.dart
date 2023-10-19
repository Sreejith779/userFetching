import 'dart:convert';

import 'package:flutter/services.dart'as rootBundle;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models.dart';

class UserController extends GetxController {
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<UserModel> team = <UserModel>[].obs;

  final selectedDomain = 'All'.obs;
  final selectedGender = 'All'.obs;
  final available = false.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final response = await rootBundle.rootBundle.loadString('assets/data.json'); // Change the path as needed
    final data = json.decode(response) as List<dynamic>;
    users.assignAll(data.map((e) => UserModel.fromJson(e)));
  }

  void applyFilters() {
    final filteredUsers = users.where((user) {
      return (selectedDomain.value == 'All' || user.domain == selectedDomain.value) &&
          (selectedGender.value == 'All' || user.gender == selectedGender.value) &&
          (!available.value || user.available) &&
          (searchQuery.value.isEmpty ||
              user.firstName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
              user.lastName.toLowerCase().contains(searchQuery.value.toLowerCase()));
    }).toList();

    users.assignAll(filteredUsers);
  }

  void addToTeam(UserModel user) {
    if (!team.contains(user)) {
      team.add(user);
    }
  }

  void removeFromTeam(UserModel user) {
    team.remove(user);
  }

  List<String> getUniqueDomains() {
    final uniqueDomains = users.map((user) => user.domain).toSet().toList();
    uniqueDomains.insert(0, 'All');
    return uniqueDomains;
  }

  List<String> getUniqueGenders() {
    final uniqueGenders = users.map((user) => user.gender).toSet().toList();
    uniqueGenders.insert(0, 'All');
    return uniqueGenders;
  }
}