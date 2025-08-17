import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/extensions/route_aware_refetch_mixin.dart';
import 'package:migla_flutter/src/models/api/api_model_abstract.dart';
import 'package:migla_flutter/src/widgets/list/info_empty_list.dart';
import 'package:migla_flutter/src/widgets/list_view_widgets/graphql/graphql_error_view.dart';
import 'package:migla_flutter/src/widgets/list_view_widgets/list_view_general.dart';

class GraphqlListViewGeneral<T extends ApiModel> extends StatefulWidget {
  final QueryOptions options;
  final String? emptyListTitle;
  final String dataKey;
  final int? itemCount;
  final List<T>? items;
  final T Function(Map<String, dynamic> json) fromJson;
  final Widget Function(BuildContext context, int index)? separatorBuilder;
  final Widget Function(BuildContext context, int index, List<T> items)
      itemBuilder;

  const GraphqlListViewGeneral({
    super.key,
    required this.options,
    this.emptyListTitle,
    required this.dataKey,
    required this.itemBuilder,
    this.itemCount,
    this.separatorBuilder,
    required this.fromJson,
    this.items,
  });

  @override
  State<GraphqlListViewGeneral<T>> createState() => _GraphqlListViewState<T>();
}

class _GraphqlListViewState<T extends ApiModel>
    extends State<GraphqlListViewGeneral<T>> with RouteAwareRefetchMixin {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Query(
            options: widget.options,
            builder: (result, {fetchMore, refetch}) {
              setRefetchFunction(refetch);

              final List<T> items = widget.items ??
                  result.data?[widget.dataKey]['docs']
                      .map<T>((e) => widget.fromJson(e))
                      .toList() ??
                  [];
              if (result.hasException) {
                return GraphqlErrorView(result: result, refetch: refetch);
              }
              if (result.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (items.isEmpty) {
                return InfoEmptyList(
                  title: widget.emptyListTitle ?? context.t.noDataFound,
                  onRefresh: refetch,
                );
              }
              return ListViewGeneral<T>(
                items: items,
                itemCount: widget.itemCount ?? items.length,
                refetch: refetch,
                separatorBuilder: widget.separatorBuilder,
                itemBuilder: (context, index) {
                  return widget.itemBuilder(context, index, items);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
