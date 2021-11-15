const defaultTheme = require("tailwindcss/defaultTheme")
const colors = require("tailwindcss/colors")

module.exports = {
  mode: "jit",

  plugins: [
    require("@tailwindcss/forms"),
    require('@tailwindcss/aspect-ratio'),
  ],

  purge: [
    "./app/components/**/*.{rb,html,html.erb,yml}",
    "./app/helpers/**/*.rb",
    "./config/initializers/form_errors.rb",
    "./app/javascript/**/*.js",
    "./config/utility_classes.yml",
    "./app/views/**/*.html.erb",
  ],

  theme: {
    extend: {
      colors: {
        gray: colors.coolGray,
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

  variants: {
    extend: {
      borderColor: ["focus-visible"],
      opacity: ["disabled"],
    }
  }
}
