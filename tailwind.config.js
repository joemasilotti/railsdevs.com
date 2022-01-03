const defaultTheme = require("tailwindcss/defaultTheme")
const colors = require("tailwindcss/colors")

module.exports = {
  plugins: [
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require('@tailwindcss/line-clamp'),
  ],

  content: [
    "./app/assets/**/*.svg",
    "./app/components/**/*.{rb,html,html.erb,yml}",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/models/field_error_tag_builder.rb",
    "./app/views/**/*.html.erb",
    "./config/utility_classes.yml"
  ],

  theme: {
    extend: {
      colors: {
        red: colors.rose,
      },
      fontFamily: {
        sans: ["Inter var", ...defaultTheme.fontFamily.sans],
        serif: ["Merriweather", "serif"],
      },
      animation: {
        "reverse-spin": "reverse-spin 1.5s linear infinite"
      },
      keyframes: {
        "reverse-spin": {
          from: {
            transform: "rotate(360deg)"
          },
        },
      },
    },
  },
}
