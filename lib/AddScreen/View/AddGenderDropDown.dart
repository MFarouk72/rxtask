import 'package:flutter/material.dart';
import 'package:rxtask/Commons/CommonBlocs/UserBloc.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/localization/localizations.dart';

class AddGenderDropdownWidget extends StatefulWidget {
  late UserBloc userBloc;
  AddGenderDropdownWidget(this.userBloc);

  @override
  _AddGenderDropdownWidgetState createState() => _AddGenderDropdownWidgetState();
}

class _AddGenderDropdownWidgetState extends State<AddGenderDropdownWidget> {
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
          stream: widget.userBloc.selectedGenderStream,
          builder: (context, snapshot) {
            return DropdownButtonFormField(
              value: snapshot.data,
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
              items:widget.userBloc.genderMap.keys.map((e) {
                return DropdownMenuItem<String>(
                    value: e,
                    child: Text(e));
              }).toList(),
              onChanged: (value) {
                widget.userBloc.changeGender(value.toString());
              },
            );
          }
      ),
    );
  }
}


