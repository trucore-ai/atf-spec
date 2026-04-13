---
title: Metadata & Frontmatter Schema Reference
summary: Field definitions, examples, and rules for metadata used across TruCore-site pages and atf-spec docs.
layer: public
audience: human
status: guide
product_area: [documentation, governance]
related_pages: [docs/CONTENT_MAP.md]
---

# Metadata & Frontmatter Schema Reference

This document defines the metadata and frontmatter schemas used across TruCore documentation surfaces. Contributors should follow these patterns when adding or updating docs.

---

## 1. atf-spec Frontmatter (Markdown files)

All public spec and docs files in `atf-spec` use YAML frontmatter.

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `title` | string | yes | Human-readable page title. |
| `summary` | string | yes | One-sentence description of the document's purpose. |
| `layer` | `"public"` | yes | Always `public` for files in this repo. |
| `audience` | `"human"` \| `"agent"` \| `"both"` | yes | Primary audience. Use `both` for spec docs consumed by humans and machines. |
| `status` | `"spec"` \| `"guide"` \| `"tutorial"` \| `"canonical"` \| `"map"` | yes | Document type. See status values below. |
| `product_area` | string[] | yes | One or more product areas (e.g., `[receipts, verification]`). |
| `related_pages` | string[] | no | Relative paths to related files within the repo. |
| `site_ref` | string | no | Corresponding TruCore-site route (e.g., `/docs/receipt-specification-v1`). |

### Status values

| Value | Use when |
| --- | --- |
| `spec` | Normative specification document (receipt schema, verification, architecture). |
| `guide` | Explanatory or how-to content for developers. |
| `tutorial` | Step-by-step walkthrough (hello-world-bot). |
| `canonical` | Authoritative reference (content map, glossary). |
| `map` | Navigation or index document. |

### Example: Public spec doc

```yaml
---
title: ATF Receipt Specification
summary: Normative receipt schema — fields, types, deterministic content_hash computation, and verification rules.
layer: public
audience: both
status: spec
product_area: [receipts, verification]
site_ref: /docs/receipt-specification-v1
---
```

### Example: Public tutorial

```yaml
---
title: Hello-World Bot
summary: Side-by-side Python scripts showing an unprotected bot vs an ATF-protected bot.
layer: public
audience: human
status: tutorial
product_area: [onboarding, integration]
site_ref: /docs/hello-world-bot
---
```

---

## 2. TruCore-site Page Metadata (Next.js `Metadata` export)

All public `page.tsx` files under `app/docs/` export a `Metadata` object.

### Fields

| Field | Required | Description |
| --- | --- | --- |
| `title` | yes | Page title with `\| TruCore` or `\| TruCore ATF` suffix. |
| `description` | yes | Factual, page-specific description (1–2 sentences). |
| `keywords` | yes | Array of 5–10 relevant search terms. |
| `openGraph.title` | yes | Same as or shortened version of `title`. |
| `openGraph.description` | yes | Same as or shortened version of `description`. |
| `openGraph.url` | yes | Canonical URL (`https://trucore.xyz/docs/{slug}`). |
| `openGraph.images` | yes | `["/opengraph-image"]` unless a page-specific OG image exists. |
| `twitter.card` | yes | Always `"summary_large_image"`. |
| `twitter.title` | yes | Same as `openGraph.title`. |
| `twitter.description` | yes | Same as or shortened version of `openGraph.description`. |
| `twitter.images` | yes | Same as `openGraph.images`. |
| `alternates.canonical` | yes | Canonical URL matching `openGraph.url`. |
| `robots` | no | Override only when needed (e.g., `{ index: true, follow: true }`). |

### Example: Public docs page

```typescript
export const metadata: Metadata = {
  title: "Getting Started | TruCore ATF",
  description:
    "Create an account, get an API key, and protect your first trade with ATF in minutes.",
  keywords: [
    "ATF getting started",
    "agent transaction firewall",
    "API key setup",
    "first protected trade",
    "developer onboarding",
    "TruCore ATF",
  ],
  openGraph: {
    title: "Getting Started | TruCore ATF",
    description:
      "Create an account, get an API key, and protect your first trade with ATF in minutes.",
    url: "https://trucore.xyz/docs/getting-started",
    images: ["/opengraph-image"],
  },
  twitter: {
    card: "summary_large_image",
    title: "Getting Started | TruCore ATF",
    description:
      "Create an account, get an API key, and protect your first trade with ATF in minutes.",
    images: ["/opengraph-image"],
  },
  alternates: { canonical: "https://trucore.xyz/docs/getting-started" },
};
```

---

## 3. Rules

### Public vs authenticated docs

- **Public pages** (`app/docs/*`): always include full metadata (OG, twitter, keywords, canonical).
- **Authenticated pages** (`app/docs/guide/*`): minimal metadata only. Do not add OG/twitter/canonical — these pages are behind auth and should not appear in search or social previews.
- **Public discovery files** (`llms.txt`, `sitemap.ts`, `atf.json`): never reference authenticated pages.

### Title conventions

- TruCore-site: append `| TruCore` or `| TruCore ATF` to titles.
- atf-spec: use the document's natural title without site branding.

### Canonical URLs

- Always use `https://trucore.xyz/docs/{slug}` for TruCore-site pages.
- For atf-spec, use `site_ref` to point to the corresponding TruCore-site page when one exists.

### Keywords

- 5–10 terms per page.
- Include the page's primary topic, ATF-specific terminology, and "TruCore ATF".
- Do not stuff keywords — keep them relevant to the page content.
