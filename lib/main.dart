import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'firestore_service.dart';
import 'tela_cadastro_usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: TelaLogin()));
}

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});
  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final email = TextEditingController(), senha = TextEditingController();

  msg(t) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t)));

  Future<void> login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: senha.text.trim(),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaPrincipal()));
    } on FirebaseAuthException {
      msg('E-mail ou senha incorretos');
    }
  }

  Future<void> recuperarSenha() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text.trim());
    msg('E-mail de recuperação enviado');
  }

  Widget campo(c,l,{o=false}) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: TextField(controller: c, obscureText: o, decoration: InputDecoration(labelText: l,border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 330,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20),boxShadow: const [BoxShadow(blurRadius: 10,color: Colors.black12)]),
          child: Column(mainAxisSize: MainAxisSize.min,children: [
            const Text('MedControl',style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            campo(email,'E-mail'),
            campo(senha,'Senha',o:true),
            ElevatedButton(onPressed: login, child: const Text('Entrar')),
            TextButton(onPressed: recuperarSenha, child: const Text('Esqueci minha senha')),
            TextButton(
              onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (_) => const TelaCadastroUsuario())),
              child: const Text('Criar conta'),
            )
          ]),
        ),
      ),
    );
  }
}

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});
  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final service = FirestoreService(), remedio = TextEditingController(), horario = TextEditingController();

  Future<void> salvar([String? id]) async {
    if(remedio.text.isEmpty || horario.text.isEmpty) return;
    final data={'nome': remedio.text,'horario': horario.text};
    id == null ? await service.db.add(data) : await service.db.doc(id).update(data);
    remedio.clear(); horario.clear();
    if(mounted) Navigator.pop(context);
  }

  void abrir([DocumentSnapshot? d]) {
    remedio.text = d?['nome'] ?? '';
    horario.text = d?['horario'] ?? '';
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(d == null ? 'Novo remédio' : 'Editar'),
        content: Column(mainAxisSize: MainAxisSize.min,children: [
          TextField(controller: remedio, decoration: const InputDecoration(labelText: 'Remédio')),
          TextField(controller: horario, decoration: const InputDecoration(labelText: 'Horário')),
        ]),
        actions: [TextButton(onPressed: ()=>salvar(d?.id), child: const Text('Salvar'))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meus Remédios')),
      floatingActionButton: FloatingActionButton(onPressed: ()=>abrir(), child: const Icon(Icons.add)),
      body: StreamBuilder<QuerySnapshot>(
        stream: service.listar(),
        builder: (_, s) {
          if (!s.hasData) return const Center(child: CircularProgressIndicator());
          final docs = s.data!.docs;
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (_, i) {
              final d = docs[i];
              return ListTile(
                leading: const Icon(Icons.medication),
                title: Text(d['nome']),
                subtitle: Text('Horário: ${d['horario']}'),
                trailing: Row(mainAxisSize: MainAxisSize.min,children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: ()=>abrir(d)),
                  IconButton(icon: const Icon(Icons.delete), onPressed: ()=>service.excluir(d.id)),
                ]),
              );
            },
          );
        },
      ),
    );
  }
}
