import 'package:flutter/material.dart';

void main() {
  runApp(const KayanStoreApp());
}

class KayanStoreApp extends StatelessWidget {
  const KayanStoreApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kayan Store',
      theme: ThemeData(
        primaryColor: const Color(0xFF673AB7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.amber,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      ),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      home: const LoginScreen(),
    );
  }
}

// ================= شاشة تسجيل الدخول المحدثة بالحساب الجديد =================
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _handleLogin() {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == 'admin' && password == '1234') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderManagerDashboard(userRole: 'admin')),
      );
    } else if (username == 'assistant' && password == '5678') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderManagerDashboard(userRole: 'assistant')),
      );
    } else if (username == 'assistant2' && password == '9012') { // تم إضافة الحساب الجديد هنا بنجاح
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OrderManagerDashboard(userRole: 'assistant2')),
      );
    } else {
      setState(() {
        _errorMessage = 'اسم المستخدم أو كلمة المرور غير صحيحة!';
      });
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF673AB7),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      '📦 كيان ستور',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'تسجيل الدخول لوحة التحكم',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'اسم المستخدم',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'كلمة المرور',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    if (_errorMessage.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Text(_errorMessage, style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _handleLogin,
                      child: const Text('دخول', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= نموذج البيانات =================
class OrderModel {
  final String orderId;
  final String customerName;
  final String customerPhone;
  final String productName;
  double price;
  final String address; 
  final String detailedAddress; 
  String status; 
  final DateTime date;

  OrderModel({
    required this.orderId,
    required this.customerName,
    required this.customerPhone,
    required this.productName,
    required this.price,
    required this.address,
    required this.detailedAddress,
    required this.status,
    required this.date,
  });
}

// ================= الشاشة الرئيسية للطلبات =================
class OrderManagerDashboard extends StatefulWidget {
  final String userRole;
  const OrderManagerDashboard({Key? key, required this.userRole}) : super(key: key);

  @override
  State<OrderManagerDashboard> createState() => _OrderManagerDashboardState();
}

class _OrderManagerDashboardState extends State<OrderManagerDashboard> {
  final List<OrderModel> _kayanOrders = [
    OrderModel(
      orderId: 'KYN-2026-01',
      customerName: 'محمود التريبان',
      customerPhone: '0791234567',
      productName: 'كرسي طعام للأطفال عالي الجودة',
      price: 45.0,
      address: 'عمان',
      detailedAddress: 'شارع مكة - خلف مكة mall - بناية 14',
      status: 'قيد الانتظار',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    OrderModel(
      orderId: 'KYN-2026-02',
      customerName: 'عميل متجر كيان',
      customerPhone: '0788888888',
      productName: 'حواجز حماية للأطفال وقفل أمان',
      price: 25.0,
      address: 'إربد',
      detailedAddress: 'شارع الجامعة - بجانب المكتبة الوطنية',
      status: 'تم الشحن',
      date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
    OrderModel(
      orderId: 'KYN-2026-03',
      customerName: 'سعيد العلي',
      customerPhone: '0790000000',
      productName: 'العاب خشبية تعليمية متكاملة',
      price: 18.0,
      address: 'الزرقاء',
      detailedAddress: 'حي معصوم - قرب مسجد عمر',
      status: 'ملغي', 
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  String _searchQuery = '';
  String _selectedStatusFilter = 'الكل';

  List<OrderModel> get _filteredOrders {
    return _kayanOrders.where((order) {
      final matchesSearch = order.customerName.contains(_searchQuery) || 
                            order.productName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                            order.orderId.contains(_searchQuery);
      final matchesStatus = _selectedStatusFilter == 'الكل' || order.status == _selectedStatusFilter;
      return matchesSearch && matchesStatus;
    }).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'قيد الانتظار': return Colors.orange;
      case 'تم الشحن': return Colors.blue;
      case 'مكتمل': return Colors.green;
      case 'ملغي': return Colors.red; 
      default: return Colors.grey;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.year}/${dateTime.month}/${dateTime.day} - ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _deleteOrder(String orderId) {
    setState(() {
      _kayanOrders.removeWhere((o) => o.orderId == orderId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف الطلب بنجاح'), backgroundColor: Colors.redAccent),
    );
  }

  void _updateOrderStatus(OrderModel order, String newStatus) {
    setState(() { order.status = newStatus; });
  }

  @override
  Widget build(BuildContext context) {
    double totalExpected = _kayanOrders.where((o) => o.status != 'ملغي').fold(0, (sum, item) => sum + item.price);
    double totalCompleted = _kayanOrders.where((o) => o.status == 'مكتمل').fold(0, (sum, item) => sum + item.price);

    // تحديد عنوان لوحة التحكم بناءً على الحساب المستخدم في الدخول
    String dashboardTitle = 'لوحة التحكم (مساعد 2) 👤';
    if (widget.userRole == 'admin') {
      dashboardTitle = 'لوحة التحكم (المدير) 👑';
    } else if (widget.userRole == 'assistant') {
      dashboardTitle = 'لوحة التحكم (مساعد 1) 👤';
    }

    return Scaffold(
      resizeToAvoidBottomInset: true, 
      appBar: AppBar(
        title: Text(
          dashboardTitle,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.01), blurRadius: 8, offset: const Offset(0, 2))],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  _buildSummaryItem('الطلبات', '${_kayanOrders.length}', Colors.black87),
                                  _buildSummaryItem('قيد الانتظار', '${_kayanOrders.where((o) => o.status == 'قيد الانتظار').length}', Colors.orange),
                                  _buildSummaryItem('مكتمل', '${_kayanOrders.where((o) => o.status == 'مكتمل').length}', Colors.green),
                                  _buildSummaryItem('ملغي', '${_kayanOrders.where((o) => o.status == 'ملغي').length}', Colors.red), 
                                ],
                              ),
                              if (widget.userRole == 'admin') ...[
                                const Divider(height: 10, thickness: 0.5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('المبيعات: ${totalCompleted.toStringAsFixed(1)} JOD', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                                    Text('النشط: ${totalExpected.toStringAsFixed(1)} JOD', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                                  ],
                                ),
                              ]
                            ],
                          ),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            onChanged: (value) { setState(() { _searchQuery = value; }); },
                            decoration: InputDecoration(
                              hintText: 'ابحث باسم العميل، المنتج أو رقم الطلب...',
                              hintStyle: const TextStyle(fontSize: 11),
                              prefixIcon: const Icon(Icons.search, color: Colors.deepPurple, size: 18),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 4),
                        _buildFilterChipsRow(),

                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text('قائمة الطلبات الناتجة', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  _filteredOrders.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(child: Text('لا توجد نتائج مطابقة لخيارات البحث')),
                        )
                      : SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final order = _filteredOrders[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            PopupMenuButton<String>(
                                              initialValue: order.status,
                                              onSelected: (String val) {
                                                if (val == 'delete') {
                                                  _deleteOrder(order.orderId);
                                                } else {
                                                  _updateOrderStatus(order, val);
                                                }
                                              },
                                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                                const PopupMenuItem<String>(value: 'قيد الانتظار', child: Text('قيد الانتظار')),
                                                const PopupMenuItem<String>(value: 'تم الشحن', child: Text('تم الشحن')),
                                                const PopupMenuItem<String>(value: 'مكتمل', child: Text('مكتمل')),
                                                const PopupMenuItem<String>(value: 'ملغي', child: Text('ملغي')),
                                                const PopupMenuDivider(),
                                                const PopupMenuItem<String>(
                                                  value: 'delete',
                                                  child: Row(
                                                    children: [
                                                      Icon(Icons.delete, color: Colors.red, size: 18),
                                                      SizedBox(width: 5),
                                                      Text('حذف الطلب', style: TextStyle(color: Colors.red)),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: _getStatusColor(order.status).withOpacity(0.12),
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(order.status, style: TextStyle(color: _getStatusColor(order.status), fontWeight: FontWeight.bold, fontSize: 10)),
                                                    const Icon(Icons.arrow_drop_down, size: 14, color: Colors.grey),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            if (widget.userRole == 'admin')
                                              Text('${order.price.toStringAsFixed(2)} JOD', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.deepPurple))
                                            else
                                              const Text('***', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey)),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text(order.productName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('العميل: ${order.customerName} (${order.address})', style: const TextStyle(fontSize: 11, color: Colors.teal, fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 1),
                                                  Text('العنوان: ${order.detailedAddress}', style: TextStyle(fontSize: 10, color: Colors.grey[700]), maxLines: 2, overflow: TextOverflow.ellipsis),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(order.orderId, style: const TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold)),
                                                Text(_formatDateTime(order.date), style: const TextStyle(fontSize: 9, color: Colors.black45)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: _filteredOrders.length,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOrderScreen(
                onOrderCreated: (newOrder) {
                  setState(() { _kayanOrders.insert(0, newOrder); });
                },
                nextIndex: _kayanOrders.length + 1,
              ),
            ),
          );
        },
        backgroundColor: Colors.deepPurple,
        icon: const Icon(Icons.add, color: Colors.white, size: 18),
        label: const Text('إضافة طلب', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 2),
        Text(value, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: valueColor)),
      ],
    );
  }

  Widget _buildFilterChipsRow() {
    final filters = ['الكل', 'قيد الانتظار', 'تم الشحن', 'مكتمل', 'ملغي']; 
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: filters.map((filter) {
          final isSelected = _selectedStatusFilter == filter;
          return Padding(
            padding: const EdgeInsets.only(left: 4),
            child: ChoiceChip(
              label: Text(filter),
              selected: isSelected,
              selectedColor: Colors.deepPurple,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 11),
              onSelected: (bool selected) {
                if (selected) { setState(() { _selectedStatusFilter = filter; }); }
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AddOrderScreen extends StatefulWidget {
  final Function(OrderModel) onOrderCreated;
  final int nextIndex;
  const AddOrderScreen({Key? key, required this.onOrderCreated, required this.nextIndex}) : super(key: key);

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState(); 
}

class _AddOrderScreenState extends State<AddOrderScreen> { 
  final _customerController = TextEditingController();
  final _phoneController = TextEditingController();
  final _productController = TextEditingController();
  final _priceController = TextEditingController();
  final _detailedAddressController = TextEditingController(); 
  String _selectedCity = 'عمان';
  final List<String> _jordanCities = ['عمان', 'إربد', 'الزرقاء', 'البلقاء', 'العقبة', 'المفرق', 'الكرك', 'مأدبا', 'جرش', 'عجلون', 'الطفيلة', 'معان'];

  @override
  void dispose() {
    _customerController.dispose();
    _phoneController.dispose();
    _productController.dispose();
    _priceController.dispose();
    _detailedAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل طلب جديد', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _customerController,
                decoration: const InputDecoration(labelText: 'اسم العميل', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: 'رقم الهاتف', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone, size: 18), contentPadding: EdgeInsets.symmetric(vertical: 10)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _productController,
                decoration: const InputDecoration(labelText: 'اسم المنتج', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'السعر (JOD)', border: OutlineInputBorder(), contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedCity,
                decoration: const InputDecoration(labelText: 'مدينة التوصيل', border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_city, size: 18), contentPadding: EdgeInsets.symmetric(vertical: 10)),
                items: _jordanCities.map((String city) {
                  return DropdownMenuItem<String>(value: city, child: Text(city));
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() { _selectedCity = newValue!; });
                },
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _detailedAddressController,
                decoration: const InputDecoration(
                  labelText: 'العنوان التفصيلي (الشارع، البناية...)', 
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home_work, size: 18),
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(vertical: 12)),
                onPressed: () {
                  if (_customerController.text.isNotEmpty && _phoneController.text.isNotEmpty && _productController.text.isNotEmpty && _priceController.text.isNotEmpty) {
                    final newOrder = OrderModel(
                      orderId: 'KYN-2026-${widget.nextIndex.toString().padLeft(2, '0')}',
                      customerName: _customerController.text,
                      customerPhone: _phoneController.text,
                      productName: _productController.text,
                      price: double.tryParse(_priceController.text) ?? 0.0,
                      address: _selectedCity,
                      detailedAddress: _detailedAddressController.text,
                      status: 'قيد الانتظار',
                      date: DateTime.now(),
                    );
                    widget.onOrderCreated(newOrder);
                    Navigator.pop(context);
                  }
                },
                child: const Text('حفظ الطلب الجديد', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
