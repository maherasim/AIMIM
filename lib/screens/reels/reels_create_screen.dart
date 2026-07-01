import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants.dart';

class ReelsCreateScreen extends StatefulWidget {
  const ReelsCreateScreen({super.key});

  @override
  State<ReelsCreateScreen> createState() => _ReelsCreateScreenState();
}

class _ReelsCreateScreenState extends State<ReelsCreateScreen>
    with TickerProviderStateMixin {
  // Camera
  List<CameraDescription> _cameras = [];
  CameraController? _controller;
  bool _isCameraReady = false;
  bool _cameraError = false;
  int _cameraIndex = 0; // 0 = back, 1 = front

  // Recording
  bool _isRecording = false;
  int _recordSeconds = 0;

  // Controls
  int _modeIndex = 2; // 0=Live 1=Status 2=Reels 3=Post 4=Broadcast
  double _minZoom = 1.0;
  double _maxZoom = 1.0;
  double _currentZoom = 1.0;
  double _baseZoom = 1.0;

  // Animation
  late AnimationController _pulseController;

  static const _modes = ['Live', 'Status', 'Reels', 'Post', 'Broadcast'];

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() => _cameraError = true);
        return;
      }
      await _setupController(_cameras[_cameraIndex]);
    } catch (e) {
      setState(() => _cameraError = true);
    }
  }

  Future<void> _setupController(CameraDescription camera) async {
    final prev = _controller;
    _controller = null;
    await prev?.dispose();

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: true,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    try {
      await controller.initialize();
      _minZoom = await controller.getMinZoomLevel();
      _maxZoom = await controller.getMaxZoomLevel();
      _currentZoom = 1.0;
      _baseZoom = 1.0;
      if (mounted) {
        setState(() {
          _controller = controller;
          _isCameraReady = true;
          _cameraError = false;
        });
      }
    } on CameraException catch (e) {
      debugPrint('Camera error: ${e.description}');
      if (mounted) setState(() => _cameraError = true);
    }
  }

  Future<void> _flipCamera() async {
    if (_cameras.length < 2) return;
    setState(() => _isCameraReady = false);
    _cameraIndex = (_cameraIndex + 1) % _cameras.length;
    await _setupController(_cameras[_cameraIndex]);
  }

  Future<void> _toggleRecording() async {
    if (_controller == null || !_isCameraReady) return;
    if (_isRecording) {
      await _controller!.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _recordSeconds = 0;
      });
    } else {
      try {
        await _controller!.startVideoRecording();
        setState(() => _isRecording = true);
        _runTimer();
      } on CameraException catch (e) {
        debugPrint('Record error: ${e.description}');
      }
    }
  }

  void _runTimer() async {
    while (_isRecording && mounted) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted && _isRecording) setState(() => _recordSeconds++);
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    await picker.pickVideo(source: ImageSource.gallery);
  }

  void _onScaleStart(ScaleStartDetails d) {
    _baseZoom = _currentZoom;
  }

  Future<void> _onScaleUpdate(ScaleUpdateDetails d) async {
    if (_controller == null || !_isCameraReady) return;
    final zoom = (_baseZoom * d.scale).clamp(_minZoom, _maxZoom);
    await _controller!.setZoomLevel(zoom);
    setState(() => _currentZoom = zoom);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1. Camera preview / Sky Mockup ──────────────────────
          GestureDetector(
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            child: _buildCameraView(),
          ),

          // ── 2. Top Progress Line ───────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 6.h,
            left: 16.w,
            right: 16.w,
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _isRecording ? (_recordSeconds % 60) / 60 : 0.05,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
          ),

          // ── 3. Top controls ──────────────────────────────────────
          Positioned(
            top: MediaQuery.of(context).padding.top + 16.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close button X
                _CircleBtn(
                  icon: Icons.close,
                  onTap: () => Navigator.pop(context),
                ),
                // Right tools (Music & AI)
                Row(
                  children: [
                    _CircleBtn(
                      icon: Icons.music_note_outlined,
                      onTap: () => _showMusicSheet(context),
                    ),
                    SizedBox(width: 12.w),
                    _CircleBtn(
                      icon: Icons.auto_awesome_outlined,
                      onTap: () => _showEffectsSheet(context),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── 4. Zoom indicator ────────────────────────────────────
          if (_currentZoom > 1.05)
            Positioned(
              top: MediaQuery.of(context).padding.top + 80.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '${_currentZoom.toStringAsFixed(1)}×',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),

          // ── 5. Bottom controls overlay ───────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Gallery | Record Button | Camera Icon
                    Padding(
                      padding: EdgeInsets.fromLTRB(28.w, 10.h, 28.w, 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Gallery thumbnail showing female face with glasses
                          GestureDetector(
                            onTap: _pickFromGallery,
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: Colors.white, width: 1.5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6.r),
                                child: Image.network(
                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: const Color(0xFF2A2A2A),
                                    child: const Icon(
                                      Icons.photo_library_outlined,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          // Giant Record/Capture Button
                          GestureDetector(
                            onTap: _isCameraReady ? _toggleRecording : null,
                            child: AnimatedBuilder(
                              animation: _pulseController,
                              builder: (ctx, _) => Transform.scale(
                                scale: _isRecording
                                    ? 1.0 + _pulseController.value * 0.05
                                    : 1.0,
                                child: _RecordBtn(recording: _isRecording),
                              ),
                            ),
                          ),

                          // Camera outline icon
                          GestureDetector(
                            onTap: _flipCamera,
                            child: Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withValues(alpha: 0.4),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 26.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Mode tabs (Live, Status, Reels, Post, Broadcast)
                    Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(_modes.length, (i) {
                          final sel = i == _modeIndex;
                          return GestureDetector(
                            onTap: () => setState(() => _modeIndex = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: sel
                                    ? Border.all(color: Colors.white, width: 1.5)
                                    : null,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                _modes[i],
                                style: GoogleFonts.roboto(
                                  color: sel ? Colors.white : Colors.white.withValues(alpha: 0.65),
                                  fontWeight: sel ? FontWeight.bold : FontWeight.w400,
                                  fontSize: 13.sp,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    if (_cameraError || !_isCameraReady || _controller == null) {
      // Mock skyscraper background matching the user attachment
      return Image.network(
        'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?w=1080',
        fit: BoxFit.cover,
      );
    }

    // Real camera preview
    return ClipRect(
      child: OverflowBox(
        maxWidth: double.infinity,
        maxHeight: double.infinity,
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _controller!.value.previewSize!.height,
            height: _controller!.value.previewSize!.width,
            child: CameraPreview(_controller!),
          ),
        ),
      ),
    );
  }

  void _showMusicSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1C1C1C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _MusicSheet(),
    );
  }

  void _showEffectsSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1C1C1C),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _EffectsSheet(),
    );
  }
}

// ── Record button ─────────────────────────────────────────────────────────────

class _RecordBtn extends StatelessWidget {
  final bool recording;
  const _RecordBtn({required this.recording});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 76.w,
      height: 76.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4.w),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: recording ? 26.w : 58.w,
          height: recording ? 26.w : 58.w,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: recording ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: recording ? BorderRadius.circular(8.r) : null,
          ),
        ),
      ),
    );
  }
}

