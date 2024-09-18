import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants/network_utils.dart';
import '../domain/repository/logistics_repo.dart';
class Group {
  final int id;
  final int companyId;
  final String teamName;
  final String? code;
  final int? parentId;
  final int? addedBy;
  final int? lastUpdatedBy;

  Group({
    required this.id,
    required this.companyId,
    required this.teamName,
    this.code,
    this.parentId,
    this.addedBy,
    this.lastUpdatedBy,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      companyId: json['company_id'],
      teamName: json['team_name'],
      code: json['code'],
      parentId: json['parent_id'],
      addedBy: json['added_by'],
      lastUpdatedBy: json['last_updated_by'],
    );
  }
}

class GroupResponse {
  final bool success;
  final List<Group> data;

  GroupResponse({
    required this.success,
    required this.data,
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Group> groupList = list.map((i) => Group.fromJson(i)).toList();

    return GroupResponse(
      success: json['success'],
      data: groupList,
    );
  }
}




Future<List<Group>> fetchGroups() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final response = await http.get(
    Uri.parse('${NetworkUtils.baseUrl}/get-group'),
    headers: authorizationHeaders(prefs),
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final groupResponse = GroupResponse.fromJson(jsonResponse);

    if (groupResponse.success) {
      return groupResponse.data;
    } else {
      throw Exception('Failed to load groups');
    }
  } else {
    throw Exception('Failed to load groups');
  }
}
