// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:radar/constants/device_utils.dart';
import 'package:radar/constants/generate_route.dart';
import 'package:radar/constants/route_arguments.dart';
import 'package:radar/main.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:camera/camera.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:radar/constants/app_utils.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/logger.dart';
import 'package:radar/constants/router.dart';
import 'package:radar/constants/size_config.dart';
import 'package:radar/domain/entities/register_payload/Register_payload.dart';
import 'package:radar/notification_service.dart';
import 'package:radar/presentation/cubits/login/login_cubit.dart';
import 'package:radar/presentation/cubits/register/register_cubit.dart';
import 'package:radar/presentation/widgets/LoadingWidget.dart';
import 'package:radar/presentation/widgets/button_widget.dart';

import 'package:radar/presentation/widgets/radius_text_field.dart';
import 'package:web_socket_client/web_socket_client.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  final _emailController = TextEditingController();
  final _regEmailController = TextEditingController();
  var nameController = TextEditingController();
  final _regPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _ageController = TextEditingController();
  final _idNumberController = TextEditingController();
  final _loginMobileController = TextEditingController();
  final _cityController = TextEditingController();
  final _iqamaExpiryController = TextEditingController();
  bool isLoginWithMobile = true;
  bool? isChecker = false;
  bool isLogin = true;
  String? country;
  String? gender;
  String? city;
  List<String> countryList = ["Admin", "Employee"];
  List<String> genderList = [
    "Male".tr(),
    "Female".tr(),
  ];
  List<String> cityList = [
    "Riyadh",
    "Jeddah",
    "Mecca",
    "Medina",
    "Dammam",
    "Khobar",
    "Dhahran",
    "Ta'if",
    "Tabuk",
    "Buraydah",
    "Hail",
    "Jubail",
    "Yanbu",
    "Abha",
    "Al-Khafji",
    "Najran",
    "Jizan",
    "Sakaka",
    "Al-Ahsa",
    "Qatif"
  ];
  late LoginCubit loginCubit;
  late RegisterCubit registerCubit;
  String phoneNumber = '';
  String loginPhoneNumber = '';
  String whatsappphoneNumber = '';
  String countryCode = '+966';
  String loginCountryCode = '+966';
  String whatsappcountryCode = '+966';
  String? imagePath;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? newImage;
  final loginFormKey = GlobalKey<FormState>();
  final regFormKey = GlobalKey<FormState>();
  NotificationServices notificationServices = NotificationServices();
  String? deviceName;
  String? deviceId;

  String? deviceToken;
  final String termsAndConditionsText = """
تشمل هذه الشروط والأحكام س (أ) شروط الاستخدام العامة المطبقة على استخدامك لتقنيات منصة راديوز؛ و (ب) أحكام محددة تتعلق بضريبة القيمة المضافة التي تتم في المملكة العربية السعودية (مرفق في الملحق 1). يرجى قراءة هذه الشروط والأحكام بعناية. تتضمن هذه الشروط والأحكام معلومات عن حقوقك والتزاماتك ومعلومات مهمة أخرى فيما يتعلق باستخدامك لتقنيات منصة راديوز.
شروط الاستخدام العامة
1. العلاقة التعاقدية
تحكم هذه الشروط والاستخدام، بما فيها شروط الاستخدام العامة وشروط ضريبة القيمة المضافة في الملحق ١ (يشار اليها مجتمعة بعبارة "الشروط") وصول أو استخدام الأفراد من داخل المملكة العربية السعودية للتطبيقات والمواقع الإلكترونية والمحتويات والمنتجات والخدمات ("الخدمات") التي توفرها منصة راديوز، وهو تطبيق مملوك لشركة الفعاليات الاسطورية التي تأسست في المملكة العربية السعودية ويقع مقرها الرئيسي في جدة
يُرجى قراءة هذه الشروط بعناية قبل الحصول على الخدمات أو استخدامها.
إن وصولك إلى الخدمات واستخدامها يعتبر موافقة منك على الالتزام بهذه الشروط، مما يُنشئ علاقة تعاقدية بينك وبين منصة راديوز. وفي حالة عدم موافقتك على هذه الشروط، لا يجوز لك الحصول على الخدمات أو استخدامها. وتحل هذه الشروط تحديداً محل أي اتفاقات أو ترتيبات سابقة أبرمت معك. ويجوز لمنصة راديوز إنهاء هذه الشروط أو أي من الخدمات التي تخصك على الفور أو بشكل عام إيقاف عرض الخدمات أو منع الوصول إليها أو إلى أي جزء منها في أي وقت ولأي سبب كان.
وقد تنطبق بعض الشروط التكميلية على خدمات معينة، كالسياسات الخاصة بحدث أو نشاط أو حملة ترويجية معينة، وسيتم الإفصاح لك عن هذه الشروط التكميلية المتعلقة بالخدمات المقدمة. تُضاف الشروط التكميلية إلى الشروط لأغراض الخدمات المقدمة كما وتعتبر جزءاً منها. وتسود الشروط التكميلية على هذه الشروط في حالة التعارض فيما يتعلق بالخدمات المقدمة.
ويجوز للمنصة تعديل الشروط المتعلقة بالخدمات من حين إلى آخر. وتسري التعديلات عند نشر منصة راديوز هذه الشروط المحدثة على هذا الموقع أو نشر السياسات المعدلة أو الشروط التكميلية المتعلقة بالخدمة المقدمة. إن استمرار وصولك إلى الخدمات أو استخدامها بعد هذا النشر يعتبر موافقة منك على الالتزام بالشروط بصيغتها المعدلة.
نحن نقوم بجمع البيانات الشخصية واستخدامها فيما يتعلق بالخدمات وفقًا لما هو منصوص عليه في  . ويجوز لمؤسسة راديوز تقديم ما يلزم من المعلومات (بما في ذلك معلومات الاتصال الخاصة بك) إلى شركات تسوية المطالبات أو شركات التأمين في حال وجود شكوى أو نزاع أو خلاف والذي قد يتضمن حادثاً يقع بينك وبين مقدم خدمات خارجي (بما في ذلك سائق شركة في شبكة النقل) حيث تكون هذه المعلومات أو البيانات ضرورية لتسوية الشكوى أو النزاع أو الخلاف.
2. الخدمات
تُشكل الخدمات منصة تقنية تمكّن مستخدمي تطبيقات الجوال أو المواقع الإلكترونية الخاصة براديوز والمتاحة كجزء من الخدمات (يُشار إلى كل منها بـ "التطبيق") لتدبير وتنظيم خدمات إدارة الحشود والفعاليات بموجب الاتفاق مع منصة راديوز. يتم توفير الخدمات لاستخداماتك الشخصية غير التجارية فقط إلا إذا وافقت منصة راديوز على خلاف ذلك في اتفاقية كتابية منفصلة معك. وتقر من جانبك بأن منصة راديوز لا تقدم أي خدمات أخرى وأن أي خدمات لاستخداماتك الشخصية غير التجارية تقدم بواسطة أفراد مستقلين لا يعملون لدى منصة راديوز.
الترخيص.
تمنحك منصة راديوز ، شريطة امتثالك بهذه الشروط، ترخيصاً محدوداً غير حصري لا يمكن ترخيصه من الباطن ولا يمكن نقله إلى شخص آخر وهو قابل للإلغاء، من أجل: (1) الوصول إلى التطبيقات واستخدامها على جهازك الشخصي فيما يتعلق باستخدامك للخدمات فقط؛ و(2) الوصول إلى أي من المحتويات والمعلومات والمواد ذات الصلة التي قد يتم توفيرها من خلال الخدمات واستخدامها، وفي جميع هذه الحالات يكون الاستخدام شخصي فقط وغير التجاري. وتحتفظ منصة راديوز والمرخصون التابعون لها بأي من الحقوق غير الممنوحة صراحة في هذه الشروط.
القيود.
لا يحق لك إجراء ما يلي: (1) إزالة أيٍ من حقوق الطبع والنشر أو العلامات التجارية أو غيرها من إشعارات الملكية من أي جزء من الخدمات؛ أو (2) استنساخ الخدمات أو تعديلها أو إعداد أعمال مشتقة منها أو توزيعها أو ترخيصها أو تأجيرها أو بيعها أو إعادة بيعها أو نقل ملكيتها أو عرضها علانية أو أدائها علانية أو بثها أو تعميمها أو نشرها أو استغلالها بأي شكل آخر باستثناء ما تسمح به منصة راديوز صراحة؛ أو (3) التلاعب بشفراتها أو عكس هندستها أو تفكيكها باستثناء ما تسمح به القوانين المطبقة؛ أو (4) إنشاء ارتباط لأي جزء من الخدمات أو إعداد نسخ مطابقة منها أو تأطيرها؛ أو (5) إنشاء أو التسبب في إنشاء أي برامج أو برامج نصية بغرض التخلص من أي جزء من الخدمات أو فهرسته أو مسحه أو استغلال بياناته بطريقة أخرى، أو إثقال أو إعاقة عمل و/أو وظيفة أي جانب من الخدمات على نحو غير ملائم؛ أو (6) محاولة الدخول بشكل غير مصرح به للخدمات أو إتلاف أي من جوانبها أو أي من الأنظمة والشبكات المتعلقة بها.
خدمات الأطراف الخارجية ومحتواها.
قد يتم توفير الخدمات أو إتاحة الوصول إليها بالاقتران بخدمات ومحتوى أطراف خارجية (بما في ذلك الإعلان) والتي لا تخضع لسيطرة منصة راديوز. وتقر بأنه قد تسري شروط استخدام وسياسات خصوصية مختلفة على استخدامك لخدمات ومحتوى الأطراف الخارجية. لا تُصادق منصة راديوز على خدمات ومحتوى الأطراف الخارجية ولا تتحمل بأي حال من الأحوال المسؤولية تجاه أي من منتجات أو خدمات مقدمي الخدمات الخارجيين. إضافة إلى ذلك، تعتبر شركة آبل أو شركة جوجل أو شركة مايكروسوفت أو شركاتهم التابعة والفرعية الدولية المعنية مستفيدين خارجيين لهذا العقد إذا قمت بالوصول إلى الخدمات باستخدام التطبيقات المصممة خصيصاً لأجهزة الجوال التي تعمل بنظام Apple iOS أو Android أو Microsoft Windows، على التوالي. ولا يعتبر هؤلاء المستفيدون الخارجيون أطرافًا في هذا العقد ولا يتحملون المسؤولية عن تقديم الخدمات أو دعمها بأي طريقة كانت. ويخضع وصولك إلى الخدمات باستخدام هذه الأجهزة إلى الشروط المنصوص عليها في شروط الخدمة المطبقة الخاصة بالمستفيد الخارجي.
الملكية.
تظل الخدمات وجميع الحقوق المتعلقة بها ملكية خاصة بشركة الفعاليات الاسطورية أو بمانحي التراخيص التابعين لها. ولا تمنحك هذه الشروط ولا استخدامك للخدمات أي حقوق: (1) في الخدمات أو فيما يتعلق بها بخلاف الترخيص المحدود الممنوح أعلاه؛ أو (2) لاستخدام أو الإشارة بأي طريقة إلى أسماء الشركات أو الشعارات أو أسماء المنتجات والخدمات أو العلامات التجارية أو علامات الخدمة الخاصة بشركة الفعاليات الاسطورية أو تلك الخاصة بالمرخصين التابعين لها.
3. استخدامك للخدمات
حسابات المستخدمين.
من أجل استخدام معظم جوانب الخدمات، يجب أن تقوم بالتسجيل من أجل الحصول على حساب شخصي فعّال لخدمات المستخدم والمحافظة عليه ("الحساب"). ويجب أن يكون عمرك 18 عاماً على الأقل أو تكون في سن الرشد القانوني في ولايتك القضائية (إن كان مختلفاً عن 18 عاماً) حتى يتسنى لك الحصول على حساب. ويتطلب تسجيل الحساب تقديم معلومات شخصية معينة إلى منصة راديوز كاسمك ورقم ورقم هويتك ورقم هاتفك الجوال وايميلك الشخصي، إضافة إلى طريقة دفع واحدة صحيحة على الأقل (إما بطاقة ائتمانية أو شريك دفع مقبول). وتوافق من جانبك على تدوين معلومات دقيقة وكاملة وحديثه في حسابك الخاص والمحافظة عليها. وقد يؤدي عدم محافظتك على وجود معلومات دقيقة وكاملة وحديثه في حسابك، بما في ذلك تعيين طريقة دفع غير صالحة أو منتهية الصلاحية، إلى عدم قدرتك على الوصول إلى الخدمات أو استخدامك لها أو إنهاء منصة راديوز لهذه الشروط معك. تتحمل أنت المسؤولية عن جميع الأنشطة التي تُجرى باسم حسابك، كما توافق على الحفاظ على أمان وسرية اسم المستخدم وكلمة المرور الخاصين بحسابك طوال الوقت. لا يحق لك امتلاك أكثر من حساب واحد ما لم تسمح لك منصة راديوز كتابةً بخلاف ذلك.
متطلبات المستخدم وسلوكه.
لا تتوفر الخدمة للاستخدام من قبل الأشخاص دون سن 18 عاماً. ولا يحق لك تفويض استخدام حسابك لأطراف خارجية، ولا يجوز لك التنازل عن حسابك أو نقل ملكيته إلى أي شخص أو كيان آخر. وتوافق من جانبك على الامتثال لجميع القوانين المعمول بها عند استخدام الخدمات ولا يجوز لك استخدامها إلا لأغراض قانونية (على سبيل المثال، عدم نقل مواد غير قانونية أو خطرة). ولا يجوز لك أن تتسبب، عند استخدامك للخدمات، في إلحاق أذى أو إزعاج أو مضايقة أو أضرار في الملكية إلى أي أطراف أخرى. وفي بعض الحالات، قد يُطلب منك تقديم إثبات شخصية للوصول إلى الخدمات أو استخدامها، وتوافق على أنه قد تُمنع من الوصول إلى الخدمات أو من استخدامها إذا ما رفضت تقديم إثبات الشخصية.
الرسائل النصية.
بمجرد إنشاء الحساب، فأنت توافق على أن الخدمات قد ترسل إليك بعض الرسائل النصية المعلوماتية كجزء من سياق الأعمال الطبيعي لاستخدامك للخدمات.
المحتوى المقدم من المستخدم.
يحق لمنصة راديوز ، وفق تقديرها المطلق، السماح لك بين الفينة والأخرى بتقديم أو تحميل أو نشر أو توفير بطريقة أخرى محتوى ومعلومات نصية و/أو سمعية و/أو بصرية إلى منصة راديوز من خلال الخدمات، بما في ذلك التعليقات والتعقيبات المتعلقة بالخدمات، وإنشاء طلبات الدعم، وتقديم المدخلات للمنافسات والعروض الترويجية ("محتوى المستخدم"). أي محتوى مُنشأ بواسطة المستخدم تقدمه أنت يبقى ملكية خاصة بك. ومع ذلك، فبمجرد تقديم المحتوى المنشأ بواسطة المستخدم إلى منصة راديوز ، فإنك تمنحها رخصة عالمية ودائمة وغير قابلة للإلغاء ولا يمكن نقل ملكيتها وخالية من الامتيازات، إلى جانب الحق في ترخيص محتوى المستخدم من الباطن، واستخدامه ونسخه وتعديله وإقامة أعمال مشتقة منه وتوزيعه وعرضه علانية وأدائه علانية واستغلاله بأي طريقة أخرى في جميع الأشكال وقنوات التوزيع المعروفة حالياً أو التي تُبتكر فيما بعد (بما في ذلك ما يتعلق بالخدمات والأعمال الخاصة بمنصة راديوز وكذلك المواقع والخدمات الخاصة بأطراف خارجية)، وذلك دون إرسال إخطارات إضافية لك أو الحصول على موافقة من جانبك ودون الحاجة إلى الدفع لك أو إلى أي شخص أو كيان آخر.
تتعهد من جانبك وتضمن ما يلي: (1) أنك إما المالك الحصري والوحيد لجميع محتوى المستخدم أو أنك تتمتع بجميع الحقوق وتمتلك جميع التراخيص والموافقات والإعفاءات الضرورية لمنح ترخيص إلى منصة راديوز باستخدام محتوى المستخدم على النحو المنصوص عليه أعلاه؛ و(2) ألا يتسبب محتوى المستخدم ولا تقديمك أو تحميلك أو نشرك لهذا المحتوى أو توفيره بأي شكل آخر ولا استخدام منصة راديوز لمحتوى المستخدم في انتهاك أو اختلاس أو مخالفة أي من حقوق الملكية الفكرية أو الحقوق الخاصة أو حقوق الطبع والنشر أو الخصوصية لطرف خارجي وألا يؤدي إلى الإخلال بأي من القوانين أو اللوائح المعمول بها. توافق من جانبك على عدم تقديم أي محتوى مستخدم تشهيري أو افترائي أو بغيض أو عنيف أو فاحش أو إباحي أو غير قانوني أو عدواني بأي شكل آخر، وذلك على النحو الذي تحدده منصة راديوز وفق تقديرها المطلق، سواءً كانت هذه المادة محمية بموجب القانون أم لا. ويجوز لمنصة راديوز مراجعة محتوى المستخدم أو مراقبته أو إزالته وفق تقديرها المطلق في أي وقت ولأي سبب كان دون إخطارك بذلك، ولكنها ليست ملزمة بذلك.
الوصول إلى الشبكة والأجهزة.
تتحمل أنت مسؤولية الحصول على البيانات الضرورية الخاصة بالوصول إلى الشبكة لاستخدام الخدمات. قد تطبق عليك أسعار ورسوم البيانات والرسائل التي تطبقها شبكة الجوال التي تشترك فيها وذلك إذا قمت بالوصول إلى الخدمات أو استخدمتها من جهاز يعمل لاسلكياً وتتحمل أنت مسؤولية هذه الأسعار والرسوم. وتتحمل أنت مسؤولية حيازة وتحديث المعدات أو الأجهزة المناسبة التي تكون ضرورية للوصول إلى الخدمات والتطبيقات وأي تحديثات خاصة بها واستخدامها. ولا تضمن منصة راديوز أن تعمل الخدمات، أو أي جزء منها، على أي معدات أو أجهزة معينة. إضافة إلى ذلك، قد تعاني الخدمات من الأعطال والتأخيرات المتأصلة في استخدام الإنترنت والاتصالات الإلكترونية.
4. الدفع
يتطلب استخدام التطبيق استخدام جهاز محمول وخدمة بيانات لاسلكية ومتنقلة، والتي يجب عليك الحصول عليها من مشغل شبكة الجوال، وقد تتطلب الوصول إلى الإنترنت. أنت مسئول عن الحصول على هذه الخدمات ودفع ثمنها، راديوز لن تكون مسئولة عن أي تكاليف أو رسوم يتكبدها أي مستخدم أو حتى من خلال استخدامك للتطبيق، بما في ذلك، على سبيل المثال لا الحصر، أي رسوم للناقل المحمول، أي رسالة نصية قصيرة، رسالة وسائط متعددة أو رسوم الرسائل النصية أو الوسائط المتعددة الأخرى، أو أي رسوم لمزود خدمة الدفع الإلكترونية.
باستخدامك تطبيق راديوز، فإنك توافق على تلقي الاتصالات الإلكترونية الخاصة بك من منصة راديوز، بما في ذلك، على سبيل المثال لا الحصر، الرسائل القصيرة ورسائل الوسائط المتعددة والرسائل النصية أو متعددة الوسائط الأخرى والبريد الإلكتروني وإرسال البيانات إلى الجهاز المحمول مثل رسالة أنه تم الدفع أو الإستلام في حالة الإسترداد. قد تتضمن هذه الاتصالات من منصة راديوز، على سبيل المثال لا الحصر، الرسائل الإدارية وإعلانات الخدمات وتقارير البيانات التشخيصية والتحديثات إلى التطبيق نفسه. كذلك أنت تقر بموافقتك على إرسال البيانات من راديوز، ومن وإلى جهازك المحمول، بما في ذلك التحديثات التلقائية إلى جهازك المحمول.
5. الحقوق الملكية
عندما تقوم بالوصول إلى أو تصفح أو استخدام أي من خدمات منصة راديوز التي تقبلها ، على سبيل المثال لا الحصر أو المؤهلات والشروط والأحكام الموضحة أدناه وأي شروط وأحكام إضافية الاستخدام المنصوص عليها في أي موقع فرعي. {""} المواد الموجودة على جميع التطبيقات والمواقع والخدمات التي تقدمها منصة راديوز. أنت غير مسموح لك أن تقوم بنقل أو بتنزيل أي مادة من هذه الخدمات والتطبيقات والمواقع الإلكترونية يرجى ملاحظة أنه عند دخولك إلى أي موقع فرعي يمكن الوصول إليه من خلال هذه الصفحة الرئيسية أو أي صفحة أخرى ، قد يكون لهذا الموقع الفرعي أحكام وشروط استخدام خاصة به ، خاصة بهذا الموقع الفرعي. يجب أن تحل اتفاقية عدم إفشاء ملزمة قانونًا بينك وبين منصة راديوز محل هذه الشروط وشروط الاستخدام إلى الحد الذي يقع فيه استخدامك لبوابات منصة راديوز الآمنة ضمن نطاق اتفاقية عدم الإفشاء هذه.
6. إخلاء المسؤولية؛ حدود المسؤولية؛ التعويض.
إخلاء المسؤولية.
تُقدَّم الخدمات "على حالتها" و"بحسب توافرها". تُخلي منصة راديوز مسؤوليتها عن جميع الإقرارات والتعهدات صريحة كانت أم ضمنية أم تشريعية والتي لم يُنص عليها صراحة في هذه الشروط بما فيها الإقرارات الضمنية الخاصة بقابلية التسويق والملائمة لغرض معين وعدم المخالفة. إضافة إلى ذلك، لا تقدم منصة راديوز أي إقرارات أو تعهدات أو ضمانات بخصوص موثوقية أو دقة مواعيد أو جودة أو ملائمة أو توافر الخدمات أو أي منها أو السلع المطلوبة أثناء استخدام هذه الخدمات أو بخصوص عدم انقطاع الخدمات أو خلوها من الأخطاء. ولا تضمن منصة راديوز جودة مقدمي الخدمات الخارجيين أو ملاءمتهم أو سلامتهم أو قدرتهم. توافق من جانبك على أن المخاطر الكاملة التي تنشأ عن استخدامك للخدمات أو أي من الخدمات أو السلع المطلوبة فيما يتعلق بهذا الاستخدام تبقى متعلقة بك وحدك إلى الحد الأقصى المسموح به بموجب القانون المعمول به.
حدود المسؤولية.
لن تكون منصة راديوز مسئولة عن الأضرار غير المباشرة أو العرضية أو الخاصة أو التحذيرية أو الجزائية أو التبعية بما فيها خسارة الأرباح أو فقدان البيانات أو الإصابة الشخصية أو الضرر اللاحق بالممتلكات المرتبط أو الناجم بأي صورة عن استخدام الخدمات حتى وإن أُبلغت منصة راديوز باحتمالية حدوث تلك الأضرار. ولن تكون منصة راديوز مسئولة عن أي أضرار أو مسؤوليات أو خسائر تنشأ عن: (1) استخدامك للخدمات أو اعتمادك عليها أو عدم قدرتك على الوصول إلى الخدمات أو استخدامها؛ أو (2) أي معاملة تجارية أو علاقة بينك وبين أي مقدم خدمات خارجي، حتى وإن تم إبلاغ منصة راديوز باحتمالية حدوث تلك الأضرار. ولن تكون منصة راديوز مسئولة عن التأخير أو الإخلال بالأداء الناشئ عن أسباب تقع خارج سيطرة منصة راديوز المعقولة.
يجوز لك استخدام خدمات منصة ‎راديوز لطلب وجدولة خدمات النقل أو تقديم السلع أو الخدمات اللوجستية بواسطة مقدمي خدمات خارجيين إلا أنك توافق على عدم تحمل منصة راديوز لأي مسؤولية أو التزام تجاهك بخصوص أي من خدمات النقل أو تقديم السلع أو الخدمات اللوجستية المقدمة لك بواسطة مقدمي الخدمات الخارجيين إلا ما نُصَّ عليه صراحة في هذه الشروط.
لا يفهم من بنود حدود المسؤولية وإخلاء المسؤولية الواردة في القسم 5 الحد من المسؤوليات أو تبديل حقوقك كعميل والتي لا يمكن استثناؤها بموجب القانون المعمول به.
التعويض.
توافق من جانبك على تعويض وإبراء ذمة منصة راديوز ومسئوليها ومديريها وموظفيها ووكلائها عن جميع المطالبات والمطالب والخسائر والمسؤوليات والنفقات (بما فيها أتعاب المحاماة) التي تنشأ عن أو فيما يتعلق بما يلي: (1) استخدامك للخدمات أو خدمات أو سلع تحصل عليها من خلال استخدام الخدمات؛ أو (2) خرقك أو انتهاكك لأي من هذه الشروط؛ أو (3) استخدام منصة راديوز لمحتوى المستخدم الخاص بك؛ أو (4) انتهاكك لحقوق أي من الأطراف الخارجية بمن فيهم مقدمي الخدمات الخارجيين

""";

  launchWhatsapp() async {
    var whatsappUrl = "https://wa.me/+923220232991";
    var whatsappAndroid = Uri.parse(whatsappUrl);

    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      AppUtils.showFlushBar("WhatsApp is not installed on the device", context);
    }
  }

  AppLifecycleState? _appLifecycleState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _appLifecycleState = state;
    });
    if (kDebugMode) {
      print("App Lifecycle State: $_appLifecycleState");
    }
  }

  double lat = 0.0;
  double lng = 0.0;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  bool _isEmailValid(String email) {
    // Basic email validation pattern
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

    // Checking if the email matches the basic pattern
    if (!emailRegex.hasMatch(email)) return false;

    // Specific domain validation for Outlook, Gmail, Yahoo, and Hotmail
    final specificDomainRegex = RegExp(r'@(outlook\.com|gmail\.com|yahoo\.com|hotmail\.com)$', caseSensitive: false);

    return specificDomainRegex.hasMatch(email);
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      //   permission = await Geolocator.requestPermission();
      AppUtils.showFlushBar(
          "Location permissions are permanently denied, Please accept the location permission from the settings ",
          context);
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position position = await Geolocator.getCurrentPosition();
    print("position.latitude ${position.latitude}");
    print("position.longitude ${position.longitude}");
    lat = position.latitude;
    lng = position.longitude;

    setState(() {});
    return await Geolocator.getCurrentPosition();
  }

  showLocationDailog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool res = prefs.getBool("isLocationDailog") ?? false;

    if (Platform.isAndroid) {
      if (res) {
        _determinePosition();
      } else {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showMyDialog(context);
        });
      }
    } else {
      _determinePosition();
    }
  }

  @override
  void initState() {
    _getDeviceInfo();

    showLocationDailog();
    // _passwordController.text = "123456789";
    // _emailController.text = "test18@gmail.com";
    // _emailController.text = "murad@epic-sa.com";
    // _passwordController.text = "murad@epic-sa.com";
    checkAppVersion();
    notificationServices.getToken().then((value) {
      print("device token $value");
      setState(() {
        deviceToken = value;
      });
    });
    // _determinePosition();

    loginCubit = BlocProvider.of<LoginCubit>(context);
    registerCubit = BlocProvider.of<RegisterCubit>(context);
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  _getDeviceInfo() async {
    final deviceInfo = await DeviceUtils.getDeviceIdentifier();
    deviceName = deviceInfo.$1;
    deviceId = deviceInfo.$2;
  }

  WebSocket? socket;

  Future websocket() async {
    final uri = Uri.parse('ws://192.168.0.100:4000/');
    const backoff = ConstantBackoff(Duration(seconds: 1));
    socket = WebSocket(uri, backoff: backoff);
    print("object1111 ${socket?.connection.state}");
    // Listen for changes in the connection state.

    socket?.connection.listen((state) {
      print(
        'state:11 "$state"',
      );

      if (state.toString() == "Instance of 'Connected'") {
        AppUtils.showFlushBar("Connected", context);

        socket?.send("aaaaaaaaaaaaaaaaaaaaaaaa");
        AppUtils.showFlushBar("Connected send", context);
        socket?.messages.listen((message) {
          print('message:11111122222 "$message"');
        });
      }
      if (state.toString() == "Instance of 'Reconnected'") {
        AppUtils.showFlushBar("Connected", context);

        socket?.send("Re aaaaaaaaaaaaaaaaaaaaaaaa");
        AppUtils.showFlushBar("ReConnected send", context);
        socket?.messages.listen((message) {
          print('message:11111122222 "$message"');
        });
      }
      if (state.toString() == "Instance of 'Disconnected'") {
        AppUtils.showFlushBar("Disconnected", context);
      }
    });
  }

  String? currentVersion = "";

  Future<void> checkAppVersion() async {
    // Get the current installed app version
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;

    print("Current app version is: $currentVersion");

    // Here you can add logic to compare this version with the one fetched from the Play Store
  }

  var mobileController = TextEditingController();
  var whatsappController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.backgroundColor,
      bottomNavigationBar: BottomAppBar(
        height: (!isLogin) ? SizeConfig.height(context, 0.00) : SizeConfig.height(context, 0.1),
        color: GlobalColors.backgroundColor,
        elevation: 0,
        child: Center(
          child: (isLogin)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _emailController.clear();
                          _passwordController.clear();
                          isLogin = false;
                        });
                      },
                      child: RichText(
                          text: TextSpan(
                        //style: DefaultTextStyle.of(context).style,
                        children: [
                          TextSpan(
                            text: "Don't_have_an_account?".tr(),
                            style: TextStyle(
                                fontSize: SizeConfig.width(context, 0.04),
                                color: GlobalColors.forgetTextColor,
                                fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: 'Signup_here'.tr(),
                            style: TextStyle(
                              color: GlobalColors.signupTextColor,
                              fontSize: SizeConfig.width(context, 0.04),
                            ),
                          ),
                        ],
                      )),
                    ),
                    Text(
                      "${"App Version".tr()}  $currentVersion",
                      style: TextStyle(color: Colors.white, fontSize: SizeConfig.width(context, 0.03)),
                    )
                  ],
                )
              : Container(),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        //  backgroundColor: GlobalColors.backgroundColor,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          !isLogin ? "Register".tr() : "Login".tr(),
          //  !isLogin ? "Register".tr() : "$lat \n $lng".tr(),
          style: TextStyle(
            fontSize: SizeConfig.width(context, 0.05),
            color: GlobalColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: SizeConfig.width(context, 0.05),
              left: SizeConfig.width(context, 0.05),
            ),
            child: IconButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return AlertDialog(
                            backgroundColor: GlobalColors.backgroundColor,
                            title: Center(
                                child: Text(
                              'Change Language'.tr(),
                              style: TextStyle(color: Colors.white),
                            )),
                            content: SizedBox(
                              height: SizeConfig.height(context, 0.15),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        prefs.setBool("isEnglish", true);
                                        await (context.setLocale(Locale('en')));

                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('English')),
                                  ElevatedButton(
                                    onPressed: () async {
                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                      prefs.setBool("isEnglish", false);
                                      await (context.setLocale(Locale('ar')));
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('عربي'),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                      });
                  // makePhoneCall();
                },
                icon: Icon(
                  Icons.language,
                  size: SizeConfig.width(context, 0.1),
                  color: Colors.white,
                )
                /*Image.asset(
                  "assets/icons/whatsapp_icon.png",
                  width: SizeConfig.width(context, 0.1),
                )*/
                ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.height(context, 0.05),
              bottom: SizeConfig.height(context, 0.05),
              left: SizeConfig.width(context, 0.19),
              right: SizeConfig.width(context, 0.19),
            ),
            child: Image.asset("assets/icons/logo_with_name.png", width: SizeConfig.width(context, 0.3)),
          ),
          (isLogin) ? buildLoginWidget(context) : buildRegisterWidget(context),
          //  buildLoginWidget(context),
        ],
      ),
    );
  }

  Widget buildRegisterWidget(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: regFormKey,
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  var rng = new Random();
                  var code = rng.nextInt(900000) + 100000;
                  image = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  print("vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv ${image?.path}");
                  if (!mounted) return;
                  imagePath = image?.path ?? "";

                  final bytes = await image?.readAsBytes();
                  final kb = bytes?.length ?? 0 / 1024;
                  final mb = kb / 1024;
                  print("original image size ${mb.toString()}");
                  final dir = await path_provider.getTemporaryDirectory();
                  final targetPath = "${dir.absolute.path}/temp$code.jpg";
                  final result = await FlutterImageCompress.compressAndGetFile(image!.path, targetPath,
                      minHeight: 1080, minWidth: 1080, quality: 70);
                  final data = await result!.readAsBytes();
                  final newkb = data.length / 1024;
                  final newMb = newkb / 1024;

                  setState(() {
                    newImage = File(result.path);
                  });
                  print("new image size ${newMb.toString()}   ${newImage?.path}");
                },
                child: (imagePath?.isNotEmpty ?? false)
                    ? CircleAvatar(
                        backgroundImage: FileImage(
                          File(
                            newImage?.path ?? "",
                          ),
                        ),
                        radius: SizeConfig.width(context, 0.15),
                      )
                    : CircleAvatar(
                        backgroundImage: AssetImage("assets/icons/download.png"),
                        radius: SizeConfig.width(context, 0.15),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            //                  backgroundColor: Colors.red,
                            radius: SizeConfig.width(context, 0.05),
                            backgroundImage: AssetImage("assets/icons/edit_icon.png"),
                          ),
                        )),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                controller: nameController,
                hintText: 'Name'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_Enter_Name'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                controller: _regEmailController,
                hintText: 'Email_Address'.tr(),
                isPassword: false,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please_Enter_Email_Address'.tr();
                  }
                  if (!_isEmailValid(value)) {
                    return 'Please_enter_a_valid_emailfromOutlook,Gmail,Yahoo,or_Hotmail'.tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Material(
                color: Colors.transparent,
                shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                child: DropdownButtonFormField<String>(
                  dropdownColor: GlobalColors.backgroundColor,
                  padding: EdgeInsets.only(
                    left: SizeConfig.width(context, 0.07),
                    right: SizeConfig.width(context, 0.07),
                  ),
                  items: genderList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item ?? "",
                        style: TextStyle(color: GlobalColors.textFieldHintColor),
                      ),
                    );
                  }).toList(),
                  value: gender,
                  onChanged: (value) {
                    setState(() => gender = value);
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'Gender'.tr(),
                    hintStyle: TextStyle(
                      color: GlobalColors.textFieldHintColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow
                          //    color: GlobalColors.ftsTextColor,
                          ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        //    color: GlobalColors.ftsTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'Please_select_a_Gender'.tr();
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Material(
                // elevation: 10.0,

                color: Colors.transparent,
                shadowColor: const Color(0xff006DFC).withOpacity(0.16),
                child: DropdownButtonFormField<String>(
                  dropdownColor: GlobalColors.backgroundColor,
                  padding:
                      EdgeInsets.only(left: SizeConfig.width(context, 0.07), right: SizeConfig.width(context, 0.07)),
                  items: cityList.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item ?? "",
                        style: TextStyle(color: GlobalColors.textFieldHintColor),
                      ),
                    );
                  }).toList(),
                  value: city,
                  onChanged: (value) {
                    setState(() => city = value);
                  },
                  decoration: InputDecoration(
                    filled: false,
                    hintText: 'City'.tr(),
                    hintStyle: TextStyle(
                      color: GlobalColors.textFieldHintColor,
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.yellow
                          //    color: GlobalColors.ftsTextColor,
                          ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        //    color: GlobalColors.ftsTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.03),
                      ),
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null) {
                      return 'Please_select_city'.tr();
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                isPassword: true,
                controller: _regPasswordController,
                hintText: 'Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Password_Can't_be_Empty".tr();
                  }
                  if (value.length < 8) {
                    return "Password should be greater than 8".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                textInputType: TextInputType.number,
                isPassword: false,
                controller: _idNumberController,
                hintText: 'Id_Number'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Id_Number_Can't_be_Empty".tr();
                  }
                  if (value.length != 10) {
                    return "Id_Number_length".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              /*   Padding(
                padding: EdgeInsets.only(
                    //  top: SizeConfig.height(context, 0.05),
                    //bottom: SizeConfig.height(context, 0.05),
                    left: SizeConfig.width(context, 0.07),
                    right: SizeConfig.width(context, 0.07)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: SizeConfig.width(context, 0.70),
                      height: SizeConfig.width(context, 0.17),
                      child: RadiusTextField(
                        leftPadding: 0,
                        rightPadding: 0,
                        onTap: () {
                          //      FocusScope.of(context).requestFocus(new FocusNode()); // Hide keyboard
                          LogManager.info("kjsdfsdkfnsdnkfnsdknfksdnkfnsdkf");
                          _selectDate(false);
                        },
                        readOnly: false,
                        isPassword: false,
                        controller: _iqamaExpiryController,
                        hintText: 'Iqama_Expiry'.tr(),
                        validator: (String? value) {
                          */ /*  if (value == null || value.isEmpty) {
                            return "Expiry Date Can't be Empty";
                          }*/ /*

                          return null;
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        LogManager.info("kjsdfsdkfnsdnkfnsdknfksdnkfnsdkf");
                        _selectDate(false);
                      },
                      child: Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.grey,
                        size: SizeConfig.width(context, 0.08),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: SizeConfig.width(context, 0.70),
                      height: SizeConfig.width(context, 0.17),
                      child: RadiusTextField(
                        leftPadding: 0,
                        rightPadding: 0,
                        readOnly: false,
                        isPassword: false,
                        controller: _ageController,
                        hintText: 'Date_of_Birth'.tr(),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Date_Can't_be_Empty".tr();
                          }

                          return null;
                        },
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        LogManager.info("kjsdfsdkfnsdnkfnsdknfksdnkfnsdkf");
                        _selectDate(true);
                      },
                      child: Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.grey,
                        size: SizeConfig.width(context, 0.08),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),*/
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: Text(
                  "Please_STCPAY".tr(),
                  style: TextStyle(color: GlobalColors.submitButtonColor, fontSize: SizeConfig.width(context, 0.03)),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: IntlPhoneField(
                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  showDropdownIcon: false,
                  showCountryFlag: false,
                  controller: mobileController,
                  dropdownTextStyle: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                  ),
                  decoration: InputDecoration(
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        // width: SizeConfig.width(context, 0.005),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    hintText: "STCPAY Number".tr(),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: GlobalColors.textFieldHintColor,
                    ),
                  ),
                  style: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                    //    GlobalColors.textFieldHintColor,
                    //     fontSize: SizeConfig.width(context, 0.04),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    // height: 0.09,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    countryCode = phone.countryCode;
                    phoneNumber = phone.completeNumber;
                    LogManager.info('phoneNumber = $phoneNumber');
                    // print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    countryCode = country.code;
                    mobileController.clear();
                  },
                  validator: (PhoneNumber? value) {
                    if (value == null || value.number.isEmpty) {
                      return 'STCPAY_is_required'.tr();
                    }

                    return null;
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: IntlPhoneField(
                  keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                  //       countries: [Country(name: "Saudia", flag: "flag", code: "+966", dialCode: "+966", nameTranslations: nameTranslations,)],
                  controller: whatsappController,
                  //   disableAutoFillHints: true,
                  //      dropdownDecoration: BoxDecoration(color: GlobalColors.backgroundColor),
                  dropdownTextStyle: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                  ),
                  decoration: InputDecoration(
                    //  enabled: false,
                    //  counterStyle: TextStyle(color: Colors.white),
                    filled: false,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                        // width: SizeConfig.width(context, 0.005),
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: GlobalColors.hintTextColor,
                      ),
                      borderRadius: BorderRadius.circular(
                        SizeConfig.width(context, 0.02),
                      ),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    hintText: "Whatsapp_Number".tr(),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: GlobalColors.textFieldHintColor,
                    ),
                  ),
                  style: TextStyle(
                    color: GlobalColors.textFieldHintColor,
                    //    GlobalColors.textFieldHintColor,
                    //     fontSize: SizeConfig.width(context, 0.04),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    // height: 0.09,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  initialCountryCode: 'SA',
                  onChanged: (phone) {
                    whatsappcountryCode = phone.countryCode;
                    whatsappphoneNumber = phone.completeNumber;
                    LogManager.info('phoneNumber = $phoneNumber');
                    // print(phone.completeNumber);
                  },
                  onCountryChanged: (country) {
                    whatsappcountryCode = country.code;
                    whatsappController.clear();
                  },
                  validator: (PhoneNumber? value) {
                    if (value == null || value.number.isEmpty) {
                      return 'Whatsapp_number_is_required'.tr();
                    }

                    return null;
                  },
                ),
              ),
              buildCheckBoxWidget(
                  context: context,
                  checkValue: isChecker ?? false,
                  title: "I_am_accepting_the".tr(),
                  onChange: (bool? value) {
                    setState(() {
                      isChecker = value;
                    });
                  }),
              SizedBox(
                height: SizeConfig.height(context, 0.04),
              ),
              SubmitButton(
                onPressed: () async {
                  print("whatsapp number $whatsappcountryCode ${whatsappController.text}");
                  if (isChecker ?? false) {
                    if (imagePath?.isNotEmpty ?? false) {
                      if (regFormKey.currentState!.validate()) {
                        RegisterPayload register = RegisterPayload(
                          name: nameController.text.trim(),
                          email: _regEmailController.text.trim(),
                          password: _regPasswordController.text.trim(),

                          city: city,
                          gender: gender,
                          countryPhonecode: countryCode,
                          mobile: mobileController.text.trim(),
                          whatsappCountryCode: whatsappcountryCode,
                          whatsappNumber: whatsappController.text.trim(),
                          //   age: _ageController.text,
                          //dateOfBirth: _ageController.text,
                          dateOfBirth: "16-05-1998",
                          age: "16-05-1998",
                          iqamaExpiry: "17-06-2050",
                          // iqamaExpiry: _iqamaExpiryController.text,
                          iqamaId: _idNumberController.text.trim(),
                          deviceToken: deviceToken,
                          deviceName: deviceName,
                          deviceId: deviceId,
                        );

                        registerCubit.register(registerPayload: register, documentPath: newImage?.path);
                      }
                    } else {
                      AppUtils.showFlushBar(
                        "Please_Select_an_image".tr(),
                        context,
                      );
                    }
                  } else {
                    AppUtils.showFlushBar(
                      "Terms_and_Condition".tr(),
                      context,
                    );
                  }
                },
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return LoadingWidget();
                    }
                    return Text(
                      'Signup'.tr(),
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(context, 0.04),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                  listener: (context, state) async {
                    if (state is RegisterSuccess) {
                      setState(() {
                        _cityController.clear();
                        _regEmailController.clear();
                        _regPasswordController.clear();
                        nameController.clear();
                        image = null;
                        imagePath = null;
                        isChecker = false;
                        gender = null;
                        city = null;
                        countryCode = "";
                        mobileController.clear();
                        _ageController.clear();

                        _iqamaExpiryController.clear();
                        _idNumberController.clear();
                      });

                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isVerified", state.register.isVerified ?? false);

                      // await Navigator.pushNamed(context, AppRoutes.editProfileScreenRoute,
                      //     arguments: EditProfileScreenArgs(
                      //         isFromLogin: true, phoneCode: state.register.countryPhonecode ?? "+966"));

                      setState(() {
                        isLogin = true;
                      });
                      AppUtils.showFlushBar("Please_login_now".tr(), context);
                    }
                    if (state is RegisterFailure) {
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _cityController.clear();
                    _regEmailController.clear();
                    _regPasswordController.clear();
                    nameController.clear();
                    gender = null;
                    city = null;
                    imagePath = null;
                    isChecker = false;
                    image = null;
                    countryCode = "";
                    mobileController.clear();
                    _ageController.clear();

                    _iqamaExpiryController.clear();
                    _idNumberController.clear();
                    isLogin = true;
                  });
                },
                child: RichText(
                  text: TextSpan(
                    //style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "Have_an_account?".tr(),
                        style: TextStyle(
                            fontSize: SizeConfig.width(context, 0.04),
                            color: GlobalColors.forgetTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                      TextSpan(
                        text: 'Login_here'.tr(),
                        style: TextStyle(
                          color: GlobalColors.signupTextColor,
                          fontSize: SizeConfig.width(context, 0.04),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.03),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLoginWidget(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: loginFormKey,
          child: Column(
            children: [
              isLoginWithMobile
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: SizeConfig.width(context, 0.07),
                        right: SizeConfig.width(context, 0.07),
                      ),
                      child: IntlPhoneField(
                        keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                        showDropdownIcon: false,
                        showCountryFlag: false,
                        controller: _loginMobileController,
                        dropdownTextStyle: TextStyle(
                          color: GlobalColors.textFieldHintColor,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: false,
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: 20),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.hintTextColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizeConfig.width(context, 0.02),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.hintTextColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizeConfig.width(context, 0.02),
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.hintTextColor,
                              // width: SizeConfig.width(context, 0.005),
                            ),
                            borderRadius: BorderRadius.circular(
                              SizeConfig.width(context, 0.02),
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.hintTextColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizeConfig.width(context, 0.02),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: GlobalColors.hintTextColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              SizeConfig.width(context, 0.02),
                            ),
                          ),
                          hintText: "Mobile_Number".tr(),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: GlobalColors.textFieldHintColor,
                          ),
                        ),
                        style: TextStyle(
                          color: GlobalColors.textFieldHintColor,
                          //    GlobalColors.textFieldHintColor,
                          //     fontSize: SizeConfig.width(context, 0.04),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          // height: 0.09,
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        initialCountryCode: 'SA',
                        onChanged: (phone) {
                          loginCountryCode = phone.countryCode;
                          loginPhoneNumber = phone.completeNumber;
                          LogManager.info('phoneNumber = $phoneNumber');
                          // print(phone.completeNumber);
                        },
                        onCountryChanged: (country) {
                          loginCountryCode = country.code;
                          _loginMobileController.clear();
                        },
                        validator: (PhoneNumber? value) {
                          if (value == null || value.number.isEmpty) {
                            return 'Mobile_number_is_required'.tr();
                          }

                          return null;
                        },
                      ),
                    )
                  : RadiusTextField(
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      hintText: 'Email_Address'.tr(),
                      validator: (String? value) {
                        if (value == null || value.isEmpty || !EmailValidator.validate(value)) {
                          return 'Please_Enter_Valid_Email_Address'.tr();
                        }
                        return null;
                      },
                    ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.width(context, 0.07),
                  right: SizeConfig.width(context, 0.07),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoginWithMobile = !isLoginWithMobile;
                        });
                        //Navigator.pushNamed(context, AppRoutes.forgotScreenRoute);
                      },
                      child: Text(
                        isLoginWithMobile ? "Login with email".tr() : "Login with mobile".tr(),
                        textAlign: TextAlign.right,
                        style: TextStyle(fontWeight: FontWeight.w500, color: GlobalColors.forgetPasswordColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.02),
              ),
              RadiusTextField(
                isPassword: true,
                controller: _passwordController,
                hintText: 'Password'.tr(),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Password_Can't_be_Empty".tr();
                  }
                  return null;
                },
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.04),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.forgotScreenRoute);
                  },
                  child: Text(
                    "Forgot_Password".tr(),
                    style: TextStyle(fontWeight: FontWeight.w500, color: GlobalColors.forgetPasswordColor),
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.height(context, 0.04),
              ),
              SubmitButton(
                onPressed: () async {
                  if (kDebugMode) {
                    print("device token on login button $deviceToken");
                  }
                  if (loginFormKey.currentState!.validate()) {
                    PermissionStatus permissionStatus = await location.hasPermission();
                    print("permission status ${permissionStatus.name}");

                    if (permissionStatus.name != "granted") {
                      // Request the permission
                      if (Platform.isAndroid) {
                        Map<ph.Permission, ph.PermissionStatus> statuses = await [
                          ph.Permission.location,
                        ].request();

                        if (statuses[ph.Permission.location]!.isGranted) {
                          loginCubit.login(
                              lat: "$lat",
                              lng: "$lng",
                              isLoginWithMobile: isLoginWithMobile,
                              countryCode: loginCountryCode,
                              password: _passwordController.text.trim(),
                              deviceToken: deviceToken,
                              email: (isLoginWithMobile)
                                  ? _loginMobileController.text.trim()
                                  : _emailController.text.trim());
                          // Permission is granted, proceed with the location related task
                          print("Location permission granted.");
                        } else {
                          _determinePosition();
                          // Permission denied, handle accordingly
                          print("Location permission denied.");
                        }
                      } else {
                        var location = Location();
                        bool serviceEnabled = await location.serviceEnabled();
                        print("sddddddd $serviceEnabled");
                        await location.requestService();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            // Handle if the user denies turning on the location service.
                            return;
                          }
                        }
                      }
                    } else {
                      loginCubit.login(
                          lat: "$lat",
                          lng: "$lng",
                          isLoginWithMobile: isLoginWithMobile,
                          countryCode: loginCountryCode,
                          password: _passwordController.text.trim(),
                          deviceToken: deviceToken,
                          deviceId: deviceId,
                          deviceName: deviceName,
                          email:
                              (isLoginWithMobile) ? _loginMobileController.text.trim() : _emailController.text.trim());
                      // Permission is already granted or not needed, proceed with the location related task
                      print("Location permission already granted.");
                    }
                  }
                },
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) async {
                    if (state is LoginSuccess) {
                      /* if (state.loginModel.whatsappNumber != null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool("isProfileUpdated", true);
                      }*/
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.setBool("isVerified", state.loginModel.isVerified ?? false);

                      // prefs.setBool("isProfileUpdated", true);

                      if (state.loginModel.isVerified!) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) =>
                                  splashScreen(isProfile: state.loginModel.whatsappNumber != null ? false : true)),
                          (Route<dynamic> route) => false,
                        );
                      } else {
                        Navigator.pushNamed(context, AppRoutes.editProfileScreenRoute,
                            arguments: EditProfileScreenArgs(
                                isFromLogin: true, phoneCode: state.loginModel.countryPhonecode ?? "+966"));
                      }

                      /*  if (state.loginModel.whatsappNumber != null) {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setBool("isProfileUpdated", true);
                        print(
                            "login role name ${state.loginModel.role?.displayName}");
                        if (state.loginModel.role?.displayName == "Usher") {
                          print(
                              "inside if condition login ${state.loginModel.role?.displayName}");
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.pagesScreenRoute, (route) => false,
                              arguments: 0);
                        } else {
                          print(
                              "inside else condition login ${state.loginModel.role?.displayName}");
                          Navigator.pushNamedAndRemoveUntil(context,
                              AppRoutes.pagesScreenRoute, (route) => false,
                              arguments: 5);
                        }
                      }
                      else {
                        Navigator.pushNamed(
                            context, AppRoutes.editProfileScreenRoute,
                            arguments: EditProfileScreenArgs(
                                isFromLogin: true, phoneCode: "+92"));
                      }*/
                    }
                    if (state is LoginFailed) {
                      if (kDebugMode) {
                        print("state is Login");
                      }
                      AppUtils.showFlushBar(state.errorMessage, context);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoginLoading) {
                      return const LoadingWidget();
                    }
                    return Text(
                      'Login'.tr(),
                      style: TextStyle(
                        color: GlobalColors.submitButtonTextColor,
                        fontSize: SizeConfig.width(
                          context,
                          0.04,
                        ),
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckBoxWidget(
      {required BuildContext context,
      required String title,
      required bool checkValue,
      required void Function(bool?) onChange}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width(context, 0.07)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: "Noto Sans",
                    color: GlobalColors.hintTextColor,
                    fontSize: SizeConfig.width(context, 0.03),
                    fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: () {
                  _showTermsDialog(context);
                },
                child: Text(
                  "Terms_and_Condition".tr(),
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                      fontFamily: "Noto Sans",
                      color: GlobalColors.hintTextColor,
                      fontSize: SizeConfig.width(context, 0.025),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Checkbox(
              side: const BorderSide(color: Colors.grey),
              checkColor: Colors.black,
              fillColor: MaterialStateProperty.all<Color>(Colors.white),
              value: checkValue,
              onChanged: onChange),
        ],
      ),
    );
  }

  void _showTermsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GlobalColors.backgroundColor,
          title: Text(
            'شروط واحكام',
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white, fontSize: SizeConfig.width(context, 0.05)),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  termsAndConditionsText,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: SizeConfig.width(context, 0.03),
                  ),
                ),
                // Add more text here to elaborate on your terms and conditions
              ],
            ),
          ),
          actions: <Widget>[
            /*    TextButton(
              child: Text('Disagree'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),*/
            TextButton(
              child: Text('Agree'.tr()),
              onPressed: () {
                // Code to execute when the user agrees with terms and conditions
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> makePhoneCall() async {
    const phoneNumber = '1234567890'; // Specify the phone number here
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _selectDate(bool? isDateOfBirth) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isDateOfBirth ?? false) ? DateTime(1980) : DateTime.now(),
      firstDate: (isDateOfBirth ?? false) ? DateTime(1980) : DateTime.now(),
      lastDate: (isDateOfBirth ?? false) ? DateTime.now() : DateTime(3000),
      barrierDismissible: false,
    );

    if (picked != null) {
      int pickedYear = picked.year;
      int currentYear = DateTime.now().year;
      int difference = currentYear - pickedYear;
      LogManager.info("pickedYear $pickedYear");
      LogManager.info("currentYear $currentYear");
      LogManager.info("difference $difference");
      LogManager.info("difference ${difference >= 18}");
      //  if (difference >= 18) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      print("formattedDate $formattedDate");
      if (isDateOfBirth ?? false) {
        setState(() {
          _ageController.text = formattedDate;
          print("_ageController ${_ageController.text}");
        });
      } else {
        setState(() {
          _iqamaExpiryController.text = formattedDate;
        });
      }
      //} else {
      /*ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please Select valid Date")));
     */ //}
    }
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: GlobalColors.backgroundColor,
          title: Text(
            'Location Permission Needed'.tr(),
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Radius app collects location data to know your location.'.tr(),
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Your location will be used to identify whether you are on duty or offline even when the app is closed or not in use.'
                      .tr(),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Decline',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Allow',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                if (mounted) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setBool("isLocationDailog", true);
                }
                Navigator.of(context).pop();
                _determinePosition();
              },
            ),
          ],
        );
      },
    );
  }
}