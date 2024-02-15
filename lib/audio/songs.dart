const List<Song> songs = [
  Song('save_the_ocean.mp3', 'Save the ocean'),
];

class Song {
  final String filename;

  final String name;

  const Song(this.filename, this.name);

  @override
  String toString() => 'Song<$filename>';
}
