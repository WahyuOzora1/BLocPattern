import 'dart:async';
import 'package:flutter/material.dart';

enum ColorEvent { to_amber, to_light_blue } //enum untuk mengubah color

class ColorBLoc {
  //sesuatu yang menyimpan state warna
  Color _color = Colors.amber;

  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>(); //event color
  StreamSink<ColorEvent> get eventSink =>
      _eventController.sink; //type streamsink

  StreamController<Color> _stateController = StreamController<Color>();
  StreamSink<Color> get _stateSink => _stateController.sink; //state
  Stream<Color> get stateStream => _stateController.stream; //state terbaru

  void _mapEventToState(ColorEvent colorEvent) {
    //untuk menghubungkan event ke method ini menggunkan konstruktor bloc
    if (colorEvent == ColorEvent.to_amber)
      _color = Colors.amber;
    else
      _color = Colors.lightBlue;

    _stateSink.add(_color);
  }

  ColorBLoc() {
    _eventController.stream.listen(
        _mapEventToState); //pasangkan stream event controller(listen) _mapeventtostate
  }

  void dispose() {
    _eventController.close(); // tidak menghabskan memory
    _stateController.close(); //kalau sudah tidak dipakai di close
  }
}
