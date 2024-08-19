import 'dart:typed_data';
import 'dart:ui';

import 'package:code/accounts/model/subscription_history_model.dart';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:code/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../home/provider/home_provider.dart';

class PrintSubscriptionSheet extends StatefulWidget {
  PrintSubscriptionSheet({super.key, required this.subscription});

  SubscriptionData? subscription;

  @override
  State<PrintSubscriptionSheet> createState() => _PrintSubscriptionSheetState();
}

class _PrintSubscriptionSheetState extends State<PrintSubscriptionSheet> {

  final GlobalKey _key = GlobalKey();
  double? originalAmount, gst;


  @override
  Widget build(BuildContext context) {
    return DoctorProfileBase(
        builder: (HomeGetProvider homeProvider){
          originalAmount = double.parse((widget.subscription!.amount! * 100/118).toStringAsFixed(2));
          gst = double.parse((widget.subscription!.amount! - originalAmount!).toStringAsFixed(2));
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(08.0),
              child: Column(
                children: [
                  RepaintBoundary(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure proper alignment
                          children: [
                            Image.asset('assets/icons/doc_aid.png', height: 30.0),
                            Image.asset('assets/icons/reshita.jpg', height: 30.0),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'From',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textColor,
                                    fontSize: 10.0,
                                  ),
                                ),
                                Text(
                                  'M/s Reshita',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textColor,
                                    fontSize: 11.0,
                                  ),
                                ),
                                Text(
                                  'Flat no. 33 Mangaldeep Apartment',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                    fontSize: 8.0,
                                  ),
                                ),
                                Text(
                                  'Patliputra Colony, Patna, 800013',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Bill to',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    color: AppColors.textColor,
                                    fontSize: 10.0,
                                  ),
                                ),
                                Text(
                                  "${homeProvider.doctorProfile!.data!.firstName!} ${homeProvider.doctorProfile!.data!.lastName!}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textColor,
                                    fontSize: 10.0,
                                  ),
                                ),
                                Text(
                                  homeProvider.doctorProfile!.data!.email!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                    fontSize: 8.0,
                                  ),
                                ),
                                Text(
                                  homeProvider.doctorProfile!.data!.contact!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                    fontSize: 8.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        RichText(
                          text: TextSpan(
                            text: 'Payment Id - ',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9.0, color: AppColors.textColor),
                            children: <TextSpan>[
                              TextSpan(text: widget.subscription!.paymentId!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0, color: AppColors.textColor)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3.0,),
                        RichText(
                          text: TextSpan(
                            text: 'Order Id - ',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9.0, color: AppColors.textColor),
                            children: <TextSpan>[
                              TextSpan(text: widget.subscription!.orderId!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0, color: AppColors.textColor)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 3.0,),
                        RichText(
                          text: TextSpan(
                            text: 'Payment Date - ',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 9.0, color: AppColors.textColor),
                            children: <TextSpan>[
                              TextSpan(text: widget.subscription!.paymentDate!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 8.0, color: AppColors.textColor)),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8.0,),
                        const Text('Your Account Summary', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.vermilion, fontSize: 12.0),),
                        const SizedBox(height: 2.0,),
                        const Text('Subscription Charges', style: TextStyle(fontWeight: FontWeight.w500, color: AppColors.textColor, fontSize: 9.0),),
                        const SizedBox(height: 12.0,),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: AppColors.loginGrey.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Previous Balance', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),
                                  Text('\u20B9 0.0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),
                                ],
                              ),
                              const SizedBox(height: 5.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Amount', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),
                                  Text('\u20B9 $originalAmount', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),

                                ],
                              ),
                              const SizedBox(height: 5.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('18% GST', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),
                                  Text('\u20B9 $gst', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),

                                ],
                              ),
                              const SizedBox(height: 5.0,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total Amount', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),
                                  Text('\u20B9 ${widget.subscription!.amount}', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8.0, color: AppColors.textColor),),

                                ],
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  ),
                  const SizedBox(height: 50.0),

                  ElevatedButton.icon(
                    onPressed: () => _printPrescription(context),
                    icon: const Icon(Icons.print, color: AppColors.verdigris, size: 25.0,),
                    label: Text(
                      "Print",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: AppColors.verdigris.withOpacity(0.8),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 2.0,
                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                      // surfaceTintColor: AppColors.verdigris,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }


  Future<Uint8List?> _capturePrescriptionImage() async {
    RenderRepaintBoundary boundary =
    _key.currentContext?.findRenderObject() as RenderRepaintBoundary;
    var image = await boundary.toImage(pixelRatio: 5.0);
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  Future<void> _generatePdf(Uint8List imageBytes) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                alignment: pw.Alignment.topLeft,
                child: pw.Image(image, fit: pw.BoxFit.contain),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  void _printPrescription(BuildContext context) async {
    try {
      Uint8List? imageBytes = await _capturePrescriptionImage();
      await _generatePdf(imageBytes!);
    } catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to print!")),
      );
    }
  }

}
