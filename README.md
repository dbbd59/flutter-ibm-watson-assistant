# watson_assistant

Unofficial implementation of IBM Watson Assistant API for Flutter.

## Usage
To use this plugin, add `watson_assistant` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

``` dart
import 'package:watson_assistant/watson_assistant.dart';
/* add async in your function */

WatsonAssistantCredential credential = WatsonAssistantCredential(username: [USERNAME], password: [PASSWORD], workspaceId: [WORKSPACEID]);

WatsonAssistantApiV1 watsonAssistant = WatsonAssistantApiV1(watsonAssistantCredential: credential);

WatsonAssistantResult watsonAssistantResponse;

/*First interaction*/
watsonAssistantResponse = await watsonAssistant.sendMessage("Hello", watsonAssistantContext);  // context of the conversation initially void

watsonAssistantContext = watsonAssistantResponse.context;        // to store the progress of the conversation
print(watsonAssistantResponse.resultText);                       // -->  "Hi i'm Watson Assistant!"

/*Second interaction*/
watsonAssistantResponse = await watsonAssistant.sendMessage("what's the weather tomorrow?", watsonAssistantContext);

watsonAssistantContext = watsonAssistantResponse.context;        // to store the progress of the conversation
print(watsonAssistantResponse.resultText);                       // -->  "It will be sunny tomorrow"



/*Reset the context*/
watsonAssistantContext.resetContext();

```