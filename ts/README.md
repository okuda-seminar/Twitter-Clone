# Web Frontend

## How to develop

Run `mkdir ./twitter/node_modules; docker compose up -d` and see `localhost:3000` in your browser.
Your code change will be automatically detected and reflected to the opened app.
If you want to run some commands like `yarn add XXX`, then you can run `docker compose exec app bash` first.

## Note

You need to use VSCode and install [Prettier formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode).
For consistent readability, you can refer to [Google's style guide](https://google.github.io/styleguide/tsguide.html).

## Discussion Points

- [x] Dark mode support / Design System (CSS vs Chakura-UI)
  - [Chakra UI でブランドカラーを適用させる方法について調べてみた](https://dev.classmethod.jp/articles/chakra-ui-theme/)
- [ ] How to configure CSS
  - [React におけるスタイリング手法まとめ](https://zenn.dev/chiji/articles/b0669fc3094ce3)
- [x] JS vs TS (Frontend migration)
  - [CS Tool のフロントエンドのリプレイスプロジェクトについて](https://engineering.mercari.com/blog/entry/20230112-frontend-replacement/)
  - [Why and How to use TypeScript in your React App?](https://blog.bitsrc.io/why-and-how-use-typescript-in-your-react-app-60e8987be8de)
- [x] React vs Next
- [ ] REST vs GraphQL
- [ ] Localization
  - [React の多言語化 (i18n) 対応 - Format.JS vs react-i18next](https://blogs.jp.infragistics.com/entry/react-localization-libraries)
- [x] Jest
- [x] Cypress
  - [メルペイフロントエンドのテスト自動化方針](https://engineering.mercari.com/blog/entry/20211208-test-automation-policy-in-merpay-frontend/)