import 'package:flutter/material.dart';
import 'package:projetsalon/recettes/vente/ui/listview_note.dart';

void main() => runApp(
      MaterialApp(
        title: 'Monsalon',
        color: Colors.black,
        theme: ThemeData(fontFamily: 'AlexandriaFLF'),
        home: ListViewVente(),
      ),
    );
