import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(
        uid: '1', nombre: 'Felipe', email: 'Felipe@gmail.com', online: true),
    Usuario(
        uid: '2', nombre: 'Greisy', email: 'Greisy@gmail.com', online: true),
    Usuario(
        uid: '3',
        nombre: 'Valentina',
        email: 'Valentina@gmail.com',
        online: true),
    Usuario(
        uid: '4', nombre: 'Camilo', email: 'Camilo@gmail.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Nombre', style: TextStyle(color: Colors.black87)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {},
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.red),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        onRefresh: _cargarUsuarios,
        child: _listViewUsuarios(),
      ),
    );
  }

  ListTile usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  void _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
