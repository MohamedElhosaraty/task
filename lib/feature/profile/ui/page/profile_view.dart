import 'package:flutter/material.dart';
import 'package:task/feature/profile/ui/widget/profile_view_body.dart';


class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileViewBody(),
    );
  }
}
