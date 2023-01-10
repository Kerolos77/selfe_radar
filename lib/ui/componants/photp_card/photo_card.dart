import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selfe_radar/ui/componants/default_text/default_text.dart';

Widget photoCard({
  required BuildContext context,
  required label,
  required src,
  required load,
  required VoidCallback? onPress,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 3.5,
    color: Colors.white,
    child: load
        ? const Center(
            child: CircularProgressIndicator(
            color: Colors.black,
          ))
        : src == ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: onPress,
                      icon: const Icon(
                        FontAwesomeIcons.camera,
                        // color: Colors.white,
                        size: 40,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultText(text: label)
                ],
              )
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      src,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CircleAvatar(
                      child: IconButton(
                          onPressed: onPress,
                          icon: const Icon(
                            FontAwesomeIcons.edit,
                            // color: Colors.white,
                            size: 20,
                          )),
                    ),
                  ),
                ],
              ),
  );
}
