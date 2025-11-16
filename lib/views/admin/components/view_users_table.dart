import 'package:eventify/providers/user_provider.dart';
import 'package:eventify/views/admin/admin_edit_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class ViewUsersTable extends StatefulWidget {
  final double scale;
  const ViewUsersTable({super.key, required this.scale});

  @override
  State<StatefulWidget> createState() => _ViewUsersTable();
}

class _ViewUsersTable extends State<ViewUsersTable> {
  late final UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = UserProvider();
    userProvider.loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scale = size.width / 400;

    return ChangeNotifierProvider<UserProvider>.value(
      value: userProvider,
      child: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final users = userProvider.users;

          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (users.isEmpty) {
            return const Center(child: Text("No hay usuarios"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Slidable(
                key: ValueKey(user.id),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (_) async =>
                          await userProvider.activateUser(user.id!),
                      backgroundColor: Colors.greenAccent,
                      icon: Icons.check,
                      label: 'Activar',
                    ),
                    SlidableAction(
                      onPressed: (_) async =>
                          await userProvider.deactivateUser(user.id!),
                      backgroundColor: Colors.orangeAccent,
                      icon: Icons.block,
                      label: 'Desactivar',
                    ),
                    SlidableAction(
                      onPressed: (_) async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmar eliminación'),
                            content: Text(
                              '¿Estás seguro de que quieres eliminar a ${user.name}?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text(
                                  'Eliminar',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await userProvider.deleteUser(user.id!);
                        }
                      },
                      backgroundColor: Colors.red,
                      icon: Icons.delete,
                      label: 'Eliminar',
                    ),
                  ],
                ),
                child: Container(
                  width: size.width * 0.90,
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.05,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: ListTile(
                    leading: Icon(Icons.account_circle_rounded),

                    iconColor: Color.fromRGBO(97, 92, 233, 1.0),

                    title: Text(
                      user.name,
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),

                    subtitle: Text(user.email),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          user.actived == 1 ? Icons.check_circle : Icons.cancel,
                          color: user.actived == 1
                              ? Colors.greenAccent
                              : Colors.redAccent,
                        ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AdminEditUser(),
                                ),
                              );
                            });
                          },
                          icon: Icon(Icons.edit_note_sharp),
                          color: Color.fromRGBO(63, 61, 86, 1.0),
                          iconSize: 35 * scale,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
