import 'package:flutter/material.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_pointed_container.dart';
import 'package:metaltrade/features/chat/ui/widgets/text_chat_card.dart';

import 'chat_with_image.dart';
import 'enquiry_card.dart';
import 'quote_card.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({super.key, required this.content, required this.isMyChat});
  final Content content;
  final bool isMyChat;

  @override
  Widget build(BuildContext context) {
    return content.body!.chatMessageType == "Enquiry"
        ? ChatPointedContainer(
            isMyChat: isMyChat,
            color: isMyChat
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.onSecondary,
            child: EnquiryCard(content: content))
        : content.body!.chatMessageType == "Quote"
            ? ChatPointedContainer(
                isMyChat: isMyChat,
                color: isMyChat
                    ? Theme.of(context).colorScheme.tertiaryContainer
                    : Theme.of(context).colorScheme.onSecondary,
                child: QuoteCard(content: content))
            : content.body!.chatMessageType == "Text"
                ? ChatPointedContainer(
                    isMyChat: isMyChat,
                    color: isMyChat
                        ? Theme.of(context).colorScheme.tertiaryContainer
                        : Theme.of(context).colorScheme.onSecondary,
                    child: TextChatCard(content: content),
                  )
                : content.body!.chatMessageType == "Attachment"
                    ? ChatPointedContainer(
                        isMyChat: isMyChat,
                        child: ChatWithImage(content: content),
                      )
                    : const SizedBox();
    // child: CustomPaint(
    //   painter: ChatContainer(),
    //   size: Size(MediaQuery.of(context).size.width,
    //       MediaQuery.of(context).size.height),
    // ));
  }
}

// class ChatContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Colors.black;
//     paint.style = PaintingStyle.stroke;
//     paint.strokeWidth = 10;

//     canvas.drawLine(
//         Offset(size.width / 4, 0), Offset(size.width / 1.3, 0), paint);

//     canvas.drawArc(
//         Rect.fromPoints(
//             Offset(size.width / 1.3, 0), Offset(size.width / 1, 50)),
//         //Rect.fromCircle(center: Offset(size.width / 1.3, 60), radius: 30),
//         math.pi / 2,
//         math.pi / 4,
//         false,
//         paint);

//     // canvas.drawRRect(
//     //     RRect.fromRectXY(
//     //         Rect.fromPoints(
//     //             Offset(size.width / 1.3, 0), Offset(size.width / 1.2, 60)),
//     //         10,
//     //         10),
//     //     paint);

//     //canvas.drawArc(
//     // Rect.fromCenter(
//     //   center: Offset(size.width / 1.3, 0),
//     //   height: 100,
//     //   width: 100,
//     // ),
//     //   40,
//     //   90,
//     //   false,
//     //   paint,
//     // );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
