import 'package:built_collection/built_collection.dart';
import 'package:datn/ui/profile/reservation_detail/reservation_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../domain/model/reservation.dart';
import '../../../domain/model/ticket.dart';
import '../../app_scaffold.dart';
import '../../home/checkout/widgets/header.dart';

class ReservationListItem extends StatelessWidget {
  final Reservation item;
  final DateFormat dateFormat;
  final NumberFormat currencyFormat;

  const ReservationListItem(
      {Key key, this.item, this.dateFormat, this.currencyFormat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showTime = item.showTime;
    final promotion = item.promotion;

    final textTheme = Theme.of(context).textTheme;
    final textStyle = textTheme.subtitle1.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: const Color(0xff98A8BA),
    );

    final textStyle2 = textTheme.subtitle1.copyWith(
      fontSize: 14,
      color: const Color(0xff687189),
      fontWeight: FontWeight.w600,
    );

    return InkWell(
      onTap: () => AppScaffold.of(context).pushNamed(
        ReservationDetailPage.routeName,
        arguments: item,
      ),
      child: HeaderWidget(
        movie: showTime.movie,
        showTime: showTime,
        theatre: showTime.theatre,
        tickets: item.tickets ?? BuiltList.of(<Ticket>[]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            const SizedBox(height: 4),
            if (promotion != null) ...[
              RichText(
                text: TextSpan(
                  text: 'Coupon code: ',
                  style: textStyle,
                  children: [
                    TextSpan(
                      text: promotion.code.length > 24
                          ? promotion.code.substring(0, 24) + '...'
                          : promotion.code,
                      style: textStyle2,
                    ),
                  ],
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  text: 'Discount: ',
                  style: textStyle,
                  children: [
                    TextSpan(
                      text: '${(promotion.discount * 100).toInt()} %',
                      style: textStyle2,
                    ),
                  ],
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 8),
            ],
            RichText(
              text: TextSpan(
                text: 'Original price: ',
                style: textStyle,
                children: [
                  TextSpan(
                    text: currencyFormat.format(item.originalPrice) + ' VND',
                    style: textStyle2,
                  ),
                ],
              ),
              maxLines: 1,
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Total price: ',
                style: textStyle,
                children: [
                  TextSpan(
                    text: currencyFormat.format(item.totalPrice) + ' VND',
                    style: textStyle2,
                  ),
                ],
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}