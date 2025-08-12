import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/placeholder_images.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/report/report_model.dart';
import 'package:migla_flutter/src/models/api/report/report_query.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/utils/date_time/format_date_time.dart';
import 'package:migla_flutter/src/widgets/list/gallery_grid/gallery_grid.dart';
import 'package:migla_flutter/src/widgets/list/gallery_grid/tappable_image.dart';
import 'package:migla_flutter/src/widgets/media_preview/media_preview.dart';
import 'package:migla_flutter/src/widgets/media_preview/media_preview_fullscreen.dart';
import 'package:migla_flutter/src/widgets/row_avatar_with_title.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:nb_utils/nb_utils.dart';

List<Map<String, dynamic>> teacherReportList = [
  {
    "author": "先生",
    "subtitle": "先生からの通信 1",
    "title": "子どもたちは 日本の文化や世界について楽しく学んでいます！ 🌏✨",
    "description": '''📚 今週のレギュラークラス：「世界の国々について学ぼう！」 🌍
今週のテーマ：海外の国々について知ろう！

子どもたちは **世界のいろいろな国** について学びました。今回は **フランス・エジプト・ブラジル** に注目！

🌍 学んだこと  
✅ フランス 🇫🇷：エッフェル塔とおいしいパン「バゲット」  
✅ エジプト 🇪🇬：ピラミッドとスフィンクスのふしぎ  
✅ ブラジル 🇧🇷：カーニバルとサッカーの人気  

みんなで **国旗を描いたり、有名な建物の絵を見たり、音楽を聴いたり** しながら、楽しく世界を探検しました！🌏✨

🎤 子どもたちの感想  
👦「エッフェル塔っておおきいんだね！のぼってみたい！」  
👧「ピラミッドはどうやってつくったの？ふしぎ～！」  
🎨「カーニバルのかめんをつくるのが楽しかった！」  

**世界にはまだまだたくさんの国があるので、これからもいっしょに学んでいきます！** ✈️✨  

---

📢 来週の予告！  
🌸 **日本のお祭り体験：夏祭りごっこ！** 🏮  
🎶 **世界の音楽を楽しもう！** 🎼  

また来週のブログをお楽しみに！✨''',
    "date": "2025/03/02",
    "coverImage": mockImgKyubi,
    "gallery": [
      "assets/images/mock_images/field.jpeg",
      "assets/images/mock_images/house.jpeg",
      "assets/images/mock_images/salone.jpeg",
    ],
  },
  {
    "author": "先生",
    "subtitle": "先生からの通信",
    "title": "先生からの通信",

    // create article in japanese
    "description": '''
📌 週刊ブログ イタリアの日本語幼稚園 🌸

⏳ 週末学校の活動レポート！
毎週末、子どもたちは **日本の文化や世界について楽しく学んでいます！** 🌏✨

---

🍵 先週の特別イベント：茶道体験 🌿
📅 先週末、子どもたちは「茶道」を体験しました！

日本の伝統文化のひとつである茶道（さどう）は、**おもてなしの心**や**感謝の気持ち**を大切にする素敵な時間です。

🌿 今回の学びポイント
✅ **おじぎ** の意味と正しい作法を学ぶ  
✅ お茶の飲み方と **抹茶（まっちゃ）** の味わいを体験  
✅ **「いただきます」** の心を持つ大切さ  

和菓子（わがし）をいただきながら、**茶道の所作の美しさ**や**ゆっくりとした時間の大切さ**を感じてもらいました。

🎤 子どもたちの感想  
👧「抹茶はちょっとにがかったけど、お菓子といっしょに食べるとおいしかった！」  
👦「おじぎをするのがむずかしかったけど、日本の文化を知るのは楽しい！」  

日本の伝統を学びながら、みんなで楽しい時間を過ごしました。🌸✨  
''',
    "date": "2025/03/02",
    "coverImage": mockImgHouse,
    "gallery": [
      "assets/images/mock_images/field.jpeg",
      "assets/images/mock_images/house.jpeg",
      "assets/images/mock_images/salone.jpeg",
    ],
  },
  {
    "author": "先生",
    "subtitle": "先生からの通信 2",
    "title": "春の音楽祭を開催しました！🎵",
    "description": '''
🎵 春の特別イベント：みんなの音楽祭 🎹

今週は、子どもたちと一緒に **春の音楽祭** を開催しました！歌やダンス、楽器演奏を通じて、素晴らしい思い出を作ることができました。

🌸 イベントの内容  
✅ 日本の童謡メドレー演奏  
✅ リズム遊びとダンスタイム  
✅ 手作り楽器での演奏会  

子どもたちは **自分で作った楽器** を使って演奏したり、グループで **合唱** したりと、音楽の楽しさを存分に体験しました！

👥 活動の様子  
🎵 「さくらさくら」の合唱  
🥁 手作りタンバリンでのリズム遊び  
💃 みんなで踊る「うれしいひなまつり」  

🎤 子どもたちの感想  
👧「みんなで歌うのって楽しいね！」  
👦「自分で作った楽器で演奏できてうれしかった！」  
👧「来年もやりたい！」  

音楽を通じて、子どもたちの表現力や協調性が育まれる素敵な機会となりました。🎵✨

---

📢 来月の予定  
🎨 **春の自然観察と写生大会**  
🌱 **野菜の種まき体験**  

引き続き、楽しい活動を計画していきます！''',
    "date": "2025/03/09",
    "coverImage": mockImgSalone,
    "gallery": [
      "assets/images/mock_images/field.jpeg",
      "assets/images/mock_images/house.jpeg",
      "assets/images/mock_images/salone.jpeg",
    ],
  },
  {
    "author": "先生",
    "subtitle": "先生からの通信 3",
    "title": "みんなで楽しむ！春の料理教室 🍱",
    "description": '''
👩‍🍳 今週の特別活動：お子様料理教室 🍳

今週は、子どもたちと一緒に **春の料理教室** を開催しました！日本の家庭料理を通じて、食育と文化理解を深める素敵な時間となりました。

🔰 今回のメニュー  
✅ おにぎり作り（具材：梅・鮭・昆布）  
✅ たまごやき  
✅ 野菜スティック  

活動を通じて学んだこと：
- **手洗いの大切さ**
- **道具の安全な使い方**
- **「いただきます」「ごちそうさま」** の意味
- **協力して作業することの楽しさ**

👥 子どもたちの活躍  
🍙 上手におにぎりを握れるようになりました  
🥚 たまごを優しく割る練習  
🥕 野菜を洗って切る準備のお手伝い  

🎤 参加した子どもたちの感想  
👧「自分で作ったおにぎりはとってもおいしかった！」  
👦「お料理って楽しいね！おうちでもやってみたい！」  
👧「お友だちと一緒に作るのが楽しかった！」  

料理を通じて、食の大切さと日本の食文化について楽しく学ぶことができました。🍱✨

---

📢 来週の予告  
🌺 **春の自然観察ウォーク**  
🎨 **季節の壁面制作**  

楽しい活動の様子を、また来週お伝えします！''',
    "date": "2025/03/16",
    "coverImage": mockImgSky,
    "gallery": [
      "assets/images/mock_images/field.jpeg",
      "assets/images/mock_images/house.jpeg",
      "assets/images/mock_images/salone.jpeg",
    ],
  },
];

