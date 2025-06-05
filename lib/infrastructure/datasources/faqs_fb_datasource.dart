import 'package:elanel_asistencia_it/domain/datasources/faqs_datasource.dart';
import 'package:elanel_asistencia_it/domain/entities/faq.dart';


class FAQsFbDatasource extends IFAQsDatasource{

  final List<FAQ> faqs = [
    FAQ(
      id: '001',
      title: '¿Cómo puedo restablecer mi contraseña?',
      description: '''
  Si olvidaste tu contraseña, no te preocupes. Restablecerla es un proceso sencillo que podés hacer en unos pocos pasos:

  1. En la pantalla de inicio de sesión, hacé clic en **"¿Olvidaste tu contraseña?"**.
  2. Ingresá la dirección de correo electrónico que usaste para registrarte.
  3. Revisá tu bandeja de entrada. Recibirás un correo con un enlace para restablecer tu contraseña.
  4. Hacé clic en el enlace y seguí las instrucciones para crear una nueva contraseña segura.

  *Recomendación:* usá una contraseña que combine letras mayúsculas, minúsculas, números y símbolos para mejorar la seguridad de tu cuenta.
  ''',
      type: FAQType.software,
    ),
    FAQ(
      id: '002',
      title: '¿Qué debo hacer si mi computadora no enciende?',
      description: '''
  Si tu computadora no responde al intentar encenderla, probá lo siguiente:

  - Verificá que esté conectada a una fuente de energía funcional.
  - Asegurate de que el cable de alimentación no esté dañado o flojo.
  - Probá con otro enchufe o regleta para descartar fallos eléctricos.
  - Si es una notebook, intentá quitar la batería (si es extraíble) y conectar el cargador directamente.

  Si después de esto la computadora sigue sin encender, es probable que haya un problema de hardware interno. En ese caso, te recomendamos contactar al **soporte técnico especializado** para una revisión más profunda.
  ''',
      type: FAQType.hardware,
    ),
    FAQ(
      id: '003',
      title: '¿Cómo puedo instalar una impresora nueva?',
      description: '''
  Para instalar correctamente una impresora nueva, seguí estos pasos según el tipo de conexión:

  - **USB**: conectá el cable USB al puerto de la computadora. El sistema intentará reconocer el dispositivo automáticamente. Si no lo hace, descargá los controladores desde el sitio oficial del fabricante.
  - **Wi-Fi**: encendé la impresora y conectala a la red Wi-Fi desde su panel de configuración. Luego, en tu computadora, agregala desde la opción **"Agregar impresora"** en la configuración del sistema.

  *Consejo:* siempre usá los controladores más actualizados para evitar problemas de compatibilidad.
  ''',
      type: FAQType.hardware,
    ),
    FAQ(
      id: '004',
      title: '¿Qué puedo hacer si no tengo acceso a mi correo electrónico registrado?',
      description: '''
  Si no podés acceder a tu correo electrónico y necesitás restablecer tu contraseña u obtener notificaciones:

  1. Intentá recuperar el acceso a tu correo desde la página del proveedor (Gmail, Outlook, etc.).
  2. Si no lo lográs, comunicate con **soporte técnico** y verificá tu identidad proporcionando:
    - Documento o credencial institucional.
    - Información del último inicio de sesión exitoso.
  3. Una vez verificada tu identidad, podrán actualizar tu dirección de correo registrada.

  *Importante:* Mantené siempre actualizada tu información de contacto para evitar estos inconvenientes.
  ''',
      type: FAQType.software,
    ),
    FAQ(
      id: '005',
      title: '¿Qué hacer si la pantalla se congela y no responde?',
      description: '''
  Una pantalla congelada suele ser señal de un problema temporal del sistema. Probá lo siguiente:

  - Esperá unos segundos para ver si el sistema se recupera solo.
  - Presioná `Ctrl + Alt + Supr` y abrí el **Administrador de tareas** para cerrar el programa que no responde.
  - Si eso no funciona, mantené presionado el botón de encendido durante 10 segundos para forzar el apagado.

  *Después de reiniciar:* verificá si tenés actualizaciones del sistema pendientes o revisá si algún programa está consumiendo demasiada memoria.
  ''',
      type: FAQType.hardware,
    ),
    FAQ(
      id: '006',
      title: '¿Cómo puedo reportar un problema técnico?',
      description: '''
  Si tenés un inconveniente técnico, te recomendamos seguir estos pasos para reportarlo:

  1. Ingresá al sistema con tu cuenta.
  2. Navegá a la sección de **"Tickets"** y hacé clic en **"Nuevo ticket"**.
  3. Completá el formulario con:
    - Título claro del problema.
    - Descripción detallada del error.
    - Dispositivo o área afectada.

  Una vez enviado, un técnico será asignado para ayudarte. Vas a poder seguir el estado del ticket desde la misma sección.

  *Tip:* mientras más información brindes, más rápido podrán ayudarte.
  ''',
      type: FAQType.software,
    ),
    FAQ(
      id: '007',
      title: '¿Qué hacer si no tengo conexión a Internet?',
      description: '''
  Si no tenés acceso a Internet, podés realizar los siguientes pasos para intentar solucionarlo:

  - Verificá si otros dispositivos tienen conexión. Si tampoco funcionan, es posible que el problema sea del proveedor de Internet.
  - Reiniciá el módem y el router desenchufándolos durante 30 segundos y volviéndolos a conectar.
  - Comprobá que tu computadora esté conectada a la red correcta y que no esté en **modo avión**.
  - Si usás Wi-Fi, acercate al router para mejorar la señal.

  Si el problema persiste, contactá al área de soporte de redes para revisar si hay interrupciones en el servicio o conflictos de IP.

  *Dato útil:* anotar el estado de los indicadores LED del módem puede ayudar a diagnosticar el problema más rápido.
  ''',
      type: FAQType.network,
    ),
  ];


  @override
  Future<List<FAQ>> getFAQs() async {
    return faqs;
  }
  
  @override
  Future<void> addFAQ(FAQ faq) async{
    faqs.insert(0, faq);
  }
  
  @override
  Future<void> deleteFAQ(String id) {
    // TODO: implement deleteFAQ
    throw UnimplementedError();
  }
  
  @override
  Future<void> updateFAQ(FAQ faq) {
    // TODO: implement updateFAQ
    throw UnimplementedError();
  }
  
}