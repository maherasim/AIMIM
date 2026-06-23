import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
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
  FlashMode _flashMode = FlashMode.off;
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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
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

  Future<void> _cycleFlash() async {
    if (_controller == null || !_isCameraReady) return;
    final next = _flashMode == FlashMode.off
        ? FlashMode.torch
        : FlashMode.off;
    try {
      await _controller!.setFlashMode(next);
      setState(() => _flashMode = next);
    } catch (_) {}
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

  String get _timerLabel {
    final m = _recordSeconds ~/ 60;
    final s = _recordSeconds % 60;
    return '${m.toString().padLeft(1, '0')}:${s.toString().padLeft(2, '0')}';
  }

  IconData get _flashIcon => _flashMode == FlashMode.torch
      ? Icons.flash_on
      : Icons.flash_off;

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

          // ── 1. Camera preview ────────────────────────────────────
          GestureDetector(
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            child: _buildCameraView(),
          ),

          // ── 2. Top controls ──────────────────────────────────────
          Positioned(
            top: 0, left: 0, right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Close
                    _CircleBtn(
                      icon: Icons.close,
                      onTap: () => Navigator.pop(context),
                    ),
                    // Right tools
                    Row(children: [
                      _CircleBtn(icon: _flashIcon, onTap: _cycleFlash),
                      const SizedBox(width: 10),
                      _CircleBtn(
                        icon: Icons.music_note_outlined,
                        onTap: () => _showMusicSheet(context),
                      ),
                      const SizedBox(width: 10),
                      _CircleBtn(
                        icon: Icons.auto_awesome_mosaic_outlined,
                        onTap: () => _showEffectsSheet(context),
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),

          // ── 3. REC badge ─────────────────────────────────────────
          if (_isRecording)
            Positioned(
              top: MediaQuery.of(context).padding.top + 70,
              left: 0, right: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (ctx, _) => Opacity(
                    opacity: 0.7 + _pulseController.value * 0.3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.fiber_manual_record,
                            color: Colors.white, size: 10),
                        const SizedBox(width: 6),
                        Text('REC  $_timerLabel',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                      ]),
                    ),
                  ),
                ),
              ),
            ),

          // ── 4. Zoom indicator ────────────────────────────────────
          if (_currentZoom > 1.05)
            Positioned(
              top: MediaQuery.of(context).padding.top + 70,
              left: 0, right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${_currentZoom.toStringAsFixed(1)}×',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13)),
                ),
              ),
            ),

          // ── 5. Side tools (Reels mode) ────────────────────────────
          if (_modeIndex == 2)
            Positioned(
              right: 14, bottom: 185,
              child: Column(children: [
                _SideBtn(icon: Icons.speed, label: 'Speed', onTap: () {}),
                const SizedBox(height: 18),
                _SideBtn(icon: Icons.filter_outlined, label: 'Filter',
                    onTap: () => _showEffectsSheet(context)),
                const SizedBox(height: 18),
                _SideBtn(icon: Icons.timer_outlined, label: 'Timer',
                    onTap: () {}),
                const SizedBox(height: 18),
                _SideBtn(icon: Icons.flip_camera_android_outlined,
                    label: 'Flip', onTap: _flipCamera),
              ]),
            ),

          // ── 6. Bottom controls ────────────────────────────────────
          Positioned(
            bottom: 0, left: 0, right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black, Colors.transparent],
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(mainAxisSize: MainAxisSize.min, children: [

                  // Recording progress bar
                  if (_isRecording)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: (_recordSeconds % 60) / 60,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.red),
                          minHeight: 3,
                        ),
                      ),
                    ),

                  // Gallery | Record | Flip
                  Padding(
                    padding: const EdgeInsets.fromLTRB(28, 10, 28, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Gallery thumbnail
                        GestureDetector(
                          onTap: _pickFromGallery,
                          child: Container(
                            width: 54, height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white, width: 1.5),
                              color: const Color(0xFF2A2A2A),
                            ),
                            child: const Icon(Icons.photo_library_outlined,
                                color: Colors.white70, size: 26),
                          ),
                        ),

                        // Record button
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

                        // Flip camera
                        GestureDetector(
                          onTap: _flipCamera,
                          child: Container(
                            width: 54, height: 54,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black45,
                              border: Border.all(
                                  color: Colors.white54, width: 1.5),
                            ),
                            child: const Icon(
                                Icons.flip_camera_android_outlined,
                                color: Colors.white, size: 26),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mode tabs
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(_modes.length, (i) {
                        final sel = i == _modeIndex;
                        return GestureDetector(
                          onTap: () => setState(() => _modeIndex = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 7),
                            decoration: BoxDecoration(
                              color: sel ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Text(_modes[i],
                                style: TextStyle(
                                    color: sel ? Colors.black : Colors.white,
                                    fontWeight: sel
                                        ? FontWeight.bold
                                        : FontWeight.w400,
                                    fontSize: 14,
                                    shadows: sel
                                        ? null
                                        : const [
                                            Shadow(
                                                color: Colors.black,
                                                blurRadius: 6)
                                          ])),
                          ),
                        );
                      }),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraView() {
    if (_cameraError) {
      return Container(
        color: const Color(0xFF111111),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.no_photography_outlined,
                color: Colors.white38, size: 60),
            const SizedBox(height: 12),
            const Text('Camera not available',
                style: TextStyle(color: Colors.white54, fontSize: 14)),
            const SizedBox(height: 6),
            const Text(
                'Grant camera permission in Settings',
                style: TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      );
    }

    if (!_isCameraReady || _controller == null) {
      return Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(
              color: Colors.white, strokeWidth: 2),
        ),
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
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => const _MusicSheet(),
    );
  }

  void _showEffectsSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: const Color(0xFF1C1C1C),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
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
      width: 82, height: 82,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          width: recording ? 30 : 64,
          height: recording ? 30 : 64,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: recording ? BoxShape.rectangle : BoxShape.circle,
            borderRadius: recording ? BorderRadius.circular(8) : null,
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
        width: 44, height: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
          border: Border.all(color: Colors.white30),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

