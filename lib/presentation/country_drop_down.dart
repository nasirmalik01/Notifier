import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:notifier_app/consts/assets.dart';
import 'package:notifier_app/consts/colors.dart';
import 'package:notifier_app/consts/config.dart';
import 'package:notifier_app/model/country.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountryDropDown extends StatefulWidget {
  const CountryDropDown({Key? key}) : super(key: key);


  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {



  Country? selectedCountry;
  late SharedPreferences _prefs;

  List<Country> countries =[
    const Country(Image(image: AssetImage(englishFlag), height: 30,), 'En'),
    const Country(Image(image:AssetImage(spanishFlag), height: 30,), 'Es'),
    const Country(Image(image: AssetImage(chineseFlag), height: 30,), 'Zh'),
    // const Item('iOS',Icon(Icons.mobile_screen_share,color:  const Color(0xFF167F67),)),
  ];

  getPrefs() async{
    _prefs = await SharedPreferences.getInstance();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getPrefs(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(!snapshot.hasData){
          return Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(top: heightMultiplier!*8, right: widthMultiplier!*8),
                child: const SpinKitFadingCircle(color: Colors.white,),
              ));
        }
        return Padding(
          padding: EdgeInsets.only(top: heightMultiplier!*8),
          child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: widthMultiplier!*5),
                child:  DropdownButtonHideUnderline(
                  child: DropdownButton<Country>(
                    // iconEnabledColor: Colors.white30,
                    dropdownColor: backColor,
                    hint: const Text(''),
                    value:  _prefs.getString('country') == null ? selectedCountry ?? countries[0]
                        : _prefs.getString('country') == 'China' ? countries[2]
                        : _prefs.getString('country') == 'Spain' ? countries[1]
                        : countries[0],
                    onChanged: (Country? value) {
                      if(mounted) {
                        setState(() {
                        selectedCountry = value!;
                        if(value.name == 'En'){
                          context.setLocale(const Locale('en'));
                          _prefs.setString('country', 'England');
                        }else if(value.name == 'Zh'){
                          context.setLocale(const Locale('zh'));
                          _prefs.setString('country', 'China');
                        }else{
                          context.setLocale(const Locale('es'));
                          _prefs.setString('country', 'Spain');
                        }
                      });
                      }
                    },
                    items: countries.map((Country country) {
                      return  DropdownMenuItem<Country>(
                        value: country,
                        child: Row(
                          children: [
                            country.icon,
                            const SizedBox(width: 10,),
                            Text(country.name, style: const TextStyle(
                              color: Colors.white
                            ),)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )),
        );
      },

    );

  }
}
