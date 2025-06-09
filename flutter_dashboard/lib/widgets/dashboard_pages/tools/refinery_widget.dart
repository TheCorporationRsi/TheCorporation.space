import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';

class RefineryJob {
  final String location;
  final int amount;
  final double cost;
  final Duration duration;
  final DateTime startTime;

  RefineryJob({
    required this.location,
    required this.amount,
    required this.cost,
    required this.duration,
    required this.startTime,
  });

  DateTime get endTime => startTime.add(duration);

  double get progress {
    final now = DateTime.now();
    if (now.isAfter(endTime)) return 1.0;
    final total = duration.inSeconds;
    final elapsed = now.difference(startTime).inSeconds;
    return (elapsed / total).clamp(0.0, 1.0);
  }

  bool get isDone => DateTime.now().isAfter(endTime);
}

class RefineryWidget extends StatefulWidget {
  const RefineryWidget({super.key});

  @override
  State<RefineryWidget> createState() => _RefineryWidgetState();
}

class _RefineryWidgetState extends State<RefineryWidget> {
  final List<RefineryJob> jobs = [];
  final _formKey = GlobalKey<FormState>();
  final _locationController = TextEditingController();
  final _amountController = TextEditingController();
  final _costController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    _amountController.dispose();
    _costController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  void _addJob() {
    if (_formKey.currentState?.validate() ?? false) {
      final location = _locationController.text.trim();
      final amount = int.tryParse(_amountController.text.trim()) ?? 0;
      final cost = double.tryParse(_costController.text.trim()) ?? 0.0;
      final minutes = int.tryParse(_durationController.text.trim()) ?? 0;
      final duration = Duration(minutes: minutes);

      setState(() {
        jobs.add(RefineryJob(
          location: location,
          amount: amount,
          cost: cost,
          duration: duration,
          startTime: DateTime.now(),
        ));
      });

      _locationController.clear();
      _amountController.clear();
      _costController.clear();
      _durationController.clear();
      Navigator.pop(context);
    }
  }

  void _showAddJobDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBackgroundColor,
        title: const Text('Add Refinery Job', style: TextStyle(color: Colors.white)),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (v) => v == null || v.isEmpty ? 'Enter location' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? 'Enter amount' : null,
              ),
              TextFormField(
                controller: _costController,
                decoration: const InputDecoration(
                  labelText: 'Cost',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) => v == null || double.tryParse(v) == null ? 'Enter cost' : null,
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duration (minutes)',
                  labelStyle: TextStyle(color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? 'Enter duration' : null,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: secondaryColor)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            onPressed: _addJob,
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeJob(int idx) {
    setState(() {
      jobs.removeAt(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Timer to update progress bars
    return StatefulBuilder(
      builder: (context, setStateSB) {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) setStateSB(() {});
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                const SizedBox(height: 18),
                Row(
                  children: [
                    Text(
                      "Refinery Tracker",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Add Job'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _showAddJobDialog,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                if (jobs.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.factory, size: 48, color: secondaryColor),
                        const SizedBox(height: 12),
                        Text(
                          "No refinery jobs tracked.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: jobs.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, idx) {
                    final job = jobs[idx];
                    final done = job.isDone;
                    final remaining = done
                        ? Duration.zero
                        : job.endTime.difference(DateTime.now());
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      color: cardBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, color: primaryColor),
                                const SizedBox(width: 8),
                                Text(
                                  job.location,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  icon: Icon(Icons.delete, color: secondaryColor),
                                  onPressed: () => _removeJob(idx),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Icon(Icons.inventory, color: secondaryColor, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  "Amount: ${job.amount}",
                                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                ),
                                const SizedBox(width: 16),
                                Icon(Icons.monetization_on, color: primaryColor, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  "Cost: ${job.cost.toStringAsFixed(2)}",
                                  style: TextStyle(color: Colors.white.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            LinearProgressIndicator(
                              value: job.progress,
                              backgroundColor: Colors.white.withOpacity(0.1),
                              color: done ? secondaryColor : primaryColor,
                              minHeight: 8,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                if (!done)
                                  Text(
                                    "Time left: ${remaining.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(remaining.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                if (done)
                                  Text(
                                    "Done!",
                                    style: TextStyle(
                                      color: secondaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                const Spacer(),
                                Text(
                                  "Total: ${job.duration.inMinutes} min",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
