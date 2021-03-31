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
  },
  variants: {
    extend: {},
  },
  plugins: [],
}