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
    "./app/components/**/*.{rb,html,yml}?(+*)?(.erb)",
    "./app/helpers/**/*.rb",
    "./app/javascript/**/*.js",
    "./app/models/field_error_tag_builder.rb",
    "./app/views/**/*.html.erb",
    "./config/utility_classes.yml"
  ],

  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      gray: colors.neutral,
      white: colors.white,
      navy: {
        DEFAULT: "#141B2F",
        mid: "#898D97",
        lightest: "#E7E8EA"
      },
      salmon: {
        dark: "#E71A04",
        DEFAULT: "#FC6250",
        mid: "#FEB1A7",
        light: "#FFE7E5",
        lighest: "#FFF7F6"
      },
      teal: {
        dark: "#18766F",
        DEFAULT: "#1E9188",
        mid: "#8EC8C3",
        lightest: "#E8F4F3"
      },
      green: {
        dark: "#3B6039",
        DEFAULT: "#80CB7B",
        hover: "#93D28E",
        mid: "#BFE5BD",
        lightest: "#DFF2DE"
      },
      typography: {
        DEFAULT: "#333333"
      }
    },
    fontFamily: {
      sans: ["DM Sans", ...defaultTheme.fontFamily.sans],
      mono: ["Source Code Pro", "serif"],
      heading: ["Poppins", ...defaultTheme.fontFamily.sans]
    },
    fontSize: {
      "xs": ["12px", "18px"],
      "sm": ["14px", "21px"],
      "base": ["16px", "24px"],
      "xl": ["20px", "30px"],
      "2xl": ["24px", "36px"],
      "3xl": ["30px", "45px"],
      "4xl": ["36px", "54px"],
      "5xl": ["54px", "81px"]
    },
    extend: {
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
