import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:tatweer_maximo/models/project.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final Project project;

  const ProjectDetailsScreen({super.key, required this.project});

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  int _currentIndex = 0; // Tracks active carousel item
  // List<VideoPlayerController> _videoControllers = [];
  // PageController _videoPageController = PageController();

  @override
  void initState() {
    super.initState();

    // Initialize video controllers if videos exist
    // if (widget.project.videos.isNotEmpty) {
    //   for (var videoUrl in widget.project.videos) {
    //     _videoControllers.add(VideoPlayerController.network(videoUrl)
    //       ..initialize().then((_) {
    //         setState(() {}); // Refresh UI when video is ready
    //       }));
    //   }
    // }
  }

  @override
  void dispose() {
    // for (var controller in _videoControllers) {
    //   controller.dispose();
    // }
    // _videoPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set entire background to black
      appBar: AppBar(
        backgroundColor: Colors.black, // Ensures AppBar stays black
        scrolledUnderElevation: 0, // Prevents AppBar color change on scroll
        iconTheme:
            const IconThemeData(color: Colors.white), // White back button
        title: Text(
          widget.project.title,
          style: const TextStyle(color: Colors.white), // White text
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Carousel (if images exist)
              if (widget.project.images.isNotEmpty)
                Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      items: widget.project.images.map((imagePath) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Stack(
                            children: [
                              Image.asset(
                                imagePath,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error, color: Colors.red),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                    ),
                                  ),
                                  // child: Column(
                                  //   crossAxisAlignment:
                                  //       CrossAxisAlignment.start,
                                  //   children: [
                                  //     Text(
                                  //       widget.project.title,
                                  //       style: const TextStyle(
                                  //         color: Colors.white,
                                  //         fontWeight: FontWeight.bold,
                                  //         fontSize: 16,
                                  //       ),
                                  //       maxLines: 1,
                                  //       overflow: TextOverflow.ellipsis,
                                  //     ),
                                  //     const SizedBox(height: 4),
                                  //     if (widget.project.subtitle.isNotEmpty)
                                  //       Text(
                                  //         widget.project.subtitle,
                                  //         style: const TextStyle(
                                  //           color: Colors.white70,
                                  //           fontSize: 14,
                                  //         ),
                                  //         maxLines: 2,
                                  //         overflow: TextOverflow.ellipsis,
                                  //       ),
                                  //   ],
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        widget.project.images.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentIndex == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == index
                                ? Theme.of(context).colorScheme.tertiary
                                : Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 10),

              // Subtitle
              if (widget.project.subtitle.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    widget.project.subtitle,
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                ),

              const SizedBox(height: 20),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.project.description,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              // // Video Player (if videos exist)
              // if (_videoControllers.isNotEmpty)
              //   Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 16),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           "Project Videos",
              //           style: TextStyle(
              //             fontSize: 18,
              //             fontWeight: FontWeight.bold,
              //             color: Colors.white,
              //           ),
              //         ),
              //         const SizedBox(height: 10),
              //         SizedBox(
              //           height: 300, // Prevents overflow
              //           child: PageView.builder(
              //             controller: _videoPageController,
              //             itemCount: _videoControllers.length,
              //             itemBuilder: (context, index) {
              //               final controller = _videoControllers[index];
              //               return Column(
              //                 children: [
              //                   AspectRatio(
              //                     aspectRatio: controller.value.isInitialized
              //                         ? controller.value.aspectRatio
              //                         : 16 / 9,
              //                     child: VideoPlayer(controller),
              //                   ),
              //                   IconButton(
              //                     icon: Icon(
              //                       controller.value.isPlaying
              //                           ? Icons.pause
              //                           : Icons.play_arrow,
              //                       color: Colors.white,
              //                     ),
              //                     onPressed: () {
              //                       setState(() {
              //                         controller.value.isPlaying
              //                             ? controller.pause()
              //                             : controller.play();
              //                       });
              //                     },
              //                   ),
              //                 ],
              //               );
              //             },
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
