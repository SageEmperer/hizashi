import 'package:flutter/material.dart';
import 'package:hizashi/constants/novel_sources.dart';
import 'package:hizashi/models/source/source.dart';

class SourceNovelScreen extends StatefulWidget {
  final String sourceId;
  const SourceNovelScreen({super.key, required this.sourceId});

  @override
  State<SourceNovelScreen> createState() => _SourceNovelScreenState();
}

class _SourceNovelScreenState extends State<SourceNovelScreen> {

  late final SourceModel? sourceInfo;


  @override
  void initState() {
    super.initState();
    print("Source Id: ${widget.sourceId}");
    sourceInfo = NovelSourcesConstants.getSourceFromString(widget.sourceId);
    print("Source Info: ${sourceInfo?.sourceName}");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Source Novels - ${sourceInfo?.sourceName}"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Source Novels"),
        ),
      ),
    );
  }
}