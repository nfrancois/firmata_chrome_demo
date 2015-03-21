// Copyright (c) 2014-2015, Nicolas François
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

import 'dart:html';
import 'package:firmata/firmata_chrome.dart';
import 'dart:async';


final p1Pin = 2;
final p2Pin = 3;

final led1Pin = 4;
final led2Pin = 5;
final led3Pin = 6;
final led4Pin = 7;

// Buttons
final buttonsIds = {p1Pin : "p1", p2Pin : "p2"};
final Map<int, InputElement>  buttonsInputs = {};

// Leds
final offCss = 'btn-default';

final pinsIds = {led1Pin : "led1" , led2Pin: "led2", led3Pin : "led3", led4Pin: "led4"};
final pinStates = {led1Pin : false, led2Pin: false, led3Pin:false, led4Pin:false};
final pinClasses = {led1Pin : 'btn-danger', led2Pin: 'btn-success', led3Pin:'btn-success', led4Pin:'btn-danger'};
final Map<int, ButtonElement> ledsButtons = {};

main(){
 
  detect().then((board){
    // Hide modal loading
    querySelector("#modal-loading").classes.add("loading-close");
    // Init leds
    pinsIds.forEach((pin, id){
      // Arduino init
      board.pinMode(pin, PinModes.OUTPUT);
      // UI init
      var led = querySelector("#$id")..onClick.listen((_) => toggleLedButton(board, pin));
      ledsButtons[pin] = led;
    });
    // Init buttons
    buttonsIds.forEach((pin, id){
      // Arduino init
      board.pinMode(pin, PinModes.INPUT);
      // UI init
      var button = querySelector("#$id");
      buttonsInputs[pin] = button;
    });
    board.onDigitalRead.listen(toggleButtonInput);
  }).catchError((e) {
    querySelector("#msg-connexion-fail").innerHtml = e.toString();
  });
}

toggleLedButton(Board b, pin){
  // Change states
  pinStates[pin] = !pinStates[pin];
  b.digitalWrite(pin, pinStates[pin] ? PinValue.HIGH : PinValue.LOW); 
  // UI changes
  ledsButtons[pin].classes..toggle(offCss)..toggle(pinClasses[pin]); 
}

toggleButtonInput(PinState pinState){
  // UI changes
  buttonsInputs[pinState.pin].value = pinState.value == 0 ? "ON" : "OFF";
}
