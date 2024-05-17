import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tctt_mobile/shared/utils/file.dart';
import 'package:tctt_mobile/widgets/loader.dart';

class InternetImgDisplayer extends StatefulWidget {
  const InternetImgDisplayer(this.url, {super.key});

  final String url;

  @override
  State<InternetImgDisplayer> createState() => _InternetImgDisplayerState();
}

class _InternetImgDisplayerState extends State<InternetImgDisplayer> {
  final _storage = const FlutterSecureStorage();

  String? _token;

  @override
  void initState() {
    super.initState();

    _readToken();
  }

  void _readToken() async {
    final token = await _storage.read(key: 'access_token');
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _token != null
        ? Image.network(
            headers: {"cookie": "token=$_token"},
            '${dotenv.env['BASE_API_URL']}/${widget.url}',
            errorBuilder: (context, error, stackTrace) =>
                const Center(child: Text('Đã xảy ra lỗi')),
            fit: BoxFit.cover,
          )
        : const Loader();
  }
}

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.url, required this.onDownload});

  final void Function() onDownload;

  final String url;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(children: [
        Container(
          width: screenSize.width * 0.8,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            bottom: 10,
            top: 40,
          ),
          child: InternetImgDisplayer(url),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              FileHelper.getFileNameFromUrl(url),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDownload();
              },
              icon: const Icon(
                Icons.download,
                size: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ],
        )
      ]),
    );
  }
}
