
import 'package:aqua/variables.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:fluent_ui/fluent_ui.dart';

class HoverOutlineButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  HoverOutlineButton({required this.text, required this.onPressed});

  @override
  _HoverOutlineButtonState createState() => _HoverOutlineButtonState();
}

class _HoverOutlineButtonState extends State<HoverOutlineButton> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isHovered ? Colors.blue : Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Button(
          style: ButtonStyle(
            padding: ButtonState.all(const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0)),
            backgroundColor: ButtonState.all(Colors.transparent),
          ),
          onPressed: widget.onPressed,
          child: Text(
            widget.text,
            style: TextStyle(
              color: isHovered ? Colors.white : Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}

Widget mycontainer(Widget child,double height){
  return Container(
    height: height,
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
    child: child,
  );
}


Widget Customtext(String text, Color color){
  return Text(text,
  style: TextStyle(
    color: color,
    fontWeight: FontWeight.bold,


    letterSpacing: 2
  ),);
}

Widget Note(String text) {
  return EasyRichText(
    text,
    patternList: [
      // Bold for headings starting with ## and centering them
      EasyRichTextPattern(
        targetString: r'## (.*?)\n',
        matchBuilder: (BuildContext context, RegExpMatch? match) {
          return WidgetSpan(
            child: Center(
              child: Text(
                match?[0]?.replaceAll('## ', '').trim() ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          );
        },
      ),
      // Bold for emphasized phrases surrounded by **
      EasyRichTextPattern(
        targetString: r'\*\*(.*?)\*\*',
        matchBuilder: (BuildContext context, RegExpMatch? match) {
          return TextSpan(
            text: match?[0]?.replaceAll('**', ''),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    ],
  );
}


Widget chartContainer(Widget child){
  return Container(
    padding: const EdgeInsets.all(8),
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
    child: child,
  );

}


class Changing_text extends StatefulWidget {
  final value;
  const Changing_text({Key? key, ValueNotifier? this.value} ) : super(key: key);


  @override
  State<Changing_text> createState() => _Changing_textState();
}

class _Changing_textState extends State<Changing_text> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: widget.value,
        builder: (BuildContext context, val,_){
      return Customtext(val.toString(), Colors.black);
        });
  }
}


Widget TabButton(int pos, String text){


  return ValueListenableBuilder(valueListenable: tabs, builder: (BuildContext context,value,_){
    return Button(onPressed: (){
      tabnumber.value=pos;
      List p=[];
      int ct=0;
      if(value.isNotEmpty){
        for(var x in value){
          if(ct==pos){
            p.add(1);

          }else{
            p.add(0);
          }
          ct++;

        }
        tabs.value=p;
      }
    },
    style: ButtonStyle(
      backgroundColor: value[pos]==1?ButtonState.all(Colors.blue):ButtonState.all(Colors.transparent)
    ),child: Customtext(text, value[pos]==1?Colors.white:Colors.black),);
  });
}