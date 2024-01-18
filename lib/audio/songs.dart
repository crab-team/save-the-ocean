const List<Song> songs = [
  Song('musica_copada.mp3', 'Nombre copado'),
];

class Song {
  final String filename;

  final String name;

  const Song(this.filename, this.name);

  @override
  String toString() => 'Song<$filename>';
}
