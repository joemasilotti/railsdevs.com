const defaultTheme = require('tailwindcss/defaultTheme')
const colors = require("tailwindcss/colors")

module.exports = {
  mode: "jit",

  plugins: [
    require('@tailwindcss/forms'),
  ],

  purge: [
    "./app/views/**/*.html.erb",
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
    },
  },

  variants: {
    extend: {
      borderColor: ["focus-visible"],
      opacity: ["disabled"],
    }
  }
}
