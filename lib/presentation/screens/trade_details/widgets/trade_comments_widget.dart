import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_take/bloc/helpers/bloc_getter.dart';
import 'package:share_take/bloc/helpers/request_status.dart';
import 'package:share_take/bloc/trade_comments/trade_comments_bloc.dart';
import 'package:share_take/constants/enums.dart';
import 'package:share_take/constants/static_styles.dart';
import 'package:share_take/constants/theme/theme_colors.dart';
import 'package:share_take/data/models/comment/book_trade_comment_remote.dart';
import 'package:share_take/data/models/trade/book_trade_local.dart';
import 'package:share_take/presentation/widgets/centered_loader.dart';
import 'package:share_take/presentation/widgets/proxy/spacing/proxy_spacing_widget.dart';
import 'package:share_take/presentation/widgets/proxy/text/proxy_text_widget.dart';
import 'package:share_take/presentation/widgets/utilities/static_widgets.dart';
import 'package:share_take/utilities/static_utilities.dart';

class TradeCommentsWidget extends StatelessWidget {
  final BookTradeLocal bookTrade;

  const TradeCommentsWidget({Key? key, required this.bookTrade}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocGetter.getTradeCommentsBloc(context).add(TradeCommentsGetEvent(tradeId: bookTrade.id));
    String message = "";

    return BlocConsumer<TradeCommentsBloc, TradeCommentsState>(
      listener: (context, state) {
        if (state.status is RequestStatusError) {
          message = (state.status as RequestStatusError).message;
        }
      },
      builder: (context, state) {
        RequestStatus requestStatus = state.status;
        List<BookTradeCommentModel> comments = state.commentList;

        return CenteredLoader(
          isLoading: requestStatus is RequestStatusLoading,
          child: _buildCommentsView(context, comments, message),
        );
      },
    );
  }

  Widget _buildCommentsView(BuildContext context, List<BookTradeCommentModel> comments, String message) {
    return ListView(
      padding: StaticStyles.listViewPadding,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ProxyTextWidget(text: "Comments", fontWeight: ProxyFontWeight.bold,),
            InkWell(
              onTap: () {
                BlocGetter.getTradeCommentsBloc(context).add(TradeCommentsGetEvent(tradeId: bookTrade.id));
              },
              child: Icon(Icons.refresh, size: 30,),
            ),
          ],
        ),
        ProxySpacingVerticalWidget(size: ProxySpacing.large,),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: comments.length,
          itemBuilder: (context, index) {
            BookTradeCommentModel comment = comments[index];
            return CustomListItem(
              title: comment.authorName,
              text: comment.text,
              subText: StaticUtilities.formatDateDetailed(comment.date),
              comment: comment,
            );
          },
        ),
        comments.isEmpty ? ProxyTextWidget(text: "No comments found") : SizedBox.shrink(),
        ProxyTextWidget(text: message),
        ProxySpacingVerticalWidget(
          size: ProxySpacing.extraLarge,
        ),
      ],
    );
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({
    Key? key,
    required this.title,
    required this.text,
    required this.subText,
    required this.comment,
  }) : super(key: key);

  final String title;
  final String text;
  final String subText;
  final BookTradeCommentModel comment;

  @override
  Widget build(BuildContext context) {
    bool yourComment = BlocGetter.getAuthBloc(context).state.user != null;
    if (yourComment) {
      yourComment = comment.authorId == BlocGetter.getAuthBloc(context).state.user!.id;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(Icons.person, color: yourComment ? ThemeColors.orange : null,),
          ),
          Expanded(
            flex: 3,
            child: _Description(
              title: yourComment ? title + " (you)" : title,
              text: text,
              subText: subText,
            ),
          ),
          yourComment
              ? InkWell(
                  child: Icon(Icons.highlight_remove),
                  onTap: () {
                    StaticWidgets.confirmationDialog(
                      context: context,
                      text: "Delete comment?",
                      actionYes: () {
                        BlocGetter.getTradeCommentsBloc(context).add(
                          TradeCommentsDeleteEvent(
                            comment: comment,
                          ),
                        );
                      },
                    );
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.title,
    required this.text,
    required this.subText,
  }) : super(key: key);

  final String title;
  final String text;
  final String subText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
          Text(
            "Date: " + subText,
            style: const TextStyle(fontSize: 10.0),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          ProxyTextWidget(
            fontStyle: FontStyle.italic,
            text: text,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
        ],
      ),
    );
  }
}
