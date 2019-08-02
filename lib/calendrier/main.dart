import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:projetsalon/calendrier/calendar_actions.dart';

const blc = Colors.white;
main() {
  runApp(MaterialApp(

      theme: ThemeData(

          fontFamily: 'AlexandriaFLF',
          primaryColor: blc,
          canvasColor: blc,
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
          inputDecorationTheme: InputDecorationTheme(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white54))),
      builder: (context, child) => ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          ),
      home: HomeScreen()));
}

class MyBehavior extends ScrollBehavior {
  buildViewportChrome(context, child, axisDirection) => child;
}

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formats = {
    InputType.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputType.date: DateFormat('yyyy-MM-dd'),
    InputType.time: DateFormat("HH:mm"),
  };
  // Changeable in demo
  InputType inputType = InputType.both;
  bool editable = true;
  DateTime date;
  String title;
  build(context) {
    return Scaffold(
        backgroundColor: blc,
        appBar: AppBar(title: Text("Rendez-vous"), centerTitle: true),
        body: _listView(),
        floatingActionButton: _floatingActionButton(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }

  FloatingActionButton _floatingActionButton(context) =>
      FloatingActionButton.extended(
          backgroundColor: Colors.black,
          icon: Icon(Icons.add),
          label:
              Text("", style: TextStyle(fontWeight: FontWeight.bold)),
          onPressed: () => _settingModalBottomSheet(context));

  _listView() => FutureBuilder(
        future: getCalendarEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) =>
                    EventListComponent(snapshot.data[index]));
          else
            return CircularProgressIndicator();
        },
      );
  void updateInputType({bool date, bool time}) {
    date = date ?? inputType != InputType.time;
    time = time ?? inputType != InputType.date;
    setState(() => inputType =
    date ? time ? InputType.both : InputType.date : InputType.time);
  }
  void _settingModalBottomSheet(context) {
    final a = TextEditingController();
    final daterdv = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
               ),
            padding: EdgeInsets.fromLTRB(
                20, 10, 20, MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
               
                 TextField(
                      controller: a,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: 'Nouveau rendez-vous',)
                  ),
             
                DateTimePickerFormField(

                  style: TextStyle(color: Colors.black),
                  controller: daterdv,
                  inputType: InputType.both,
                  format: DateFormat('yyyy-MM-dd hh:mm'),
                  editable: false,
                  decoration: InputDecoration(
                      labelText: 'Date du rendez-vous',
                      hasFloatingPlaceholder: false
                  ),
                  onSaved: (dt) {
                    setState(() => date = dt);
                    print('Selected date: $date');
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                      child:
                          Text("Enregistrer", style: TextStyle(color: Colors.black)),
                      onPressed: () {
                        addCalendarEvents(
                            title: a.text, startDate:DateTime.parse(daterdv.text));
                        Navigator.pop(context);
                        setState(() {});
                      },
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}

class EventListComponent extends StatelessWidget {
  final item;
  EventListComponent(this.item);
  build(context) {
    return Dismissible(
        background: Container(color: Colors.black),
        key: Key(item.eventId),
        onDismissed: (direction) {
          deleteCaldendarEvents(item.eventId);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Text(
            item.title,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
        ));
  }

}
