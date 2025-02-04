
import 'package:aqua/Custom_widget.dart';
import 'package:fluent_ui/fluent_ui.dart';
class Aboutpage extends StatefulWidget {
  const Aboutpage({Key? key}) : super(key: key);

  @override
  State<Aboutpage> createState() => _AboutpageState();
}

class _AboutpageState extends State<Aboutpage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,
      header: Container(
        color: Colors.blue,
          child: PageHeader(
            title: Customtext('About', Colors.white),
            leading: IconButton(icon: const Icon(FluentIcons.back,size: 30,color: Colors.white,), onPressed: (){
              Navigator.pop(context);
            }),
          ),

      ),
      content: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(child: Note(aquaViewNote)),
        ),
      ),
    );
  }
}





const aquaViewNote = '''
## AquaView - About  

**Welcome to AquaView**, an educational tool developed with the vision of simplifying water quality analysis and inspiring sustainable solutions. AquaView represents my passion as an aspiring environmental engineer, driven to tackle real-world challenges through innovative approaches. This application is not just a tool—it’s a step toward making water quality data more accessible and actionable for everyone.  

## Key Features  

1. **Seamless File Uploads**: AquaView supports uploading datasets in **CSV** and **XLSX** formats, ensuring compatibility with standard tools and making it easy for you to start analyzing your data without any hurdles.  

2. **Missing Value Detection**: Clean data is essential for accurate analysis. AquaView helps you quickly detect and address missing values, ensuring your data is ready for meaningful insights.  

3. **Visualize Your Data**:  
   - Generate **density plots** and **histograms** to easily explore data distribution and uncover hidden trends.  
   - Perform **time series analyses** to study patterns over time, providing insights into long-term trends and anomalies.  

4. **Understand Correlations**: Dive into the relationships between variables through robust correlation analysis, helping you identify significant patterns in your data.  

5. **Water Quality Index (WQI)**: Calculate and interpret the WQI effortlessly to assess the overall quality of water samples and understand their suitability for different uses.  

6. **Gemini AI Integration**: AquaView is enhanced with **Gemini AI**, a powerful analysis module designed to provide predictive insights and advanced interpretations of your water quality data.  

7. **Interactive Q&A**: Engage with your data in a conversational way by asking questions directly within the app, allowing for a dynamic and intuitive learning experience.  

## My Vision for AquaView  

AquaView is more than an app—it’s part of my journey to become a highly skilled environmental engineer. By creating this tool, I aim to simplify the complex process of water quality analysis while making it accessible to anyone who needs it, whether for education, research, or practical decision-making.  

This project reflects my dedication to solving real-world problems in water management, a critical area for environmental sustainability and public health. AquaView is built with the goal of empowering users to make informed decisions and address water quality challenges effectively.  

## An Invitation to Collaborate  

I believe innovation thrives on collaboration. AquaView is an educational tool, and I welcome your **feedback, suggestions, and support** to improve it further. If you have ideas or insights on how to make water quality analysis even easier and more impactful, don’t hesitate to reach out. Together, we can create solutions that make a difference, one step at a time.  

Thank you for supporting this initiative and being part of the journey to make water quality analysis accessible and impactful for everyone. Let’s work together to shape a better future for our environment and communities.
''';
