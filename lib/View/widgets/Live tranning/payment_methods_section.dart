import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodsWidget extends StatefulWidget {
  const PaymentMethodsWidget({super.key});

  @override
  State<PaymentMethodsWidget> createState() => _PaymentMethodsWidgetState();
}

class _PaymentMethodsWidgetState extends State<PaymentMethodsWidget> {
  String? _selectedMethod = 'paypal';

  final List<Map<String, dynamic>> _paymentMethods = [
    {'name': 'Paypal', 'type': 'paypal'},
    {'name': 'Google Pay', 'type': 'google_pay'},
    {'name': 'Apple Pay', 'type': 'apple_pay'},
    {'name': '**** **** **76 3054', 'type': 'credit_card'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          ..._paymentMethods
              .map((method) => _buildPaymentItem(method, context))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(Map<String, dynamic> method, BuildContext context) {
    final isSelected = _selectedMethod == method['type'];

    return Container(
      height: 60.h,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100, width: 1),
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.tertiary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(2, 10),
              blurRadius: 10.r,
            ),
          ]),
      child: InkWell(
        onTap: () => setState(() => _selectedMethod = method['type']),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Radio Indicator
            Text(
              method['name'],
              style: GoogleFonts.mulish(
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
            ),
            SizedBox(width: 16.w),

            // Payment Method Text

            Radio<String>(
              value: method['type'],
              groupValue: _selectedMethod,
              onChanged: (value) => setState(() => _selectedMethod = value),
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.teal;
                }
                return Theme.of(context).textTheme.bodyLarge!.color!;
              }),
            ),

            // Card Icon for last item
          ],
        ),
      ),
    );
  }
}
