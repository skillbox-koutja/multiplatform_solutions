import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multiplatform_solutions/ui/screen/employees.dart';
import 'package:popover/popover.dart';

class AdaptiveScreen extends StatefulWidget {
  static const wideWidth = 720;

  const AdaptiveScreen({Key? key}) : super(key: key);

  @override
  State<AdaptiveScreen> createState() => _AdaptiveScreenState();
}

class _AdaptiveScreenState extends State<AdaptiveScreen> {
  late final Future<List<Employee>> employeesFuture;
  @override
  void initState() {
    super.initState();

    employeesFuture = Employees().get();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Employee>>(
        future: employeesFuture,
        builder: (context, snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('Employees not found'));
          }

          final employees = snapshot.data!;

          return LayoutBuilder(builder: (context, constraints) {
            return constraints.maxWidth > AdaptiveScreen.wideWidth
                ? _WideScreen(
                    employees: employees,
                  )
                : _NormalScreen(
                    employees: employees,
                  );
          });
        },
      ),
    );
  }
}

class _WideScreen extends StatelessWidget {
  final List<Employee> employees;

  const _WideScreen({
    required this.employees,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 180,
            height: double.infinity,
            child: ColoredBox(
              color: Colors.blue,
              child: Column(
                children: const [
                  Text(
                    'Adaptive app',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: employees.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return _Card(
                  employee: employees[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Employee employee;

  const _Card({
    required this.employee,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showDetails() {
      showPopover(
        context: context,
        bodyBuilder: (context) => const ListItems(),
        direction: PopoverDirection.bottom,
        width: 200,
        height: 200,
        arrowHeight: 15,
        arrowWidth: 30,
      );
    }

    return GestureDetector(
      onTap: showDetails,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                child: Text(employee.initials),
              ),
              Text(employee.name),
              Text(
                employee.email,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NormalScreen extends StatelessWidget {
  final List<Employee> employees;

  const _NormalScreen({
    required this.employees,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void showDetails() {
      showDialog<void>(
        context: context,
        builder: (_) {
          return const ListItems();
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive app'),
      ),
      body: SizedBox.expand(
        child: ListView.builder(
          itemCount: employees.length,
          prototypeItem: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                child: Text(Employee.empty.initials),
              ),
              title: Text(Employee.empty.name),
              subtitle: Text(
                Employee.empty.email,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: showDetails,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    child: Text(employees[index].initials),
                  ),
                  title: Text(employees[index].name),
                  subtitle: Text(
                    employees[index].email,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListItems extends StatelessWidget {
  const ListItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              height: 50,
              color: Colors.amber[100],
              child: const Center(child: Text('VIEW PROFILE')),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              height: 50,
              color: Colors.amber[200],
              child: const Center(child: Text('FRIENDS')),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Container(
              height: 50,
              color: Colors.amber[300],
              child: const Center(child: Text('REPORT')),
            ),
          ),
        ],
      ),
    );
  }
}
