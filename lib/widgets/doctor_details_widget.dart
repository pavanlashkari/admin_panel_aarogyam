import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDetails extends StatefulWidget {
  final String dname;
  final String daddress;
  final String dage;
  final String dcertificate;
  final String demail;
  final String dfee;
  final String dimage;
  final String dpass;
  final String dtype;
  final String dstatus;
  final String documentId;

  const DoctorDetails({
    Key? key,
    required this.dname,
    required this.demail,
    required this.dage,
    required this.dpass,
    required this.daddress,
    required this.dfee,
    required this.dimage,
    required this.dstatus,
    required this.dcertificate,
    required this.dtype,
    required this.documentId,
  }) : super(key: key);

  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  void _acceptDoctor(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('request')
        .doc(widget.documentId)
        .update({'status' : 'accepted'});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doctor accepted successfully!'),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
    setState(() {});
  }

  void _rejectedDoctor(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('request')
        .doc(widget.documentId)
        .update({'status' : 'rejected'});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doctor rejected successfully!'),
        duration: Duration(seconds: 2), // Adjust the duration as needed
      ),
    );
    setState(() {});
  }

  void _showDegree(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.dcertificate),
                fit: BoxFit.fill,
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Detail Screen'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('request')
            .doc(widget.documentId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var doctorData = snapshot.data?.data() as Map<String, dynamic>?;

          if (doctorData != null) {
            String status = doctorData['status'] ?? '';
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.dimage,
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return const Text('Image Error');
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name:${widget.dname}',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8.0),
                            Text('Email: ${widget.demail}'),
                            const SizedBox(height: 8.0),
                            Text('Specialist: ${widget.dtype}'),
                            const SizedBox(height: 8.0),
                            Text('DOB: ${widget.dage}'),
                            const SizedBox(height: 8.0),
                            Text('Status: ${widget.dstatus}'),
                            const SizedBox(height: 8.0),
                            Text('Fee: ${widget.dfee}'),
                            const SizedBox(height: 8.0),
                            Text('Address: ${widget.daddress}'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  const Text('for degree click here :-'),
                  InkWell(
                    onTap: () => _showDegree(context),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        ' DEGREE ',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  )
                ]),
                if (status == 'accepted')
                  Row(
                    children: [
                      const Text('Doctor already verified'),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _rejectedDoctor(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(140, 40),
                          ),
                          child: const Text('Reject'),
                        ),
                      )
                    ],
                  ),
                if (status == 'rejected')
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _acceptDoctor(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(140, 40),
                          ),
                          child: const Text('Accept'),
                        ),
                      ),
                      const Spacer(),
                      const Text('Doctor rejected'),
                    ],
                  ),
                if (status != 'accepted' && status != 'rejected')
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _rejectedDoctor(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(140, 40),
                          ),
                          child: const Text('Reject'),
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () => _acceptDoctor(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            fixedSize: const Size(140, 40),
                          ),
                          child: const Text('Accept'),
                        ),
                      )
                    ],
                  )
              ],
            );
          } else {
            return const Text('Error fetching data');
          }
        },
      ),
    );
  }
}
