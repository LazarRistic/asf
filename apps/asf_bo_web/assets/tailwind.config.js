const colors = require('tailwindcss/colors')

module.exports = {
  purge: [
    '../lib/**/*.ex',
    '../lib/**/*.leex',
    '../lib/**/*.eex',
    './js/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      listStyleType: 'list-disc',
      listStylePosition: 'list-inside'
    },
    colors: {
      transparent: 'transparent',
      current: 'currentColor',
      black: colors.black,
      white: colors.white,
      gray: colors.trueGray,
      indigo: colors.indigo,
      red: colors.rose,
      yellow: colors.amber,
      green: colors.green,
      blue: colors.blue,
      purple: colors.violet,
      pink: colors.pink,
      primary: ({ opacityVariable, opacityValue }) => {
        if (opacityValue !== undefined) {
          return `rgba(var(--color-primary), ${opacityValue})`
        }
        if (opacityVariable !== undefined) {
          return `rgba(var(--color-primary), var(${opacityVariable}, 1))`
        }
        return `rgb(var(--color-primary))`
      },
      secondary: ({ opacityVariable, opacityValue }) => {
        if (opacityValue !== undefined) {
          return `rgba(var(--color-secondary), ${opacityValue})`
        }
        if (opacityVariable !== undefined) {
          return `rgba(var(--color-secondary), var(${opacityVariable}, 1))`
        }
        return `rgb(var(--color-secondary))`
      },
      tertiary: ({ opacityVariable, opacityValue }) => {
        if (opacityValue !== undefined) {
          return `rgba(var(--color-tertiary), ${opacityValue})`
        }
        if (opacityVariable !== undefined) {
          return `rgba(var(--color-tertiary), var(${opacityVariable}, 1))`
        }
        return `rgb(var(--color-tertiary))`
      },
    }
  },
  variants: {
    extend: {
      backgroundColor: ['checked'],
      borderColor: ['checked'],
    },
  },
  plugins: [
    require('@tailwindcss/custom-forms'),
  ],
}
