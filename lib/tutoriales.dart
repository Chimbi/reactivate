import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactivate/models/channel_model.dart';
import 'package:reactivate/models/video_model.dart';
import 'package:reactivate/services/api_service.dart';
import 'package:reactivate/video_screen.dart';

class Tutoriales extends StatefulWidget {
  @override
  _TutorialesState createState() => _TutorialesState();
}

class _TutorialesState extends State<Tutoriales> {

  Channel _channel;
  bool _isLoading = false;


  final List<String> playlist = <String>[
    'https://www.youtube.com/watch?v=fq4N0hgOWzU',
    'https://youtu.be/IVTjpW3W33s',
  ];
  int currentPos;
  String stateText;

  @override
  void initState() {
    _initChannel();
    super.initState();
  }

  _initChannel() async {
    Channel channel = await APIService.instance.fetchChannel(
      channelId: 'UC_TkYuvKYbnkYAx31oIIN2w');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} suscriptores',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    print("Prueba error: ${_channel.videos.toString()}");
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _channel != null
        ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
      if (!_isLoading &&
          _channel.videos.length != int.parse(_channel.videoCount) &&
          scrollDetails.metrics.pixels ==
              scrollDetails.metrics.maxScrollExtent) {
        _loadMoreVideos();
      }
      return false;
    },
        child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0) {
                return _buildProfileInfo();
              } else {
                print("Prueba error: ${_channel.videos.toString()}");
                Video video = _channel.videos[index - 1];
                return _buildVideo(video);
              }
              },
        childCount: 1 + _channel.videos.length))
        ],
      )
    ) : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, // Red
          ),
        ),
      ),
    );
  }
}
