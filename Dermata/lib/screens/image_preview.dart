import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:get/get.dart';
import 'package:dermata/screens/result_screen.dart';
import 'package:dermata/widgets/button.dart';
import 'package:dermata/widgets/nav_draw.dart';
import 'package:dermata/services/http.dart';

class ImagePreview extends StatefulWidget {
  final String imagePath;

  const ImagePreview({Key? key, required this.imagePath}) : super(key: key);

  @override
  _ImagePreviewState createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: Text("Preview your image"),
        centerTitle: true,
        backgroundColor: Color(0xff008dff),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(flex: 2),
                Image.file(
                  File(widget.imagePath),
                  height: MediaQuery.of(context).size.height * 0.6,
                  fit: BoxFit.cover,
                ),
                Spacer(flex: 1),
                Button(
                  title: "Send",
                  shade: Color(0xff9dd6e5),
                  factor: 0.5,
                  onTap: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      var result = await _loadAndSendRotatedImage();
                      print(result);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Uploading image failed. Error: ${e.toString()}')),
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                isLoading
                    ? Expanded(
                        flex: 2,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _loadAndSendRotatedImage() async {
    // Load the image file
    final File imageFile = File(widget.imagePath);
    img.Image? image = img.decodeImage(imageFile.readAsBytesSync());

    // Rotate the image
    final img.Image? rotatedImage = img.copyRotate(image!, 0);

    // Save the rotated image to a temporary file
    final rotatedFilePath = (await imageFile.create()).path;
    final File rotatedFile = File(rotatedFilePath);
    rotatedFile.writeAsBytesSync(img.encodeJpg(rotatedImage!));

    // Send the rotated image to the API
    final result = await sendToPredictor(rotatedFilePath);

    // Delete the temporary rotated image file
    rotatedFile.delete();

    final String disease = result['result'];
    final List symptoms = result['symptoms'];

    setState(() {
      isLoading = false;
    });
    Get.to(() => ResultPage(
          disease: disease,
          symptoms: symptoms,
        ));

    return result['result'];
  }
}
