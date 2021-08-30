import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/utils/menu_options.dart';
import 'package:e_management/src/screens/sidebar_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
        actions: [
          PopupMenuButton<MenuItem>(
            onSelected: (item) => MenuOptions().onSelected(context, item),
            itemBuilder: (context) => [
              ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
              PopupMenuDivider(),
              ...MenuItems.itemsSecond.map(MenuOptions().buildItem).toList(),
            ],
          )
        ],
      ),
      drawer: SideBarScreen(),
      body: ContactPage(),
    );
  }
}

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _form = GlobalKey<FormState>();

  String? subject;
  String? emailAdress;
  String? message;
  String? sendDate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: _form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textField(),
            subjectField(),
            emailField(),
            messageField(),
            sendForm(),
            SizedBox(
              height: 30.0,
            ),
            contactUs()
          ],
        ),
      ),
    );
  }

  Widget textField() {
    return Container(
      margin: const EdgeInsets.all(24.0),
      child: Text(
        "Contactez-Nous ici",
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }

  Widget subjectField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: "Ecrivez votre préocupation ici",
          labelText: 'Sujet',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (subject) => subject != null && subject.isEmpty
            ? 'Ce champ ne peut pas être vide'
            : null,
        onChanged: (value) => setState(() => subject = value.trim()),
      ),
    );
  }

  Widget emailField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Ex: contact@eventdrc.com",
          labelText: 'Email',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (emailAdress) => emailAdress != null && emailAdress.isEmpty
            ? 'Ce champ ne peut pas être vide'
            : null,
        onChanged: (value) => setState(() => emailAdress = value.trim()),
      ),
    );
  }

  Widget messageField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Ecrivez votre message ici",
          labelText: 'Message',
          labelStyle: TextStyle(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        validator: (message) => message != null && message.isEmpty
            ? 'Ce champ ne peut pas être vide'
            : null,
        onChanged: (value) => setState(() => message = value.trim()),
      ),
    );
  }

  Widget sendForm() {
    return ElevatedButton(
      onPressed: () {
        // final formAchat = _form.currentState!.validate();

        print("categorie $subject");
        print("sousCategorie $emailAdress");
        print("type $message");
        print("Date $sendDate");

        // print(formAchat);
        // addAchat();

        send();
      },
      child: Padding(
        padding: const EdgeInsets.only(
            left: 30.0, right: 30.0, top: 20.0, bottom: 20.0),
        child: Text(
          'Enregistrez',
          textScaleFactor: 1.5,
        ),
      ),
      style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 10)),
    );
  }

  Widget contactUs() {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 20,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '+243 81 353 08 38',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 20,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text('+243 81 975 32 32',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 20,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '+243 90 339 49 41',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Row(
              children: [
                Icon(
                  Icons.email,
                  size: 20,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text('contact@eventdrc.com',
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> send() async {
    final Email email = Email(
      body: message!,
      subject: subject!,
      recipients: [emailAdress!],
      // attachmentPaths: attachments,
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }
}
