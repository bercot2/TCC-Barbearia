library glbls.globals;

import 'package:barberapp/src/model/Barber.dart';
import 'package:barberapp/src/model/Servico.dart';
import 'package:barberapp/src/model/User.dart';
import 'package:barberapp/src/requests/APIConsumer.dart';


APIConsumer request = APIConsumer();

User user;
List<Barber> barbers = [];
List<Servico> servicos = [];

dynamic tempTime;
dynamic tempDate;
