



import 'package:aqua/Custom_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Linc extends StatefulWidget {
  const Linc({Key? key}) : super(key: key);

  @override
  State<Linc> createState() => _LincState();
}

class _LincState extends State<Linc> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      header: Container(color: Colors.blue,child: PageHeader(
        title: Customtext('Terms And License', Colors.white),
        leading: IconButton(icon: const Icon(FluentIcons.back,color: Colors.white,size: 30,), onPressed: (){
          Navigator.pop(context);
        }),
      ),


      ),
      content: Container(color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(child: SingleChildScrollView(child: Note(aquaViewLicense )),),
      ),),
    );
  }
}














const aquaViewLicense = '''
## AquaView - License  

AquaView is an **educational tool** designed to simplify water quality analysis and promote sustainable solutions. This application is provided as open-source software under the **MIT License**, encouraging learning, research, and innovation in environmental data analysis.  

**License Type**  

AquaView is licensed under the **MIT License**, allowing users to freely use, modify, and distribute the software while adhering to the following terms.  

**Permissions & Restrictions**  

✅ **Permitted Uses**  
- Free use, modification, and distribution of the software.  
- Personal, academic, and commercial use.  
- Integration with other projects for educational and research purposes.  

❌ **Restricted Uses**  
- Selling the software as a standalone product without modifications.  
- Using the software for misleading or unauthorized commercial purposes.  
- Removing or altering copyright and attribution notices.  

**Liability Disclaimer**  

AquaView is provided **"as-is"** without any warranties, express or implied. The developer is not responsible for:  
- Any incorrect interpretations of water quality data.  
- Any damages, losses, or legal consequences arising from the use of this software.  
- Any errors, bugs, or service interruptions.  

Users assume full responsibility for their use of AquaView. This software should not be used as a substitute for professional water quality assessments.  

**Attribution & Copyright**  

AquaView is an original project developed by **Ahmed Mohammed**.  
Copyright **© 2025 AquaView**.  
This software may include third-party libraries licensed under their respective terms.  

**Contact Information**  

For licensing inquiries, support, or collaboration opportunities, feel free to reach out:  

📧 **Email:** [am7727339@gmail.com](mailto:am7727339@gmail.com)  

Thank you for using AquaView and contributing to the mission of making water quality analysis more accessible and impactful for everyone.  
''';








