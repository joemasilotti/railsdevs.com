const defaultTheme = require("tailwindcss/defaultTheme")
const colors = require("tailwindcss/colors")

module.exports = {
  mode: "jit",

  plugins: [
    require("@tailwindcss/forms"),
    require('@tailwindcss/aspect-ratio'),
  ],

  purge: [
    "./app/views/**/*.html.erb",
    "./app/components/**/*.rb",
    "./app/components/**/*.html.erb",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js"
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
