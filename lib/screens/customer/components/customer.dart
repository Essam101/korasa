import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
 import 'package:shop/models/customerModel.dart';
import 'package:shop/screens/customer/components/add_customer_form.dart';
import 'package:shop/screens/customer/state_management/customre_state.dart';

class Customer extends StatelessWidget {
  final CustomerModel customerModel;

  Customer({Key? key, required this.customerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF5F6F9),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            title: Text(customerModel.name),
            subtitle: Text(customerModel.notes),
            leading: Icon(Icons.label),
            trailing: Text("100 \$"),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    showBarModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AddCustomerForm(
                          userId: customerModel.customerId,
                          name: customerModel.name,
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.edit, size: 18),
                  label: Text("تعديل  "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await Provider.of<CustomerState>(context, listen: false)
                        .deleteCustomer(customerId: customerModel.customerId);
                    // Respond to button press
                  },
                  icon: Icon(Icons.delete, size: 18),
                  label: Text("حذف  "),
                ),
              ),
              SizedBox(width: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  icon: Icon(Icons.add, size: 18),
                  label: Text("اضافة طلب"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
