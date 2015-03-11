// Copyright (c) 2014, Nicolas François
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Example from https://github.com/jgautier/firmata/blob/master/examples/blink.js

import 'dart:html';
import 'package:firmata/firmata_chrome.dart';


main(){
  ButtonElement led1Button = querySelector("#led1");
  final led1Pin = 4;

  detect().then((board){
    print("Connected");
    
    bool led1On = false;
    board.pinMode(led1Pin, PinModes.OUTPUT);
    
    led1Button.onClick.listen((_){
      led1On = !led1On;
      led1Button.text = led1On ? "ON" : "OFF";
      board.digitalWrite(led1Pin, led1On ? PinValue.HIGH : PinValue.LOW);
    }).onError(print);

  });

}
