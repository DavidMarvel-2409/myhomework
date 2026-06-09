import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewmodels/qa_viewmodel.dart';
import '../widgets/app_drawer.dart';

class QaScreen extends StatefulWidget {
  const QaScreen({super.key});

  @override
  State<QaScreen> createState() => _QaScreenState();
}

class _QaScreenState extends State<QaScreen> {
  bool loaded = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<QaViewModel>().loadQuestions();
    });
  }

  Future<void> sendEmail(QaViewModel viewModel) async {
    final subject = Uri.encodeComponent('Valoración MyHomework');

    final body = Uri.encodeComponent(viewModel.buildEmailMessage());

    final Uri emailUri = Uri.parse(
      'mailto:david.marvel.programer.2409@gmail.com?subject=$subject&body=$body',
    );

    await launchUrl(emailUri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QaViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          drawer: const AppDrawer(),
          appBar: AppBar(title: const Text('Valorización')),
          body: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: viewModel.questions.length,
                          itemBuilder: (context, index) {
                            final question = viewModel.questions[index];

                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      question.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    Center(
                                      child: Text(
                                        question.value == 0
                                            ? "Sin responder"
                                            : "${question.value} estrellas",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    Slider(
                                      min: 0,
                                      max: 5,
                                      divisions: 5,
                                      value: question.value.toDouble(),
                                      label: question.value.toString(),
                                      onChanged: (value) {
                                        viewModel.updateAnswer(
                                          index,
                                          value.toInt(),
                                        );
                                      },
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      question.minDescription,
                                      style: const TextStyle(fontSize: 12),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      question.maxDescription,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      ElevatedButton.icon(
                        onPressed: () async {
                          if (!viewModel.allQuestionsAnswered) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Debes responder todas las preguntas',
                                ),
                              ),
                            );
                            return;
                          }

                          await sendEmail(viewModel);
                        },
                        icon: const Icon(Icons.send),
                        label: const Text("Enviar"),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
