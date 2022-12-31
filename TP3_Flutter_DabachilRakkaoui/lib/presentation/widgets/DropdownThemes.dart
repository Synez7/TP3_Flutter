import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubits/DropdownCubit.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({Key? key, required this.thematics}) : super(key: key);

  final List<String> thematics;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DropdownCubit, String>(builder: (context, value) {
      return Padding(
        padding: const EdgeInsets.only(left: 60, right: 60,top: 10),
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            )
          ),
          value: value,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          onChanged: (String? val) {
            if (val != null) {
              context.read<DropdownCubit>().setValue(val);
            }
          },
          items: thematics
              .map(
                (val) => DropdownMenuItem(
                  value: val,
                  child: Text(
                    val,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );
    });
  }
}
