import 'package:flutter/material.dart';
import 'package:rxtask/EditScreen/Bloc/EditScreenBloc.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/localization/localizations.dart';

class EditGenderDropdownWidget extends StatefulWidget {
  late EditScreenBloc editScreenBloc;
  EditGenderDropdownWidget(this.editScreenBloc);

  @override
  _EditGenderDropdownWidgetState createState() => _EditGenderDropdownWidgetState();
}

class _EditGenderDropdownWidgetState extends State<EditGenderDropdownWidget> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding  , top: SizeConfig.padding /2 , bottom: SizeConfig.padding /2),
      child: StreamBuilder(
          stream: widget.editScreenBloc.selectedGenderStream,
          builder: (context, snapshot) {
            return DropdownButtonFormField(
              value:snapshot.data,
              style: TextStyle(
                color: AppColors.BLACK_COLOR,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textFontSize,
              ),
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.selectGender,
                labelStyle: TextStyle(
                  color: AppColors.BLACK_COLOR,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textFontSize,
                ),
                border: OutlineInputBorder(),
              ),
              items:widget.editScreenBloc.genderMap.keys.map((value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value));
              }).toList(),
              onChanged: (value) {
                widget.editScreenBloc.changeGender(value.toString());
              },
            );
          }
      ),
    );
  }
}


