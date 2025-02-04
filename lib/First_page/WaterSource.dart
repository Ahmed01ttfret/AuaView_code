import 'package:aqua/Custom_widget.dart';
import 'package:aqua/imported_data_info/imported_data_info.dart';
import 'package:aqua/variables.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:simple_toast_message/simple_toast.dart';

class Watersource extends StatefulWidget {
  const Watersource({Key? key}) : super(key: key);

  @override
  State<Watersource> createState() => _WatersourceState();
}

class _WatersourceState extends State<Watersource> {
  var controller = OverlayPortalController();
  var control = OverlayPortalController();
  TextEditingController text_control=TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<Widget> overlay=[];
    for(String source in industrialWaterSources){

      overlay.add(HoverOutlineButton(text: source,
          onPressed: (){
            controller.hide();
            input_info['Source']=source;
            Navigator.pop(context);

          }));
      overlay.add(const SizedBox(height: 10,));

    }

    List<Widget> col=[
      HoverOutlineButton(text: 'Drinking water', onPressed: (){
        Navigator.pop(context);
        input_info['Source']='Drinking Water';
      }),
      const SizedBox(height: 10,),

      OutlinedButton(onPressed: controller.toggle,
        focusable: true,
        child: OverlayPortal(controller: controller,
          overlayChildBuilder: (BuildContext context){
        return Padding(
          padding: const EdgeInsets.only(top: 40,bottom: 40),
          child: Center(

              child: Container(
                width: 400,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),


                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue, // Shadow color
                      blurRadius: 5.0, // Adjust blur radius
                      offset: const Offset(2.0, 4.0), // Shadow offset
                    ),
                  ],
                ),



            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: overlay,
              ),
            ),
          )),
        );
          },
      child: Customtext("Industrial Effluent", Colors.black),
      ),


      ),
      const SizedBox(height: 10,),
      HoverOutlineButton(text: 'Stream', onPressed: (){
        input_info['Source']='Stream';
        Navigator.pop(context);
      }),
      const SizedBox(height: 10,),
      HoverOutlineButton(text: 'Wastewater', onPressed: (){
        input_info['Source']='Wastewater';
        Navigator.pop(context);

      }),
      const SizedBox(height: 10,),
      OutlinedButton(onPressed: control.toggle,

          child: OverlayPortal(controller:control,
          child: Customtext('Custom', Colors.black),
          overlayChildBuilder: (context){
        return Center(
          child: Container(

            width: 300,
            height: 300,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),


              boxShadow: [
                BoxShadow(
                  color: Colors.blue, // Shadow color
                  blurRadius: 5.0, // Adjust blur radius
                  offset: const Offset(2.0, 4.0), // Shadow offset
                ),
              ],
            ),


            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 10,),
                  TextBox(
                    placeholder: 'Type Here',
                    controller: text_control,

                  ),
                  const SizedBox(height: 10,),
                  HoverOutlineButton(text: 'Proceed', onPressed: (){

                    if(text_control.text.isNotEmpty) {
                      control.hide();
                      input_info['Source'] = text_control.text;
                      Navigator.pop(context);
                    }else{
                      SimpleToast.showErrorToast(context, "Input Error", "Water Source is required");

                    }
                  })
                ],
              ),
            ),
          ),
        );
          }))

    ];


    return ListView(
      shrinkWrap: true,
      children: col,

    );
  }
}
