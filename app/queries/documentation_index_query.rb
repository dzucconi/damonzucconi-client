# frozen_string_literal: true

DocumentationIndexQuery = DamonZucconiAPI::Client.parse <<-'GRAPHQL'
  query($state: [State], $width: Int, $height: Int, $scale: Float) {
    artworks(state: $state) {
      title
      description(format: HTML)
      year
      dimensions {
        centimeters {
          to_s
        }
        inches {
          to_s
        }
      }
      material
      duration
      collector_byline
      src
      images(state: PUBLISHED) {
        url
        width
        height
        thumb: resized(width: $width, height: $height, scale: $scale) {
          width
          height
          urls {
            _1x
            _2x
          }
        }
      }
    }
  }
GRAPHQL
