library watson_assistant;

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:meta/meta.dart';

class WatsonAssistantResult {
  String resultText;
  WatsonAssistantContext context;

  WatsonAssistantResult({this.resultText, this.context});
}

class WatsonAssistantContext {
  Map<String, dynamic> context;

  WatsonAssistantContext({
    this.context,
  });

  void resetContext() {
    this.context = {};
  }
}

class WatsonAssistantCredential {
  String username;
  String password;
  String workspaceId;
  String uri;
  String version;

  WatsonAssistantCredential(
      {@required this.username,
      @required this.password,
      @required this.workspaceId,
      this.version = "2018-09-20",
      this.uri = "https://gateway.watsonplatform.net/assistant/api/v1/"});
}

class WatsonAssistantApiV1 {
  WatsonAssistantCredential watsonAssistantCredential;
  String _resultWatsonAssistant;

  WatsonAssistantApiV1({
    @required this.watsonAssistantCredential,
  });
  Future<WatsonAssistantResult> sendMessage(
      String textInput, WatsonAssistantContext context) async {
    try {
      String uriWatsonAssistant =
          "${watsonAssistantCredential.uri}workspaces/${watsonAssistantCredential.workspaceId}/message?version=${watsonAssistantCredential.version}";

      String _basicAuth = 'Basic ' +
          base64Encode(utf8.encode(
              '${watsonAssistantCredential.username}:${watsonAssistantCredential.password}'));

      Map<String, dynamic> _body = {
        "input": {"text": textInput},
        "context": context.context
      };

      http.Response response = await http.post(
        uriWatsonAssistant,
        headers: {
          'authorization': _basicAuth,
          "Content-Type": "application/json"
        },
        body: json.encode(_body),
      );

      Map<String, dynamic> _result = json.decode(response.body);
      _resultWatsonAssistant = _result['output']['text'][0];

      WatsonAssistantContext _context =
          WatsonAssistantContext(context: _result['context']);

      WatsonAssistantResult watsonAssistantResult =
          WatsonAssistantResult(
              context: _context, resultText: _resultWatsonAssistant);
      return watsonAssistantResult;
    } catch (error) {
      print(error);
      return error;
    }
  }
}
