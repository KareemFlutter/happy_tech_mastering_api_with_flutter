import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is GetUserDataFailureState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: state is GetUserDataLoadingState
                ? const CircularProgressIndicator()
                : state is GetUserDataSuccessState
                    ? ListView(
                        children: [
                          const SizedBox(height: 16),
                          //! Profile Picture
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(state.userModel.profilePic),
                          ),
                          const SizedBox(height: 16),

                          //! Name
                          ListTile(
                            title: Text(state.userModel.name),
                            leading: const Icon(Icons.person),
                          ),
                          const SizedBox(height: 16),

                          //! Email
                          ListTile(
                            title: Text(state.userModel.email),
                            leading: const Icon(Icons.email),
                          ),
                          const SizedBox(height: 16),

                          //! Phone number
                          ListTile(
                            title: Text(state.userModel.phone),
                            leading: const Icon(Icons.phone),
                          ),
                          const SizedBox(height: 16),

                          //! Address
                          ListTile(
                            title: Text(state.userModel.location['type']),
                            leading: const Icon(Icons.location_city),
                          ),
                          const SizedBox(height: 16),
                        ],
                      )
                    : Container());
      },
    );
  }
}
