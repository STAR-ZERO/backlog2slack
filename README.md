# Backlog2Slack

[Backlog](http://www.backlog.jp/) 課題の作成・更新を [Slack](https://slack.com/) へ通知する。

---

![Screenshot](https://raw.githubusercontent.com/STAR-ZERO/backlog2slack/master/doc/screenshot.png)

---

## 環境

開発で使用した環境になります。他の環境は試してません。

* Mac OS 10.9.4
* Ruby 2.1.2

## Setup

```
$ git clone git@github.com:STAR-ZERO/backlog2slack.git
$ cd backlog2slack
$ bundle install
$ mv config/config_sample.yaml config/config.yaml
```

## 設定

`config/config.yaml`を編集する。

### 共通

| 項目 | 必須 | 内容 |
|---|---|---|
| interval | ◯ | 作成、更新をチェックする間隔（分） |

### backlog

Backlogに関する設定

| 項目 | 必須 | 内容 |
|---|---|---|
| space | ◯ | Backlogのスペース名 |
| api_key | ◯ | Backlog API Key |

* Backlog API Keyについては[ここ](http://www.backlog.jp/help/usersguide/personal-settings/userguide2378.html)を参照

### slack

Slackに関する設定

| 項目 | 必須 | 内容 |
|---|---|---|
| team | ◯ | Slackチーム名 |
| token | ◯ | Incoming WebHooksのTOKEN |
| channel | ◯ | Slackに通知するチャンネル（先頭の`#`は不要） |
| username |  | Slackに送信者として表示される名前 |
| icon_url |  | Slackに表示されるアイコン画像URL |
| icon_emoji |  | Slackに表示されるアイコン絵文字 |

* Slackの設定は[slack-notify](https://github.com/sosedoff/slack-notify)と同様

### user

BacklogのユーザーIDとSlackのユーザー名を関連付けます。

yamlのキーにBacklogユーザーID、値にSlackのユーザー名を設定します。

下記の場合は`0000`がBacklogのユーザーIDで、それに対応するSlackユーザーが`star-zero`となります。

```
user:
  0000: star_zero
  0001: hoge
```

---

BacklogのユーザーIDの調べるには下記のコマンドを実行します。

`config/config.yaml`のBacklog設定をする必要があります。

管理者権限が必要です。

```
$ ./backlog2slack member
id:0000 name:xxxx mail:xxxx@vvvv.nn.mm
...
...
```

idの隣に載っている数字がBacklogユーザーIDになります。

## 使い方

下記のコマンドで実行します。

`config/config.yaml`の`interval`に設定されている値の過去から現在まででBacklogに作成・更新された課題を通知します。

```
$ ./backlog2slack
```

### clockwrok

定期実行するには [Clockwork](https://github.com/tomykaira/clockwork) を使います。

```
$ clockwork clock.rb
```

[Clockwork](https://github.com/tomykaira/clockwork) についてはリポジトリのほうを参照してください。

## 注意

* 課題のコメントがあった場合は現状で通知されません。


