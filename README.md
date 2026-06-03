# neovim
neovimの設定

> `<leader>` はスペースキー

## キーマッピング一覧

### 基本操作

| キー | モード | 動作 |
|------|--------|------|
| `jj` | Insert | ノーマルモードへ戻る |
| `v` | Visual | 行末（空白除く）まで選択 |
| `<ESC>` | Normal | 検索ハイライトを消す |

### ウィンドウ移動

| キー | モード | 動作 |
|------|--------|------|
| `<C-h>` / `sh` | Normal | 左のウィンドウへ移動 |
| `<C-j>` / `sj` | Normal | 下のウィンドウへ移動 |
| `<C-k>` / `sk` | Normal | 上のウィンドウへ移動 |
| `<C-l>` / `sl` | Normal | 右のウィンドウへ移動 |

### ウィンドウ分割・リサイズ

| キー | モード | 動作 |
|------|--------|------|
| `ss` | Normal | 水平分割 |
| `sv` | Normal | 垂直分割 |
| `+` | Normal | ウィンドウを縦に5px拡大 |
| `-` | Normal | ウィンドウを縦に5px縮小 |

### タブ・バッファ操作

| キー | モード | 動作 |
|------|--------|------|
| `te` | Normal | 新しいタブを開く |
| `tn` | Normal | 次のバッファへ移動 |
| `tp` | Normal | 前のバッファへ移動 |

### ファイル操作

| キー | モード | 動作 |
|------|--------|------|
| `==` | Normal | Netrwのトグル（左サイドに表示） |
| `<leader>fp` | Normal | カレントファイルのパスをクリップボードにコピー |

### LSP

| キー | モード | 動作 |
|------|--------|------|
| `gd` | Normal | 定義へジャンプ |
| `gt` | Normal | 型定義へジャンプ |
| `gi` | Normal | 実装へジャンプ |
| `gr` | Normal | 参照一覧 |
| `K` | Normal | ホバードキュメント表示 |
| `<C-k>` | Insert | シグネチャヘルプ |
| `<leader>rn` | Normal | リネーム |
| `<leader>ca` | Normal | コードアクション |
| `]d` | Normal | 次の診断エラーへ |
| `[d` | Normal | 前の診断エラーへ |
| `<leader>d` | Normal | 診断エラーをフロートで表示 |

### Telescope

| キー | モード | 動作 |
|------|--------|------|
| `<leader>ff` | Normal | ファイル検索（隠しファイル含む） |
| `<leader>lg` | Normal | Live Grep（文字列検索） |
| `<leader>fb` | Normal | カレントバッファのディレクトリでファイルブラウザを開く |
| `<C-t>` | Insert/Normal | Telescope内の選択ファイルをiTermで開く（要`WORKSPACE_DIR`環境変数） |

### ToggleTerm / LazyGit

| キー | モード | 動作 |
|------|--------|------|
| `<leader>tt` | Normal | ターミナルのトグル |
| `<esc>` | Terminal | ターミナルモードを抜ける |
| `<leader>gt` | Normal | LazyGitのトグル |

### Copilot

| キー | モード | 動作 |
|------|--------|------|
| `<C-Right>` | Insert | 1単語分の提案を承認 |
| `<M-]>` | Insert | 次の提案へ |
| `<M-[>` | Insert | 前の提案へ |
| `<C-]>` | Insert | 提案を却下 |

### CopilotChat

| キー | モード | 動作 |
|------|--------|------|
| `<leader>ocs` | Normal | CopilotChatウィンドウのトグル |
| `<leader>ccq` | Normal | バッファ全体を使ってCopilotにクイック質問 |
| `<leader>ccp` | Normal | Telescopeでアクションプロンプトを選択 |
