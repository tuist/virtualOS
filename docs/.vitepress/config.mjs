import { defineConfig } from "vitepress";
import { atom01Icon } from "./icons.mjs";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "virtualOS",
  titleTemplate: ":title | virtualOS",
  srcDir: "content",
  lastUpdated: true,
  description: "A virtualization CLI for macOS environments",
  cleanUrls: true,
  sitemap: {
    hostname: "https://virtualos.tuist.dev",
  },
  head: [
    [
      "meta",
      { property: "og:url", content: "https://virtualos.tuist.dev" },
      "",
    ],
    ["meta", { property: "og:type", content: "website" }, ""],
    [
      "meta",
      { property: "og:image", content: "https://virtualos.tuist.dev/og.jpeg" },
      "",
    ],
    ["meta", { name: "twitter:card", content: "summary" }, ""],
    [
      "meta",
      { property: "twitter:domain", content: "virtualos.tuist.dev" },
      "",
    ],
    [
      "meta",
      { property: "twitter:url", content: "https://virtualos.tuist.dev" },
      "",
    ],
    [
      "meta",
      {
        name: "twitter:image",
        content: "https://virtualos.tuist.dev/og.jpeg",
      },
      "",
    ],
  ],
  themeConfig: {
    logo: "/logo.png",
    editLink: {
      pattern: "https://github.com/tuist/virtualos/edit/main/docs/:path",
    },
    nav: [
      { text: "Tuist", link: "https://tuist.dev" },
      { text: "Community", link: "https://community.tuist.dev" },
      { text: "Slack", link: "https://slack.tuist.dev" },
    ],
    search: {
      provider: "local",
    },
    sidebar: [
      {
        text: `<div style="display: flex; flex-direction: row; align-items: center; gap: 7px;">virtualOS ${atom01Icon()}</div>`,
        link: "/",
        items: [{ text: "Markdown Examples", link: "/markdown-examples" }],
      },
    ],
    editLink: {
      pattern:
        "https://github.com/tuist/virtualos/edit/main/docs/content/:path",
    },
    socialLinks: [
      { icon: "github", link: "https://github.com/tuist/tuist" },
      { icon: "bluesky", link: "https://bsky.app/profile/tuist.dev" },
      { icon: "mastodon", link: "https://fosstodon.org/@tuist" },
      {
        icon: "slack",
        link: "https://join.slack.com/t/tuistapp/shared_invite/zt-1y667mjbk-s2LTRX1YByb9EIITjdLcLw",
      },
    ],
    footer: {
      message: "Released under the MIT License.",
      copyright: "Copyright © 2024-present Tuist GmbH",
    },
  },
});
