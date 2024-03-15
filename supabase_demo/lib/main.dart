// Import von notwendigen Paketen für die Flutter-App und Supabase-Integration
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Die main-Funktion ist der Einstiegspunkt für jede Flutter-App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Initialisiert Supabase mit der URL zu deinem Projekt und einem anonymen Schlüssel für die Authentifizierung
  await Supabase.initialize(
    url: 'https://vvnognjnujbnafbwcgvt.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ2bm9nbmpudWpibmFmYndjZ3Z0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAwODQxNzUsImV4cCI6MjAyNTY2MDE3NX0.c4jtR4hXBdh7-KLQWMPv5o0umRO6-y4tHusdxXj6yP8',
  );
  // Startet die Flutter-App.
  runApp(const MyApp());
}

// Eine StatelessWidget-Klasse, die das Grundgerüst der App definiert
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Erstellt eine MaterialApp-Instanz, definiert den Titel der App und setzt die Startseite
    return const MaterialApp(
      title: 'Countries',
      home: HomePage(),
    );
  }
}

// Eine StatefulWidget-Klasse für die Startseite, die eine dynamische Interaktion ermöglicht
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// Der State für die HomePage, der die Logik und das UI für die Anzeige der Daten beinhaltet
class _HomePageState extends State<HomePage> {
  // Erstellt eine Future-Variable für den asynchronen Datenabruf aus Supabase
  final _future = Supabase.instance.client.from('countries').select();

  @override
  Widget build(BuildContext context) {
    // Scaffold bietet das Grundlayout für die Anzeige von Inhalten
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          // Zeigt einen Ladekreis an, wenn die Daten noch nicht verfügbar sind
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          // Wenn Daten vorhanden sind, werden sie in einer Liste angezeigt
          final countries = snapshot.data!;
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: ((context, index) {
              final country = countries[index];
              // Erstellt ein ListTile für jedes Land mit seinem Namen
              return ListTile(
                title: Text(country['name']),
              );
            }),
          );
        },
      ),
    );
  }
}