class _SideBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SideBtn(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black54,
            border: Border.all(color: Colors.white24),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 3),
        Text(label,
            style: const TextStyle(
                color: Colors.white70, fontSize: 10,
                shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
      ]),
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
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 40, height: 4,
            decoration: BoxDecoration(color: Colors.white24,
                borderRadius: BorderRadius.circular(2))),
        const SizedBox(height: 16),
        const Text('Add Music',
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Container(
          height: 40,
          decoration: BoxDecoration(color: Colors.white12,
              borderRadius: BorderRadius.circular(20)),
          child: const TextField(
            style: TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Search music...',
              hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
              prefixIcon: Icon(Icons.search, color: Colors.white38, size: 18),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ..._tracks.map((t) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 40, height: 40,
                decoration: BoxDecoration(
                    color: kPrimaryGreen.withAlpha(60),
                    borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.music_note,
                    color: Colors.white70, size: 18),
              ),
              title: Text(t.$1,
                  style: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w600, fontSize: 13)),
              subtitle: Text(t.$2,
                  style: const TextStyle(
                      color: Colors.white54, fontSize: 11)),
              trailing: Text(t.$3,
                  style: const TextStyle(
                      color: Colors.white38, fontSize: 11)),
              onTap: () => Navigator.pop(context),
            )),
      ]),
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.white24,
                  borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 16),
          const Text('Effects & Filters',
              style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
            physics: const NeverScrollableScrollPhysics(),
            children: _effects.map((e) => GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24)),
                    child: Icon(e.$1, color: Colors.white70, size: 26),
                  ),
                  const SizedBox(height: 4),
                  Text(e.$2, style: const TextStyle(
                      color: Colors.white70, fontSize: 11)),
                ],
              ),
            )).toList(),
          ),
        ]),
      ),
    );
  }
}
