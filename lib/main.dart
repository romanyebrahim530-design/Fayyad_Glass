import 'package:flutter/material.dart';

void main() => runApp(const FayadGlassApp());

class FayadGlassApp extends StatelessWidget {
  const FayadGlassApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FAYAD Automotive Glass',
      theme: ThemeData(
        primaryColor: const Color(0xFF0B3878),
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        useMaterial3: true,
      ),
      home: const WelcomeSplashScreen(),
    );
  }
}

// ==================== 1. رسم أيقونة اللوجو (FAYAD Windshield) ====================
class FayadWindshieldPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  FayadWindshieldPainter({
    this.color = const Color(0xFF0B3878),
    this.strokeWidth = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    final windshieldPath = Path();
    windshieldPath.moveTo(w * 0.18, h * 0.16);
    windshieldPath.quadraticBezierTo(w * 0.50, h * 0.08, w * 0.82, h * 0.16);
    windshieldPath.lineTo(w * 0.92, h * 0.82);
    windshieldPath.quadraticBezierTo(w * 0.50, h * 0.98, w * 0.08, h * 0.82);
    windshieldPath.close();

    canvas.drawPath(windshieldPath, paint);

    final mirrorStem = Path()
      ..moveTo(w * 0.50, h * 0.12)
      ..lineTo(w * 0.50, h * 0.28);
    canvas.drawPath(mirrorStem, paint);

    final mirrorRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.50, h * 0.38),
        width: w * 0.24,
        height: h * 0.16,
      ),
      const Radius.circular(4),
    );
    canvas.drawRRect(mirrorRect, paint);

    canvas.drawLine(
      Offset(w * 0.44, h * 0.58),
      Offset(w * 0.84, h * 0.35),
      paint,
    );
    canvas.drawLine(
      Offset(w * 0.44, h * 0.74),
      Offset(w * 0.84, h * 0.51),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FayadLogoWidget extends StatelessWidget {
  final bool isLight;
  final bool isHorizontal;
  final double scale;

  const FayadLogoWidget({
    super.key,
    this.isLight = false,
    this.isHorizontal = false,
    this.scale = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isLight ? Colors.white : const Color(0xFF0B3878);
    final subTextColor = isLight ? Colors.blue.shade100 : const Color(0xFF0B3878);

    final textSection = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'FAYAD',
          style: TextStyle(
            fontSize: 34 * scale,
            fontWeight: FontWeight.w900,
            color: primaryColor,
            letterSpacing: 2.5,
            height: 1.0,
          ),
        ),
        SizedBox(height: 4 * scale),
        Text(
          'Automotive Glass',
          style: TextStyle(
            fontSize: 14 * scale,
            fontWeight: FontWeight.w600,
            color: subTextColor,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );

    final divider = Container(
      width: isHorizontal ? 1.5 : 160 * scale,
      height: isHorizontal ? 50 * scale : 1.5,
      color: primaryColor.withOpacity(0.6),
      margin: EdgeInsets.symmetric(
        vertical: isHorizontal ? 0 : 12 * scale,
        horizontal: isHorizontal ? 14 * scale : 0,
      ),
    );

    final icon = SizedBox(
      width: 75 * scale,
      height: 75 * scale,
      child: CustomPaint(
        painter: FayadWindshieldPainter(
          color: primaryColor,
          strokeWidth: 4.0 * scale,
        ),
      ),
    );

    if (isHorizontal) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [icon, divider, textSection],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [textSection, divider, icon],
    );
  }
}

// ==================== 2. واجهة الترحيب (Splash Screen) ====================
class WelcomeSplashScreen extends StatelessWidget {
  const WelcomeSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF061A35), Color(0xFF0B3878), Color(0xFF1565C0)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 30),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.35),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const FayadLogoWidget(isHorizontal: false, scale: 1.1),
              ),
              const SizedBox(height: 30),
              const Text(
                'نظام إدارة الإنتاج والعمليات والمخازن',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF0B3878),
                    minimumSize: const Size.fromHeight(56),
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainDashboard()),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'دخول للنظام الداخلي',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_forward_rounded, size: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== 3. لوحة التحكم الرئيسية (5 تبويبات) ====================
class MainDashboard extends StatefulWidget {
  const MainDashboard({super.key});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  final List<Map<String, dynamic>> _rawWarehouse = [
    {'type': 'زجاج أبيض 4 مم (2 متر)', 'qty': 0},
    {'type': 'زجاج أبيض 4 مم (2.25 متر)', 'qty': 0},
    {'type': 'زجاج أبيض 5 مم (2 متر)', 'qty': 0},
    {'type': 'زجاج أبيض 5 مم (2.25 متر)', 'qty': 0},
    {'type': 'زجاج أخضر 4 مم (2 متر)', 'qty': 0},
    {'type': 'زجاج أخضر 4 مم (2.25 متر)', 'qty': 0},
    {'type': 'زجاج أخضر 5 مم (2 متر)', 'qty': 0},
    {'type': 'زجاج أخضر 5 مم (2.25 متر)', 'qty': 0},
    {'type': 'زجاج أخضر 6 مم (2 متر)', 'qty': 0},
    {'type': 'زجاج أخضر 6 مم (2.25 متر)', 'qty': 0},
    {'type': 'زجاج أسود 4 مم (2 متر)', 'qty': 0},
    {'type': 'زجاج أسود 4 مم (2.25 متر)', 'qty': 0},
  ];