// ── Reusable widgets ──────────────────────────────────────────────────────────

class _CircleBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CircleBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black.withValues(alpha: 0.4),
        ),
        child: Icon(icon, color: Colors.white, size: 20.w),
      ),
    );
  }
}

// ── Bottom sheets ─────────────────────────────────────────────────────────────

class _MusicSheet extends StatelessWidget {
  const _MusicSheet();

  static const _tracks = [
    ('National Anthem', 'India', '0:52'),
    ('Party Anthem', 'AIMIM Official', '3:24'),
    ('Ek Nazar', 'Various Artists', '4:10'),
    ('Hum Honge Kamyab', 'Folk', '3:55'),
    ('Tarana-e-Hind', 'Classical', '5:01'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Add Music',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white, fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Search music...',
                  hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white38,
                    size: 18,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            ..._tracks.map(
              (t) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: kPrimaryGreen.withAlpha(60),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.music_note,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
                title: Text(
                  t.$1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
                subtitle: Text(
                  t.$2,
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
                trailing: Text(
                  t.$3,
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EffectsSheet extends StatelessWidget {
  const _EffectsSheet();

  static const _effects = [
    (Icons.auto_fix_high_outlined, 'Beauty'),
    (Icons.wb_sunny_outlined, 'Warm'),
    (Icons.filter_b_and_w_outlined, 'B&W'),
    (Icons.blur_on, 'Blur BG'),
    (Icons.face_retouching_natural_outlined, 'Smooth'),
    (Icons.wb_twilight_outlined, 'Vivid'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Effects & Filters',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.1,
              physics: const NeverScrollableScrollPhysics(),
              children: _effects
                  .map(
                    (e) => GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.white24),
                            ),
                            child: Icon(e.$1, color: Colors.white70, size: 26),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            e.$2,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
