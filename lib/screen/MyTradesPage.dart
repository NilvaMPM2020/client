import 'package:asoude/bloc/TradeBloc.dart';
import 'package:asoude/constants/colors.dart';
import 'package:asoude/model/TradeResponseEntity.dart';
import 'package:asoude/utils/Utils.dart';
import 'package:asoude/widget/APICallError.dart';
import 'package:asoude/widget/APICallLoading.dart';
import 'package:asoude/widget/TradeWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyTradesPage extends StatefulWidget {
  @override
  _MyTradesPageState createState() => _MyTradesPageState();
}

class _MyTradesPageState extends State<MyTradesPage> {
  TradeBloc _bloc = TradeBloc();

  @override
  void initState() {
    _bloc.add(GetTradeList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<TradeBloc, TradeState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is GetTradesListLoaded)
                return _tradesListWidget(state.result);
              else if (state is GetTradeListLoading)
                return APICallLoading();
              else
                return APICallError();
            }));
  }

  _tradesListWidget(List<TradeResponseEntity> trades) {
    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (context, index) {
        if (trades[index].service == null)
          return Container();
        return TradeWidget(
          avatar: trades[index].service?.avatar,
          fullName: trades[index].parties[0].name,
          tradeName: trades[index].service?.name,
          tradeDesc: trades[index].service?.description,
          tradePrice: trades[index].steps[0].gotStock,
          date: normalizeDateAndTime(trades[index].steps[0].createdDate),
          tradesCount: 54,
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
