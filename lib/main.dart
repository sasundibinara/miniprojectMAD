import 'package:flutter/material.dart';

void main() {
  runApp(const CricketApp());
}

class CricketApp extends StatelessWidget {
  const CricketApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cricket App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0B4F8A),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFF0877C9),
        useMaterial3: true,
      ),
      home: const CricketHomePage(),
    );
  }
}

class CricketHomePage extends StatefulWidget {
  const CricketHomePage({super.key});

  @override
  State<CricketHomePage> createState() => _CricketHomePageState();
}

class _CricketHomePageState extends State<CricketHomePage> {
  int _runs = 0;
  int _wickets = 0;
  int _balls = 0;

  void _addRun(int runs) {
    setState(() {
      // Every delivery counts as one ball; the selected run value changes runs.
      _runs += runs;
      _balls++;
    });
  }

  void _addWicket() {
    setState(() {
      // A wicket uses a ball but does not change the run total.
      _wickets++;
      _balls++;
    });
  }

  void _resetScore() {
    setState(() {
      _runs = 0;
      _wickets = 0;
      _balls = 0;
    });
  }

  String get _overs => '${_balls ~/ 6}.${_balls % 6}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF063B70),
        foregroundColor: Colors.white,
        title: const Text(
          'Cricket App',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0877C9), Color(0xFF04549A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final contentWidth = constraints.maxWidth > 600
                  ? 560.0
                  : double.infinity;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        _Scoreboard(
                          runs: _runs,
                          wickets: _wickets,
                          overs: _overs,
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ScoreCard(
                                icon: Icons.sports_cricket,
                                label: 'Runs',
                                value: _runs,
                                iconColor: const Color(0xFFE7A74E),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: ScoreCard(
                                icon: Icons.sports_baseball,
                                label: 'Balls',
                                value: _balls,
                                iconColor: const Color(0xFFE85B55),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tap to score',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1.55,
                          children: [
                            for (final value in [0, 1, 2, 3, 4, 6])
                              ScoreButton(
                                label: '$value',
                                onPressed: () => _addRun(value),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ScoreButton(
                                label: 'Wicket',
                                icon: Icons.sports_cricket,
                                onPressed: _addWicket,
                                backgroundColor: const Color(0xFFB93838),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ScoreButton(
                                label: 'Reset',
                                icon: Icons.refresh,
                                onPressed: _resetScore,
                                backgroundColor: const Color(0xFF063B70),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Scoreboard extends StatelessWidget {
  const _Scoreboard({
    required this.runs,
    required this.wickets,
    required this.overs,
  });

  final int runs;
  final int wickets;
  final String overs;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'CURRENT SCORE',
                style: TextStyle(
                  color: Color(0xFFBFE5FF),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$runs/$wickets',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 38,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'OVERS',
                style: TextStyle(
                  color: Color(0xFFBFE5FF),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                overs,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Icon(icon, size: 38, color: iconColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF42627B),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: Color(0xFF102A43),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScoreButton extends StatelessWidget {
  const ScoreButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.backgroundColor,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 19),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        foregroundColor: backgroundColor == null
            ? const Color(0xFF0B4F8A)
            : Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      ),
    );
  }
}
