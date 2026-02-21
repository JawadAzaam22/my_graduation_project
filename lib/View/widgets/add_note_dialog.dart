import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../Models/my_notes/session_note.dart';
import '../../l10n/app_localizations.dart';

class AddNoteDialog extends StatefulWidget {
  final int sessionId;
  final int trainingId;

  const AddNoteDialog({
    super.key,
    required this.sessionId,
    required this.trainingId,
  });

  @override
  State<AddNoteDialog> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends State<AddNoteDialog> {
  final TextEditingController noteController = TextEditingController();

  void saveNote() async {
    final noteText = noteController.text.trim();

    if (noteText.isEmpty) {
      if (mounted) {
        Get.snackbar(
          AppLocalizations.of(context)!.noteAlertTitle,
          AppLocalizations.of(context)!.noteEmptyError,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      return;
    }

    final box = Hive.box<SessionNote>('sessionNotesBox');
    final note = SessionNote(
      trainingId: widget.trainingId,
      sessionId: widget.sessionId,
      noteText: noteText,
      createdAt: DateTime.now(),
    );

    await box.add(note);

    if (mounted) {
      Get.back();
      Get.snackbar(
        AppLocalizations.of(context)!.savedSuc,
        AppLocalizations.of(context)!.noteSaved,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.black;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth * 0.9;
        final maxHeight = constraints.maxHeight * 0.8;

        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth,
              maxHeight: maxHeight,
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: constraints.biggest.shortestSide * 0.12,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    AppLocalizations.of(context)!.addNoteToSession,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: constraints.biggest.shortestSide * 0.045,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: noteController,
                    maxLines: 5,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.writeYourNote,
                      hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                      filled: true,
                      fillColor: theme.colorScheme.primaryContainer,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: theme.primaryColor, width: 1.2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (mounted) Get.back();
                          },
                          style: OutlinedButton.styleFrom(
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                                color: theme.primaryColor.withOpacity(0.3)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.cancel,
                            style: TextStyle(
                              color: textColor.withOpacity(0.8),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: saveNote,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.primaryColor,
                            padding:
                            const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 2,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.save,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
