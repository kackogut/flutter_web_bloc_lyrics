import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lyrics/feature/song/add_edit/bloc/song_add_edit.dart';
import 'package:flutter_bloc_lyrics/model/song_base.dart';
import 'package:flutter_bloc_lyrics/resources/langs/strings.dart';
import 'package:flutter_bloc_lyrics/widgets/buttons.dart';

class SongAddForm extends StatefulWidget {
  final SongBase song;

  SongAddForm({this.song});

  @override
  State<StatefulWidget> createState() {
    return SongAddState(song);
  }
}

class SongAddState extends State<SongAddForm> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _lyrics;
  String _artist;
  String _title;

  SongAddEditBloc _songAddEditBloc;

  final SongBase _song;

  SongAddState(this._song);

  @override
  void initState() {
    super.initState();
    _songAddEditBloc = BlocProvider.of<SongAddEditBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SongAddEditBloc, SongAddEditState>(
        bloc: _songAddEditBloc,
        listener: (context, state) {
          if (state is AddSongStateSuccess || state is EditSongStateSuccess) {
            Navigator.pop(context);
          }
        },
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: _song != null ? _song.title : "",
                      decoration: InputDecoration(hintText: "Title"),
                      onSaved: (value) => _title = value,
                      validator: (val) {
                        return val.trim().isEmpty ? "Empty title" : null;
                      },
                    ),
                    TextFormField(
                      initialValue: _song != null ? _song.artist : "",
                      decoration: InputDecoration(hintText: "Artist"),
                      onSaved: (value) => _artist = value,
                      validator: (val) {
                        return val.trim().isEmpty ? "Empty title" : null;
                      },
                    ),
                    TextFormField(
                      initialValue: _song != null ? _song.lyrics : "",
                      decoration: InputDecoration(hintText: "Lyrics"),
                      onSaved: (value) => _lyrics = value,
                      validator: (val) {
                        return val.trim().isEmpty ? "Empty title" : null;
                      },
                      minLines: 5,
                      maxLines: 20,
                    ),
                    Spacer(),
                    Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: getBaseButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                SongBase updatedSong = SongBase(
                                    id: _song == null ? null : _song.id,
                                    title: _title,
                                    lyrics: _lyrics,
                                    artist: _artist);
                                _songAddEditBloc.add(_song == null
                                    ? AddSong(song: updatedSong)
                                    : EditSong(song: updatedSong));
                              }
                            },
                            text: _song != null ? "Edit" : "Add song"))
                  ],
                ))));
  }
}