class TeacherReportDetailScreen extends StatelessWidget {
  final int id;
  const TeacherReportDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final locale = $settingsController(context).locale;
    final meViewModel = $meViewModel(context, listen: false);
    final userId = meViewModel.me?.id;

    return Query(
      options: QueryOptions(
        document: gql(reportById),
        variables: {
          'id': id,
          'locale': locale.languageCode,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        final rawReport = result.data?['Report'];

        final report = ReportDetailModel.tryFromJson(rawReport);

        return RegularLayoutScaffold(
          bgCircleBottomRightColor: colorTertiary.withAlpha(50),
          bgCircleTopLeftColor: colorTertiary.withAlpha(100),
          backgroundColor: colorPrimary,
          bodyColor: Colors.transparent,
          // bodyGradient: LinearGradient(
          //   colors: [colorPrimary, colorWhite],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
          title: report != null
              ? formatDateTime(report.createdAt)
              : 'Report not found',
          padding: EdgeInsets.symmetric(horizontal: 24),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: report == null
                  ? Text('Report not found')
                  : result.hasException
                      ? Text(result.exception?.graphqlErrors.toString() ??
                          'error occurred')
                      : Column(
                          spacing: 8,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 16,
                              children: [
                                0.height,
                                RowAvatarWithTitle(
                                  text: report.teacher.name,
                                ),
                                if (report.coverImage?.url != null)
                                  TappableImage(
                                    imagePath: report.coverImage!.url,
                                    tag: "coverImage",
                                    // images: data["gallery"],
                                    height: 200,
                                  ),
                                Text(report.title, style: textStyleTitleLg),
                              ],
                            ),
                            Text(report.body, style: textStyleBodyMedium),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  formatDateTime(report.createdAt,
                                      localeCode: $settingsController(context)
                                          .locale
                                          .languageCode),
                                  style: textStyleHeadingMedium,
                                ),
                              ],
                            ),
                            if (report.attachments.isNotEmpty) ...[
                              Divider(
                                color: colorTertiary,
                                thickness: 3,
                              ),
                              Text(context.t.attachments,
                                  style: textStyleHeadingMedium),
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  // alignment: WrapAlignment.center,
                                  children: [
                                    ...report.attachments.map(
                                      (media) => GestureDetector(
                                        onTap: () => MediaPreviewFullscreen(
                                          media: media,
                                          backgroundColor: colorPrimaryDark,
                                        ).launch(context),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: AbsorbPointer(
                                            absorbing: true,
                                            child: SizedBox(
                                                height: 80,
                                                width: 80,
                                                child: MediaPreview(
                                                  media: media,
                                                  backgroundColor: colorPrimary,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                            40.height,
                            // GalleryGrid(
                            //   images: report["attachments"]
                            //       .map<String>((e) => e["url"])
                            //       .toList(),
                            //   columns: 3,
                            // )
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }
}

// await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
// );
