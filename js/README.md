# Web Frontend

## How to develop

Run `docker compose up -d` and see `localhost:3000` in your browser.
Your code change will be automatically detected and reflected to the opened app.
If you want to run some commands like `yarn add XXX`, then you can run `docker compose exec app bash` first.

## Discussion Points

- [x] Dark mode support / Design System (CSS vs Chakura-UI)
  - [Chakra UI でブランドカラーを適用させる方法について調べてみた](https://dev.classmethod.jp/articles/chakra-ui-theme/)
- [ ] How to configure CSS
  - [React におけるスタイリング手法まとめ](https://zenn.dev/chiji/articles/b0669fc3094ce3)
- [ ] JS vs TS (Frontend migration)
  - [CS Tool のフロントエンドのリプレイスプロジェクトについて](https://engineering.mercari.com/blog/entry/20230112-frontend-replacement/)
- [ ] React vs Next
- [ ] REST vs GraphQL
