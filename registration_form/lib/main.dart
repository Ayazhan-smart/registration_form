import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String phone = '';
  String city = 'Алматы';
  String gender = 'Мужчина';
  String about = '';
  bool isAdult = false;

  List<String> cities = ['Алматы', 'Астана', 'Шымкент', 'Караганда', 'Атырау'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Данные регистрации"),
            content: Text(
              "ФИО: $name\n"
              "Email: $email\n"
              "Телефон: $phone\n"
              "Город: $city\n"
              "Пол: $gender\n"
              "Совершеннолетний: ${isAdult ? "Да" : "Нет"}\n"
              "О себе: $about",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Закрыть"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Форма регистрации")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ФИО", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(hintText: "Введите ФИО"),
                  validator: (value) => value!.isEmpty ? "Заполните поле" : null,
                  onSaved: (value) => name = value!,
                ),
                SizedBox(height: 10),
                
                Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(hintText: "Введите email"),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => value!.contains('@') ? null : "Введите корректный email",
                  onSaved: (value) => email = value!,
                ),
                SizedBox(height: 10),
                
                Text("Телефон", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(hintText: "Введите номер телефона"),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isNotEmpty ? null : "Заполните поле",
                  onSaved: (value) => phone = value!,
                ),
                SizedBox(height: 10),
                
                Text("Город", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                DropdownButtonFormField(
                  value: city,
                  items: cities.map((String city) {
                    return DropdownMenuItem(value: city, child: Text(city));
                  }).toList(),
                  onChanged: (value) => setState(() => city = value as String),
                  onSaved: (value) => city = value as String,
                ),
                SizedBox(height: 10),
                
                Text("Пол", style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text("Мужчина"),
                        value: "Мужчина",
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value as String),
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text("Женщина"),
                        value: "Женщина",
                        groupValue: gender,
                        onChanged: (value) => setState(() => gender = value as String),
                      ),
                    ),
                  ],
                ),
                
                CheckboxListTile(
                  title: Text("Мне 18 лет или больше"),
                  value: isAdult,
                  onChanged: (value) => setState(() => isAdult = value!),
                ),
                
                Text("О себе", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                TextFormField(
                  decoration: InputDecoration(hintText: "Напишите о себе"),
                  maxLines: 3,
                  onSaved: (value) => about = value!,
                ),
                SizedBox(height: 20),
                
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _submitForm,
                    child: Text("Отправить", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
