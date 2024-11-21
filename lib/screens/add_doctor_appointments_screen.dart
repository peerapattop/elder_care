import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // สำหรับการจัดการวันที่

class AddDoctorAppointmentsScreen extends StatefulWidget {
  const AddDoctorAppointmentsScreen({super.key});

  @override
  State<AddDoctorAppointmentsScreen> createState() =>
      _AddDoctorAppointmentsScreenState();
}

class _AddDoctorAppointmentsScreenState
    extends State<AddDoctorAppointmentsScreen> {
  // ตัวแปรสำหรับเก็บค่าต่างๆ
  final TextEditingController _doctorNameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  // ตัวแปรสำหรับเก็บวันที่และเวลา
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // ฟังก์ชันเพื่อเลือกวันที่
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // ฟังก์ชันเพื่อเลือกเวลา
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('เพิ่มหมอนัด'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // ชื่อหมอ
              const Text(
                'ชื่อหมอ:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _doctorNameController,
                decoration: const InputDecoration(
                  hintText: 'กรอกชื่อหมอ',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกชื่อหมอ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // วันที่นัดหมาย
              const Text(
                'วันที่นัดหมาย:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: DateFormat('dd/MM/yyyy').format(_selectedDate),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // เวลา
              const Text(
                'เวลา:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _selectedTime.format(context),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // สถานที่
              const Text(
                'สถานที่นัดหมาย:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  hintText: 'กรอกสถานที่นัดหมาย',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณากรอกสถานที่';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // รายละเอียด
              const Text(
                'รายละเอียดการนัดหมาย:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: _detailsController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'กรอกรายละเอียดเพิ่มเติม',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),

              // ปุ่มบันทึก
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_doctorNameController.text.isEmpty ||
                        _locationController.text.isEmpty) {
                      // คุณสามารถแสดงข้อความเตือนที่นี่
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('กรุณากรอกข้อมูลให้ครบ')),
                      );
                      return;
                    }
                    // บันทึกข้อมูล
                    print('บันทึกข้อมูลการนัดหมาย');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text(
                    'บันทึก',
                    style: TextStyle(color: Colors.white),
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