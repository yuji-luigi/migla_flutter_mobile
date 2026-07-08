// Queries for the public (unauthenticated) website content:
// pages flagged with `showInMobileApp`, plus the Header/Footer globals.

/// Full public content in one round trip.
const String publicContentQuery = r'''
query PublicContent($locale: LocaleInputType!) {
  Pages(
    locale: $locale
    limit: 50
    where: {
      AND: [
        { showInMobileApp: { equals: true } }
        { _status: { equals: published } }
      ]
    }
  ) {
    docs {
      id
      title
      slug
      updatedAt
      hero {
        type
        richText
        media {
          id
          url
          filename
          mimeType
        }
        links {
          link {
            type
            newTab
            url
            label
            appearance
            reference {
              relationTo
              value {
                ... on Page {
                  slug
                  title
                }
                ... on Post {
                  slug
                  title
                }
              }
            }
          }
        }
      }
      layout {
        ... on CallToActionBlock {
          blockType
          showInMobileApp
          richText
          links {
            link {
              type
              newTab
              url
              label
              appearance
              reference {
                relationTo
                value {
                  ... on Page {
                    slug
                    title
                  }
                  ... on Post {
                    slug
                    title
                  }
                }
              }
            }
          }
        }
        ... on ContentBlock {
          blockType
          showInMobileApp
          columns {
            size
            richText
            enableLink
            link {
              type
              newTab
              url
              label
              reference {
                relationTo
                value {
                  ... on Page {
                    slug
                    title
                  }
                  ... on Post {
                    slug
                    title
                  }
                }
              }
            }
          }
        }
        ... on MediaBlock {
          blockType
          showInMobileApp
          media {
            id
            url
            filename
            mimeType
          }
        }
        ... on ArchiveBlock {
          blockType
          showInMobileApp
          introContent
        }
        ... on FormBlock {
          blockType
          showInMobileApp
          enableIntro
          introContent
        }
      }
    }
  }
  Header(locale: $locale) {
    updatedAt
    navItems {
      showInMobileApp
      link {
        type
        newTab
        url
        label
        reference {
          relationTo
          value {
            ... on Page {
              slug
              title
            }
            ... on Post {
              slug
              title
            }
          }
        }
      }
    }
  }
  Footer(locale: $locale) {
    updatedAt
    navItems {
      showInMobileApp
      link {
        type
        newTab
        url
        label
        reference {
          relationTo
          value {
            ... on Page {
              slug
              title
            }
            ... on Post {
              slug
              title
            }
          }
        }
      }
    }
  }
}
''';

/// Lightweight version probe: page ids + updatedAt, plus the FULL
/// Header/Footer navItems.
///
/// Payload does NOT bump a global's `updatedAt` on update, so the version
/// is computed from the navItems content itself (hashed in
/// PublicContentCache.computeVersion). The Header/Footer selections here
/// MUST stay byte-identical to the ones in [publicContentQuery] — the hash
/// compares the JSON of both responses, so a differing selection would
/// make every probe look like new content.
const String publicContentVersionQuery = r'''
query PublicContentVersion($locale: LocaleInputType!) {
  Pages(
    limit: 100
    where: {
      AND: [
        { showInMobileApp: { equals: true } }
        { _status: { equals: published } }
      ]
    }
  ) {
    docs {
      id
      updatedAt
    }
  }
  Header(locale: $locale) {
    updatedAt
    navItems {
      showInMobileApp
      link {
        type
        newTab
        url
        label
        reference {
          relationTo
          value {
            ... on Page {
              slug
              title
            }
            ... on Post {
              slug
              title
            }
          }
        }
      }
    }
  }
  Footer(locale: $locale) {
    updatedAt
    navItems {
      showInMobileApp
      link {
        type
        newTab
        url
        label
        reference {
          relationTo
          value {
            ... on Page {
              slug
              title
            }
            ... on Post {
              slug
              title
            }
          }
        }
      }
    }
  }
}
''';
