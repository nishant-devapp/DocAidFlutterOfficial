import 'package:code/home/provider/home_provider.dart';
import 'package:code/home/widgets/doctor_profile_base.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/colors.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _specializationController =
      TextEditingController();
  late List<String> initialDegrees,
      initialAchievements,
      initialResearchJournal,
      initialCitation;
  List<TextEditingController> _researchJournalControllers = [];
  List<TextEditingController> _citationsControllers = [];
  List<TextEditingController> _degreeControllers = [];
  List<TextEditingController> _achievementsControllers = [];
  List<String> finalSpecialization = [];
  String? licenceNumber;

  final _key = GlobalKey<FormState>();
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    final homeProvider = Provider.of<HomeGetProvider>(context, listen: false);
    initialResearchJournal = homeProvider.doctorProfile!.data!.researchJournal!;
    initialCitation = homeProvider.doctorProfile!.data!.citations!;
    initialAchievements = homeProvider.doctorProfile!.data!.achievements!;
    initialDegrees = homeProvider.doctorProfile!.data!.degree!;
    licenceNumber = homeProvider.doctorProfile!.data!.licenceNumber;
    _firstNameController.text = homeProvider.doctorProfile!.data!.firstName!;
    _lastNameController.text = homeProvider.doctorProfile!.data!.lastName!;
    _contactController.text = homeProvider.doctorProfile!.data!.contact!;
    _emailController.text = homeProvider.doctorProfile!.data!.email!;
    _specializationController.text =
        homeProvider.doctorProfile!.data!.specialization!.first;
    _experienceController.text =
        homeProvider.doctorProfile!.data!.experience.toString();
    _initializeResearchJournalControllers();
    _initializeCitationsControllers();
    _initializeDegreeControllers();
    _initializeAchievementsControllers();
  }

  void _initializeResearchJournalControllers() {
    _researchJournalControllers = initialResearchJournal
        .map((researchJournal) => TextEditingController(text: researchJournal))
        .toList();
    if (_researchJournalControllers.isEmpty) {
      _researchJournalControllers.add(TextEditingController());
    }
  }

  void _initializeCitationsControllers() {
    _citationsControllers = initialCitation
        .map((citations) => TextEditingController(text: citations))
        .toList();
    if (_citationsControllers.isEmpty) {
      _citationsControllers.add(TextEditingController());
    }
  }

  void _initializeDegreeControllers() {
    _degreeControllers = initialDegrees
        .map((degree) => TextEditingController(text: degree))
        .toList();
    if (_degreeControllers.isEmpty) {
      _degreeControllers.add(TextEditingController());
    }
  }

  void _initializeAchievementsControllers() {
    _achievementsControllers = initialAchievements
        .map((achievements) => TextEditingController(text: achievements))
        .toList();
    if (_achievementsControllers.isEmpty) {
      _achievementsControllers.add(TextEditingController());
    }
  }

  void _addResearchJournal() {
    setState(() {
      _researchJournalControllers.add(TextEditingController());
    });
  }

  void _removeResearchJournal(int index) {
    if (_researchJournalControllers.length > 1) {
      setState(() {
        _researchJournalControllers.removeAt(index);
      });
    }
  }

  void _addCitations() {
    setState(() {
      _citationsControllers.add(TextEditingController());
    });
  }

  void _removeCitations(int index) {
    if (_citationsControllers.length > 1) {
      setState(() {
        _citationsControllers.removeAt(index);
      });
    }
  }

  void _addDegrees() {
    setState(() {
      _degreeControllers.add(TextEditingController());
    });
  }

  void _removeDegrees(int index) {
    if (_degreeControllers.length > 1) {
      setState(() {
        _degreeControllers.removeAt(index);
      });
    }
  }

  void _addAchievements() {
    setState(() {
      _achievementsControllers.add(TextEditingController());
    });
  }

  void _removeAchievements(int index) {
    if (_achievementsControllers.length > 1) {
      setState(() {
        _achievementsControllers.removeAt(index);
      });
    }
  }

  @override
  void dispose() {
    for (var rSController in _researchJournalControllers) {
      rSController.dispose();
    }
    for (var ciController in _citationsControllers) {
      ciController.dispose();
    }
    for (var acController in _achievementsControllers) {
      acController.dispose();
    }
    for (var degController in _degreeControllers) {
      degController.dispose();
    }
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _experienceController.dispose();
    _specializationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final deviceHeight = mediaQuery.size.height;
    final deviceWidth = mediaQuery.size.width;

    return DoctorProfileBase(
      builder: (HomeGetProvider homeProvider) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: _key,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w500),
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _firstNameController,
                      keyboardType: TextInputType.name,
                      readOnly: true,
                      decoration: InputDecoration(
                          label: const Text('First Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      textCapitalization: TextCapitalization.words,
                      controller: _lastNameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          label: const Text('Last Name'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter last name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _contactController,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      decoration: InputDecoration(
                          label: const Text('Contact'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter contact number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true,
                      decoration: InputDecoration(
                          label: const Text('Email'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _experienceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: const Text('Experience'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter experience';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12.0),
                    TextFormField(
                      controller: _specializationController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          label: const Text('Specialization'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          )),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter specialization';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 22.0),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _researchJournalControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller:
                                        _researchJournalControllers[index],
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        label: const Text('Research Journal'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter research journal';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: AppColors.princetonOrange,
                                    size: 28.0,
                                  ),
                                  onPressed: () =>
                                      _removeResearchJournal(index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: AppColors.verdigris,
                                    size: 28.0,
                                  ),
                                  onPressed: _addResearchJournal,
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 22.0),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _citationsControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _citationsControllers[index],
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        label: const Text('Citations'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter citations';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: AppColors.princetonOrange,
                                    size: 28.0,
                                  ),
                                  onPressed: () => _removeCitations(index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: AppColors.verdigris,
                                    size: 28.0,
                                  ),
                                  onPressed: _addCitations,
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 22.0),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _degreeControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _degreeControllers[index],
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        label: const Text('Degrees'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter degrees';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: AppColors.princetonOrange,
                                    size: 28.0,
                                  ),
                                  onPressed: () => _removeDegrees(index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: AppColors.verdigris,
                                    size: 28.0,
                                  ),
                                  onPressed: _addDegrees,
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(height: 22.0),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _achievementsControllers.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _achievementsControllers[index],
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        label: const Text('Achievements'),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        )),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter achievements';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.remove_circle,
                                    color: AppColors.princetonOrange,
                                    size: 28.0,
                                  ),
                                  onPressed: () => _removeAchievements(index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.add_circle,
                                    color: AppColors.verdigris,
                                    size: 28.0,
                                  ),
                                  onPressed: _addAchievements,
                                ),
                              ],
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ElevatedButton(
                      onPressed: _isUpdating ? null : _editProfile,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, deviceHeight * 0.06),
                        backgroundColor: AppColors.verdigris,
                      ),
                      child: _isUpdating
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Submit',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _editProfile() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    // setState(() {
    //   _isUpdating = true;
    // });

    List<String> researchJournals = _researchJournalControllers
        .map((controller) => controller.text)
        .toList();

    List<String> citations =
        _citationsControllers.map((controller) => controller.text).toList();

    List<String> degrees =
        _degreeControllers.map((controller) => controller.text).toList();

    List<String> achievements =
        _achievementsControllers.map((controller) => controller.text).toList();

    // Formatting the output
    List<String> formattedSpecializationList = [
      (_specializationController.text)
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder(
          future: Provider.of<HomeGetProvider>(context, listen: false)
              .updateDoctorProfile(
                  _firstNameController.text.trim(),
                  _lastNameController.text.trim(),
                  _emailController.text.trim(),
                  _contactController.text.trim(),
                  degrees,
                  achievements,
                  researchJournals,
                  citations,
                  formattedSpecializationList,
                  int.parse(_experienceController.text.trim()),
                  licenceNumber!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AlertDialog(
                content: Row(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(width: 20),
                    Text(
                      'Updating Profile...',
                      style:
                          TextStyle(color: AppColors.textColor, fontSize: 18.0),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Error updating profile: ${snapshot.error}'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            } else {
              return AlertDialog(
                title: const Text('Success'),
                content: const Text('Profile Updated successfully!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
