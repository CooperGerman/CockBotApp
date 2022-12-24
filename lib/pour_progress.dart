// import 'dart:html';
// import 'dart:io';

import 'package:cockbotapp/cock.dart';
import 'package:cockbotapp/physical.dart';
// import 'package:cockbotapp/post_cock.dart';
import 'package:flutter/material.dart';
import 'package:async/async.dart';

class PourProgress extends StatefulWidget {
  const PourProgress({Key? key}) : super(key: key);

  @override
  State<PourProgress> createState() => _PourProgressState();
}

class _PourProgressState extends State<PourProgress>
    with TickerProviderStateMixin {
  double status = 0;
  String tag = '';
  String name = '';
  bool isUpdating = false;
  bool cancelled = false;
  CancelableOperation? _myCancelableFuture;
  @override
  _PourProgressState() {
    {
      if (this.mounted) {
        fetchPouringStatus().then((val) => setState(() {
              if (val['tag'] != null) {
                tag = val['tag'];
                status = val['status'];
                name = val['name'];
              }
            }));
      }
    }
  }

  _update() {
    if (this.mounted) {
      isUpdating = true;
      _myCancelableFuture = CancelableOperation.fromFuture(
        Future.delayed(Duration(seconds: 1))
            .then((val) => fetchPouringStatus().then((val) => setState(() {
                  if (val['name'] != null) {
                    tag = val['tag'];
                    status = val['status'];
                    name = val['name'];
                  }
                }))),
      );
      _myCancelableFuture?.value.whenComplete(() => isUpdating = false);
    }
  }

  _cancel() {
    cancelled = true;
    _myCancelableFuture?.cancel(); // Cancel the Future
    cancelPouring().then((val) => () {
          if (!isUpdating) {
            if (val['status'] != 0) {
              print("Error cancelling pouring");
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final cocktail = ModalRoute.of(context)!.settings.arguments as Cocktail;
    Widget displayed;
    // Cancel button in the bottom right corner that calls cancelPouring() and pops the page
    Widget cancelButton = FloatingActionButton.extended(
      onPressed: () {
        this._cancel();
      },
      label: const Text('Cancel'),
      icon: const Icon(Icons.cancel),
      backgroundColor: Colors.red,
    );

    Widget returnButton = FloatingActionButton.extended(
      onPressed: () => Navigator.of(context).pop(),
      label: const Text('Return'),
      icon: const Icon(Icons.keyboard_return),
      backgroundColor: Colors.orangeAccent,
    );
    if (status == 1 && !cancelled) {
      displayed = returnButton;
    } else if (cancelled && !isUpdating) {
      cancelled = false;
      this.deactivate();
      this.dispose();
      Navigator.of(context).pop();
    } else {
      this._update();
    }
    if (cocktail.name == name && cocktail.tag == tag) {
      displayed = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Pouring ${cocktail.name}, please be patient...',
            style: TextStyle(fontSize: 20),
          ),
          cancelButton,
          LinearProgressIndicator(
            value: status,
            semanticsLabel: 'Linear progress indicator',
          ),
        ],
      );
    } else {
      displayed = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'Error matching current cocktail ${cocktail.name}, with tag ${cocktail.tag}...',
            style: TextStyle(fontSize: 20),
          ),
          returnButton
        ],
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: Padding(padding: const EdgeInsets.all(20.0), child: displayed),
    );
  }
}
