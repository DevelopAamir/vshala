import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
class PaymentInvoicesCard extends StatelessWidget {
  final title;
  final date;
  final dueDate;
  final invoicesNo;
  final payable;
  final paid;
  final due;

  const PaymentInvoicesCard({Key? key,
    required this.date,
    required this.dueDate,
    required this.invoicesNo,
    required this.payable,
    required this.paid,
    required this.due,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Student Fees',
                    style: GoogleFonts.alice(
                        fontSize: 18,
                    fontWeight: FontWeight.bold),
                  ),
                ),
                MaterialButton(
                  onPressed: () {},
                  color: context.watch<UiProvider>().theme == 'light'
                      ? Color.fromRGBO(135, 112, 255, 0.9)
                      : Color(0xff2A2B30),
                  child: Text('Pay Now',
                      style:
                      GoogleFonts.alice(

                          color: Colors
                              .white)),
                )
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Date : $date',
                    style:
                    GoogleFonts.alice(),
                  ),
                ),
                Expanded(
                    child: Text(
                        'Due Date : $dueDate',
                        style: GoogleFonts
                            .alice()))
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Expanded(
                    child: Text(
                        'Invoice No : $invoicesNo',
                        style: GoogleFonts
                            .alice())),
                Expanded(
                    child: Text(
                        'Payable : ₹$payable ',
                        style: GoogleFonts
                            .alice()))
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,
              children: [
                Expanded(
                    child: Text('Paid : $paid',
                        style: GoogleFonts
                            .alice())),
                Expanded(
                    child: Text('Due  : $due',
                        style: GoogleFonts
                            .alice()))
              ],
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(10)),
    );
  }
}
