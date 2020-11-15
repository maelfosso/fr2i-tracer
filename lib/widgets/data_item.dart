import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tracer/models/models.dart';
import 'package:tracer/screens/keys.dart';

class DataItem extends StatelessWidget {
  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Data data;

  DataItem({
    Key key,
    @required this.onDismissed,
    @required this.onTap,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ArchSampleKeys.dataItem(data.id.toString()),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Hero(
          tag: '${data.id}__heroTag',
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              data.name ?? "",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ),
        subtitle: Text(
          data.sex ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
