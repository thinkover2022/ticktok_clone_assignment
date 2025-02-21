import 'package:camera/camera.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';

class AttachScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const AttachScreen({super.key, required this.cameras});

  @override
  State<AttachScreen> createState() => _AttachScreenState();
}

class _AttachScreenState extends State<AttachScreen> {
  List<String> fileList = [];
  void _returnFilePath() {
    Navigator.pop(context, fileList);
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              leading: GestureDetector(
                  onTap: () {
                    _returnFilePath();
                  },
                  child: FaIcon(FontAwesomeIcons.caretLeft)),
            )
          : AppBar(
              title: const Text("Select Photos"),
              actions: [
                TextButton(
                  onPressed: () {
                    _returnFilePath();
                  },
                  child: const Text("Add",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 24,
                      )),
                ),
              ],
            ),
      body: _selectedIndex == 0
          ? CameraScreen(cameras: widget.cameras)
          : LibraryScreen(fileList: fileList),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'Camera'),
          BottomNavigationBarItem(
              icon: Icon(Icons.photo_library), label: 'Library'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const CameraScreen({super.key, required this.cameras});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  bool _isCameraReady = false;
  bool _isFlashOn = false;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    if (widget.cameras.isNotEmpty) {
      _controller = CameraController(
          widget.cameras[_selectedCameraIndex], ResolutionPreset.high);
      await _controller.initialize();
      setState(() => _isCameraReady = true);
    } else {
      debugPrint("No cameras available.");
    }
  }

  Future<void> _captureAndSavePhoto() async {
    if (_controller.value.isInitialized) {
      try {
        final XFile photo = await _controller.takePicture();
        debugPrint("Photo captured: ${photo.path}");
        await GallerySaver.saveImage(photo.path, albumName: "MyFlutterApp");
        debugPrint("Photo saved to gallery");
      } catch (e) {
        debugPrint("Error taking picture: $e");
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _isCameraReady
              ? ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(30.0)),
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: CameraPreview(_controller),
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        ),
        Positioned(
          bottom: 20.0,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                  ),
                  onPressed: () async {
                    if (_controller.value.isInitialized) {
                      _isFlashOn = !_isFlashOn;
                      await _controller.setFlashMode(
                          _isFlashOn ? FlashMode.torch : FlashMode.off);
                      setState(() {});
                    }
                  },
                ),
                IconButton(
                  onPressed: _captureAndSavePhoto,
                  icon: const Icon(
                    Icons.camera,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.flip_camera_ios,
                  ),
                  onPressed: () async {
                    if (widget.cameras.length > 1) {
                      _selectedCameraIndex =
                          (_selectedCameraIndex + 1) % widget.cameras.length;
                      await _initializeCamera();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LibraryScreen extends StatefulWidget {
  final List<String> fileList;
  const LibraryScreen({super.key, required this.fileList});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final faker.Faker fakerInstance = faker.Faker();
  late List<String> fakeImages;
  final List<bool> _selImages = List.generate(10, (index) {
    return false;
  });
  @override
  void initState() {
    super.initState();
    fakeImages = List.generate(
        10,
        (index) =>
            "https://picsum.photos/300/200?random=${fakerInstance.randomGenerator.integer(100)}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Photos, People, Places...",
              prefixIcon: Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: fakeImages.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _selImages[index] = !_selImages[index];
                  if (_selImages[index]) {
                    widget.fileList.add(fakeImages[index]);
                  } else {
                    if (widget.fileList.contains(fakeImages[index])) {
                      widget.fileList.remove(fakeImages[index]);
                    }
                  }
                  setState(() {});
                },
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.network(fakeImages[index], fit: BoxFit.cover),
                    if (_selImages[index])
                      Icon(
                        color: Colors.blue,
                        Icons.check_circle,
                        size: 30,
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
