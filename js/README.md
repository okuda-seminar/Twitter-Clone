# Web Frontend

## How to develop

Run `docker compose up -d` and see `localhost:3000` in your browser.
Your code change will be automatically detected and reflected to the opened app.
If you want to run some commands like `yarn add XXX`, then you can run `docker compose exec app bash` first.

## Note

You need to use VSCode and install [Prettier formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode).
For consistent readability, you can refer to [Google's style guide](https://google.github.io/styleguide/jsguide.html).
Though TS is recommend, we can still start with JS first and truly understand why
JS is not encouraged to use.

## Discussion Points

- [x] Dark mode support / Design System (CSS vs Chakura-UI)
  - [Chakra UI でブランドカラーを適用させる方法について調べてみた](https://dev.classmethod.jp/articles/chakra-ui-theme/)
- [ ] How to configure CSS
  - [React におけるスタイリング手法まとめ](https://zenn.dev/chiji/articles/b0669fc3094ce3)
- [ ] JS vs TS (Frontend migration)
  - [CS Tool のフロントエンドのリプレイスプロジェクトについて](https://engineering.mercari.com/blog/entry/20230112-frontend-replacement/)
- [ ] React vs Next
- [ ] REST vs GraphQL
- [ ] Localization
  - [React の多言語化 (i18n) 対応 - Format.JS vs react-i18next](https://blogs.jp.infragistics.com/entry/react-localization-libraries)