  final List<Map<String, dynamic>> _securitRawWarehouse = [];
  final List<Map<String, dynamic>> _autoGlassFinalWarehouse = [];

  final List<Map<String, dynamic>> _cuttingLogs = [];
  final List<Map<String, dynamic>> _bevelingLogs = [];
  final List<Map<String, dynamic>> _printingLogs = [];
  final List<Map<String, dynamic>> _temperingLogs = [];

  double _calculateStageWaste(List<Map<String, dynamic>> logs) {
    int totalScrap = logs.fold(0, (sum, item) => sum + (item['scrapPcs'] as int? ?? 0));
    int totalGood = logs.fold(0, (sum, item) => sum + (item['goodPcs'] as int? ?? 0));
    int totalPcs = totalScrap + totalGood;
    if (totalPcs == 0) return 0.0;
    return (totalScrap / totalPcs) * 100;
  }

  double _calculateShiftWaste(String? shiftName) {
    final filtered = shiftName == null
        ? _temperingLogs
        : _temperingLogs.where((e) => e['shift'] == shiftName).toList();

    int totalScrap = filtered.fold(0, (sum, item) => sum + (item['scrapPcs'] as int? ?? 0));
    int totalGood = filtered.fold(0, (sum, item) => sum + (item['goodPcs'] as int? ?? 0));
    int totalPcs = totalScrap + totalGood;
    if (totalPcs == 0) return 0.0;
    return (totalScrap / totalPcs) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF0B3878),
            toolbarHeight: 75,
            title: const FayadLogoWidget(
              isLight: true,
              isHorizontal: true,
              scale: 0.55,
            ),
            bottom: const TabBar(
              isScrollable: true,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
              indicatorColor: Colors.amber,
              indicatorWeight: 3,
              tabs: [
                Tab(icon: Icon(Icons.content_cut), text: '1. التقطيع والهالك'),
                Tab(icon: Icon(Icons.precision_manufacturing), text: '2. الشطف والطباعة'),
                Tab(icon: Icon(Icons.local_fire_department), text: '3. فرن السيكوريت'),
                Tab(icon: Icon(Icons.inventory_2), text: '4. مخزن الخام الإجمالي'),
                Tab(icon: Icon(Icons.store), text: '5. مخزن السيكوريت والتام'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _buildCuttingTab(),
              _buildProcessingTab(),
              _buildTemperingTab(),
              _buildRawWarehouseTab(),
              _buildSecuritWarehouseTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCuttingTab() {
    double totalCuttingWaste = 0.0;
    int totalCutScrap = 0;
    int totalCutPcs = 0;

    for (var log in _cuttingLogs) {
      for (var itm in log['items']) {
        totalCutScrap += (itm['scrapPcs'] as int? ?? 0);
        totalCutPcs += (itm['scrapPcs'] as int? ?? 0) + (itm['goodPcs'] as int? ?? 0);
      }
    }
    if (totalCutPcs > 0) {
      totalCuttingWaste = (totalCutScrap / totalCutPcs) * 100;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildWasteSummaryHeader('إجمالي نسبة هالك التقطيع العام', totalCuttingWaste, Colors.red.shade700),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B3878),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () => _showAddMultiItemCuttingDialog(),
            icon: const Icon(Icons.add_task),
            label: const Text('تسجيل تشغيلة تقطيع (عدة أصناف مع خصم تلقائي)', style: TextStyle(fontSize: 15)),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: _cuttingLogs.isEmpty
                ? const Center(child: Text('لا توجد عمليات تقطيع مسجلة'))
                : ListView.builder(
                    itemCount: _cuttingLogs.length,
                    itemBuilder: (context, index) {
                      final batch = _cuttingLogs[index];
                      List itemsList = batch['items'];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ExpansionTile(
                          leading: const Icon(Icons.content_cut, color: Color(0xFF0B3878)),
                          title: Text('الخام المسحوب: ${batch['sheetType']} (${batch['sheetsCut']} لوح)', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('عدد الأصناف الناتجة: ${itemsList.length} أصناف'),
                          trailing: _buildWasteBadge(batch['totalBatchWaste']),
                          children: [
                            const Divider(height: 1),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: itemsList.length,
                              itemBuilder: (context, subIndex) {
                                final itm = itemsList[subIndex];
                                return ListTile(
                                  dense: true,
                                  title: Text('• صنف: ${itm['itemName']}', style: const TextStyle(fontWeight: FontWeight.w600)),
                                  subtitle: Text('سليم: ${itm['goodPcs']} قطعة | هالك: ${itm['scrapPcs']} قطعة'),
                                  trailing: Text('هالك: ${itm['itemWastePercent']}%', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }

  Widget _buildProcessingTab() {
    double bevelingWaste = _calculateStageWaste(_bevelingLogs);
    double printingWaste = _calculateStageWaste(_printingLogs);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWasteSummaryHeader('إجمالي نسبة هالك الشطف', bevelingWaste, Colors.blue.shade900),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('سجل شغل الشطف', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Color(0xFF0B3878), size: 28),
                onPressed: () => _showStageDialog('شطف', _bevelingLogs),
              )
            ],
          ),
          ..._bevelingLogs.map((e) => _buildStageCard(e, const Color(0xFF0B3878))),
          const Divider(height: 30, thickness: 2),
          _buildWasteSummaryHeader('إجمالي نسبة هالك طباعة البلاك والسلك', printingWaste, Colors.purple),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('سجل شغل الطباعة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.purple, size: 28),
                onPressed: () => _showStageDialog('طباعة (بلاك / سلك)', _printingLogs),
              )
            ],
          ),
          ..._printingLogs.map((e) => _buildStageCard(e, Colors.purple)),
        ],
      ),
    );
  }

  Widget _buildTemperingTab() {
    double totalWaste = _calculateShiftWaste(null);
    double shift1Waste = _calculateShiftWaste('الوردية الأولى (الصباحية)');
    double shift2Waste = _calculateShiftWaste('الوردية الثانية (المسائية)');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildWasteSummaryHeader('إجمالي كسر فرن السيكوريت', totalWaste, Colors.deepOrange),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildSmallWasteHeader('الوردية 1 (الصباحية)', shift1Waste, Colors.blue.shade800)),
              const SizedBox(width: 8),
              Expanded(child: _buildSmallWasteHeader('الوردية 2 (المسائية)', shift2Waste, Colors.indigo.shade900)),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
            onPressed: () => _showTemperingDialog(),
            icon: const Icon(Icons.local_fire_department),
            label: const Text('تسجيل تشغيلة فرن (حسب الوردية)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: _temperingLogs.isEmpty
                ? const Center(child: Text('لا توجد تشغيلات فرن مسجلة'))
                : ListView.builder(
                    itemCount: _temperingLogs.length,
                    itemBuilder: (context, index) {
                      final item = _temperingLogs[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.local_fire_department, color: Colors.deepOrange),
                          title: Text('الصنف: ${item['itemName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('الوردية: ${item['shift']}\nسليم: ${item['goodPcs']} | كسر: ${item['scrapPcs']}'),
                          trailing: _buildWasteBadge(item['wastePercent']),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildRawWarehouseTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('🏭 مخزن الخام الإجمالي بالمصنع', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0B3878))),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B3878), foregroundColor: Colors.white),
                onPressed: () => _showAddRegularRawDialog(),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('إضافة نوع خام جديد'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('اضغط على أيقونة التعديل بجوار الصنف لتعديل أو تسجيل رصيدك الحالي.', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 12),
          Expanded(
            child: _rawWarehouse.isEmpty
                ? const Center(child: Text('مخزن الخام فارغ'))
                : ListView.builder(
                    itemCount: _rawWarehouse.length,
                    itemBuilder: (context, index) {
                      final sheet = _rawWarehouse[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ListTile(
                          leading: const Icon(Icons.layers, color: Color(0xFF0B3878)),
                          title: Text(sheet['type'], style: const TextStyle(fontWeight: FontWeight.bold)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${sheet['qty']} لوح',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0B3878), fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue, size: 20),
                                onPressed: () => _showEditRawQtyDialog(index),
                                tooltip: 'تعديل الكمية',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritWarehouseTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('🔥 مخزن سيكوريت الخام', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
              IconButton(
                icon: const Icon(Icons.add_circle, color: Colors.deepOrange),
                onPressed: () => _showAddSecuritRawDialog(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          _securitRawWarehouse.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('لا توجد أصناف خام سيكوريت مضافة حالياً. اضغط على علامة (+) لإضافة صنف.', style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _securitRawWarehouse.length,
                  itemBuilder: (context, index) {
                    final item = _securitRawWarehouse[index];
                    return Card(
                      color: Colors.orange.shade50,
                      child: ListTile(
                        title: Text(item['type'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Text('الرصيد: ${item['qty']} قطعة', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange)),
                      ),
                    );
                  },
                ),
          const Divider(height: 35, thickness: 2),
          const Text('🚗 مخزن المنتج التام (زجاج سيارات جاهز للبيع)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
          const SizedBox(height: 8),
          _autoGlassFinalWarehouse.isEmpty
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Text('لا يوجد منتج تام بالمخزن حالياً.', style: TextStyle(color: Colors.grey)),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _autoGlassFinalWarehouse.length,
                  itemBuilder: (context, index) {
                    final item = _autoGlassFinalWarehouse[index];
                    return Card(
                      color: Colors.green.shade50,
                      child: ListTile(
                        leading: const Icon(Icons.verified, color: Colors.green),
                        title: Text(item['itemName'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        trailing: Text('السليم المتاح: ${item['qty']} قطعة', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 15)),
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildWasteSummaryHeader(String title, double wastePercent, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: color)),
          Text('${wastePercent.toStringAsFixed(1)}%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildSmallWasteHeader(String title, double wastePercent, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('${wastePercent.toStringAsFixed(1)}%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteBadge(String wastePercent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('هالك اللوح', style: TextStyle(fontSize: 10, color: Colors.red)),
          Text('$wastePercent%', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildStageCard(Map<String, dynamic> item, Color color) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.build_circle, color: color),
        title: Text('الصنف: ${item['itemName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('سليم: ${item['goodPcs']} | هالك: ${item['scrapPcs']}'),
        trailing: _buildWasteBadge(item['wastePercent']),
      ),
    );
  }

  void _showAddRegularRawDialog() {
    final typeController = TextEditingController();
    final qtyController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة صنف خام جديد للمخزن'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: typeController, decoration: const InputDecoration(labelText: 'اسم الخام والمقاس واللون')),
            TextField(controller: qtyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'الكمية (عدد الألواح)')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B3878), foregroundColor: Colors.white),
            onPressed: () {
              String typeName = typeController.text.trim();
              int addedQty = int.tryParse(qtyController.text) ?? 0;
              if (typeName.isNotEmpty) {
                setState(() {
                  _rawWarehouse.add({'type': typeName, 'qty': addedQty});
                });
                Navigator.pop(context);
              }
            },
            child: const Text('إضافة الخام'),
          ),
        ],
      ),
    );
  }

  void _showEditRawQtyDialog(int index) {
    final item = _rawWarehouse[index];
    final qtyController = TextEditingController(text: item['qty'].toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تعديل رصيد: ${item['type']}'),
        content: TextField(
          controller: qtyController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'العدد الجديد للألواح'),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B3878), foregroundColor: Colors.white),
            onPressed: () {
              int newQty = int.tryParse(qtyController.text) ?? 0;
              setState(() {
                _rawWarehouse[index]['qty'] = newQty;
              });
              Navigator.pop(context);
            },
            child: const Text('حفظ التعديل'),
          ),
        ],
      ),
    );
  }

  void _showAddSecuritRawDialog() {
    final typeController = TextEditingController();
    final qtyController = TextEditingController(text: '0');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة خام لمخزن السيكوريت'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: typeController, decoration: const InputDecoration(labelText: 'اسم الصنف أو المقاس')),
            TextField(controller: qtyController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'الكمية المتاحة')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
            onPressed: () {
              int qty = int.tryParse(qtyController.text) ?? 0;
              if (typeController.text.isNotEmpty) {
                setState(() {
                  _securitRawWarehouse.add({'type': typeController.text, 'qty': qty});
                });
                Navigator.pop(context);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _showAddMultiItemCuttingDialog() {
    String selectedSheet = _rawWarehouse.isNotEmpty ? _rawWarehouse[0]['type'] : '';
    final sheetsCutController = TextEditingController(text: '1');
    final itemNameController = TextEditingController();
    final goodPcsController = TextEditingController();
    final scrapPcsController = TextEditingController();
    List<Map<String, dynamic>> currentBatchItems = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('تسجيل تشغيلة تقطيع (عدة أصناف)'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedSheet.isNotEmpty ? selectedSheet : null,
                    decoration: const InputDecoration(labelText: 'اختر نوع اللوح الخام المسحوب'),
                    items: _rawWarehouse.map((s) => DropdownMenuItem(value: s['type'].toString(), child: Text('${s['type']} (متاح: ${s['qty']})'))).toList(),
                    onChanged: (val) => setDialogState(() => selectedSheet = val!),
                  ),
                  TextField(
                    controller: sheetsCutController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'عدد الألواح المسحوبة للخصم من المخزن'),
                  ),
                  const Divider(height: 25),
                  const Text('إضافة صنف ناتج من الألواح:', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0B3878))),
                  const SizedBox(height: 8),
                  TextField(controller: itemNameController, decoration: const InputDecoration(labelText: 'اسم الصنف الناتج')),
                  Row(
                    children: [
                      Expanded(child: TextField(controller: goodPcsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'قطع سليمة'))),
                      const SizedBox(width: 8),
                      Expanded(child: TextField(controller: scrapPcsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'هالك'))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(40)),
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      String name = itemNameController.text.trim();
                      int good = int.tryParse(goodPcsController.text) ?? 0;
                      int scrap = int.tryParse(scrapPcsController.text) ?? 0;
                      int total = good + scrap;

                      if (name.isNotEmpty && total > 0) {
                        double itemWaste = (scrap / total) * 100;
                        setDialogState(() {
                          currentBatchItems.add({
                            'itemName': name,
                            'goodPcs': good,
                            'scrapPcs': scrap,
                            'itemWastePercent': itemWaste.toStringAsFixed(1),
                          });
                          itemNameController.clear();
                          goodPcsController.clear();
                          scrapPcsController.clear();
                        });
                      }
                    },
                    label: const Text('إضافة الصنف للقائمة الحالية'),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 140,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade50,
                    ),
                    child: currentBatchItems.isEmpty
                        ? const Center(child: Text('لم يتم إضافة أصناف بعد', style: TextStyle(color: Colors.grey, fontSize: 13)))
                        : ListView.builder(
                            itemCount: currentBatchItems.length,
                            itemBuilder: (context, index) {
                              final item = currentBatchItems[index];
                              return ListTile(
                                dense: true,
                                title: Text('${index + 1}. ${item['itemName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Text('سليم: ${item['goodPcs']} | هالك: ${item['scrapPcs']}'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                  onPressed: () => setDialogState(() => currentBatchItems.removeAt(index)),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0B3878), foregroundColor: Colors.white),
              onPressed: () {
                int sheets = int.tryParse(sheetsCutController.text) ?? 0;
                if (sheets > 0 && currentBatchItems.isNotEmpty && selectedSheet.isNotEmpty) {
                  final sheetItem = _rawWarehouse.firstWhere((s) => s['type'] == selectedSheet);
                  if (sheetItem['qty'] < sheets) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الكمية المسحوبة أكبر من المتاح في مخزن الخام!')),
                    );
                    return;
                  }

                  int batchTotalScrap = 0;
                  int batchTotalPcs = 0;
                  for (var itm in currentBatchItems) {
                    batchTotalScrap += (itm['scrapPcs'] as int);
                    batchTotalPcs += (itm['scrapPcs'] as int) + (itm['goodPcs'] as int);
                  }
                  double batchWastePercent = batchTotalPcs > 0 ? (batchTotalScrap / batchTotalPcs) * 100 : 0.0;

                  setState(() {
                    _cuttingLogs.add({
                      'sheetType': selectedSheet,
                      'sheetsCut': sheets,
                      'items': List.from(currentBatchItems),
                      'totalBatchWaste': batchWastePercent.toStringAsFixed(1),
                    });
                    sheetItem['qty'] = (sheetItem['qty'] as int) - sheets;
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('حفظ التشغيلة وخصم الخام'),
            )
          ],
        ),
      ),
    );
  }

  void _showTemperingDialog() {
    String selectedShift = 'الوردية الأولى (الصباحية)';
    final nameController = TextEditingController();
    final goodPcsController = TextEditingController();
    final scrapPcsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('تسجيل تشغيلة فرن السيكوريت'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedShift,
                  decoration: const InputDecoration(labelText: 'اختر الوردية'),
                  items: const [
                    DropdownMenuItem(value: 'الوردية الأولى (الصباحية)', child: Text('الوردية الأولى (الصباحية)')),
                    DropdownMenuItem(value: 'الوردية الثانية (المسائية)', child: Text('الوردية الثانية (المسائية)')),
                  ],
                  onChanged: (val) => setDialogState(() => selectedShift = val!),
                ),
                TextField(controller: nameController, decoration: const InputDecoration(labelText: 'اسم الصنف')),
                TextField(controller: goodPcsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'القطع السليمة')),
                TextField(controller: scrapPcsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'القطع المكسورة بالفرن')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white),
              onPressed: () {
                int goodPcs = int.tryParse(goodPcsController.text) ?? 0;
                int scrapPcs = int.tryParse(scrapPcsController.text) ?? 0;
                int totalPcs = goodPcs + scrapPcs;

                if (nameController.text.isNotEmpty && totalPcs > 0) {
                  double wastePercent = (scrapPcs / totalPcs) * 100;
                  setState(() {
                    _temperingLogs.add({
                      'shift': selectedShift,
                      'itemName': nameController.text,
                      'goodPcs': goodPcs,
                      'scrapPcs': scrapPcs,
                      'wastePercent': wastePercent.toStringAsFixed(1),
                    });

                    int existingIndex = _autoGlassFinalWarehouse.indexWhere((item) => item['itemName'] == nameController.text);
                    if (existingIndex != -1) {
                      _autoGlassFinalWarehouse[existingIndex]['qty'] += goodPcs;
                    } else {
                      _autoGlassFinalWarehouse.add({'itemName': nameController.text, 'qty': goodPcs});
                    }
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('حفظ وإضافة للمنتج التام'),
            ),
          ],
        ),
      ),
    );
  }

  void _showStageDialog(String stageName, List<Map<String, dynamic>> targetList) {
    final nameController = TextEditingController();
    final goodPcsController = TextEditingController();
    final scrapPcsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('تسجيل شغلة ومتابعة هالك $stageName'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'اسم الصنف')),
            TextField(controller: goodPcsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'عدد القطع السليمة')),
            TextField(controller: scrapPcsController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'عدد القطع الهالكة')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () {
              int goodPcs = int.tryParse(goodPcsController.text) ?? 0;
              int scrapPcs = int.tryParse(scrapPcsController.text) ?? 0;
              int totalPcs = goodPcs + scrapPcs;

              if (nameController.text.isNotEmpty && totalPcs > 0) {
                double wastePercent = (scrapPcs / totalPcs) * 100;
                setState(() {
                  targetList.add({
                    'itemName': nameController.text,
                    'goodPcs': goodPcs,
                    'scrapPcs': scrapPcs,
                    'wastePercent': wastePercent.toStringAsFixed(1),
                  });
                });
                Navigator.pop(context);
              }
            },
            child: const Text('حفظ واحتساب الهالك'),
          ),
        ],
      ),
    );
  }
}
