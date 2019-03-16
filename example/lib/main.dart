import 'package:flutter/material.dart';
import 'package:watson_assistant/watson_assistant.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Watson Assistant Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text;
  WatsonAssistantCredential credential = WatsonAssistantCredential(
      username: "YOUR USERNAME",
      password: "YOUR PASSWORD",
      workspaceId: "YOUR WORKSPACE ID");

  WatsonAssistantApiV1 watsonAssistant;
  WatsonAssistantResult watsonAssistantResponse;
  WatsonAssistantContext watsonAssistantContext =
      WatsonAssistantContext(context: {});

  final myController = TextEditingController();

  void _callWatsonAssistant() async {
    watsonAssistantResponse = await watsonAssistant.sendMessage(
        myController.text, watsonAssistantContext);
    setState(() {
      _text = watsonAssistantResponse.resultText;
    });
    watsonAssistantContext = watsonAssistantResponse.context;
    myController.clear();
  }

  @override
  void initState() {
    super.initState();
    watsonAssistant =
        WatsonAssistantApiV1(watsonAssistantCredential: credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.restore,
            ),
            onPressed: () {
              watsonAssistantContext.resetContext();
              setState(() {
                _text = null;
              });
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: myController,
            ),
            Text(
              _text != null ? '$_text' : 'Watson Response Here',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _callWatsonAssistant,
        child: Icon(Icons.send),
      ),
    );
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }
}
