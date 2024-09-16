import 'package:flutter/material.dart';
import 'package:todo_app/modules/auth/domain/entities/user.dart';
import 'package:todo_app/modules/auth/presentation/component/profile_data_field_widget.dart';

import '../../../../../widgets/scaffold_widget.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.userProfile});

  final User userProfile;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      title: "Profile",
      body: ListView(
        children: [
          ProfileDataFieldWidget(title: "Name", data: userProfile.displayName),
          ProfileDataFieldWidget(title: "Phone", data: userProfile.username),
          ProfileDataFieldWidget(title: "Level", data: userProfile.level),
          ProfileDataFieldWidget(
            title: "Years of experience",
            data: '${userProfile.experienceYears} years',
          ),
          ProfileDataFieldWidget(title: "Location", data: userProfile.address),
        ],
      ),
    );
  }
}
