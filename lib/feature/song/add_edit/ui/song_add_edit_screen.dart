import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/ui/song_add_edit_form.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';
import 'package:flutter_bloc_lyrics/widgets/loading.dart';

class SongAddScreen extends StatefulWidget {
  final SongBase song;

  SongAddScreen({@required this.song});

  @override
  State<StatefulWidget> createState() => SongAddScreenState(
        song: song,
      );
}

class SongAddScreenState extends State<StatefulWidget> {
  final SongBase song;

  SongAddScreenState({@required this.song});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(song?.id == null ? "Add song" : "Edit song"),
        ),
        body: BlocBuilder(
            bloc: BlocProvider.of<SongAddEditBloc>(context),
            builder: (BuildContext context, SongAddEditState state) {
              return Stack(
                children: <Widget>[
                  Container(
                    child: SongAddForm(song: song),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Visibility(
                        child: BaseLoadingView(),
                        visible: state is StateLoading,
                      ))
                ],
              );
            }));
  }
}
