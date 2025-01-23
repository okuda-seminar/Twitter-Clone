# Web Frontend

## How to develop
1. Set up environment variables (in the X-Clone-Backend directory)
```
$ cp .env.sample .env
```

2. Start the backend server (in the X-Clone-Backend directory)
```
$ make build
$ make up
$ make exec_app
$ go run ./cmd
```

3. Set up environment variables (in the Twitter-Clone directory)
```
$ cd ts/twitter
$ cp .env.sample .env.local
```
If you'd like to use a specific user account, you can set the user ID in the .env.local file.

4. Start the frontend server (in the Twitter-Clone directory)
```
$ cd twitter
$ chmod +x setup.sh
$ ./setup.sh
$ yarn dev
```
and see `localhost:3000` in your browser.
Your code change will be automatically detected and reflected to the opened app.

## How to test
```
$ cd twitter
$ yarn test
```


## Note

You need to use VSCode and install [Prettier formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode).
For consistent readability, you can refer to [Google's style guide](https://google.github.io/styleguide/tsguide.html).
We don't use Docker for two main reasons:

- File I/O overhead, especially on Docker for MacOS, significantly impacts development experience
- Network configuration complexity when integrating with services in separate Docker Compose networks

Our frontend toolchain performs efficiently without the Docker virtualization layer.

## Discussion Points

- [x] Dark mode support / Design System (CSS vs Chakura-UI)
  - [Chakra UI でブランドカラーを適用させる方法について調べてみた](https://dev.classmethod.jp/articles/chakra-ui-theme/)
- [ ] How to configure CSS
  - [React におけるスタイリング手法まとめ](https://zenn.dev/chiji/articles/b0669fc3094ce3)
- [x] JS vs TS (Frontend migration)
  - [CS Tool のフロントエンドのリプレイスプロジェクトについて](https://engineering.mercari.com/blog/entry/20230112-frontend-replacement/)
  - [Why and How to use TypeScript in your React App?](https://blog.bitsrc.io/why-and-how-use-typescript-in-your-react-app-60e8987be8de)
- [x] React vs Next
- [ ] GraphQL
  - [GraphQL Client Architecture Recommendation 社外版](https://engineering.mercari.com/blog/entry/20221215-graphql-client-architecture-recommendation/)
- [ ] Localization
  - [React の多言語化 (i18n) 対応 - Format.JS vs react-i18next](https://blogs.jp.infragistics.com/entry/react-localization-libraries)
- [x] Jest
- [x] Cypress
  - [メルペイフロントエンドのテスト自動化方針](https://engineering.mercari.com/blog/entry/20211208-test-automation-policy-in-merpay-frontend/)
- [ ] WebView
  - [メルカリアプリのWebView向けWebアプリケーションの開発を支えるモック技術](https://engineering.mercari.com/blog/entry/2019-12-21-000000/)

## Evaluation
- [フロントエンドチームの技術課題評価システム改善の取り組み](https://engineering.mercari.com/blog/entry/20231023-mmtf2023-day1-7/)
