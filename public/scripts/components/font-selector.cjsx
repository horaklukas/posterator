React = require 'react'

class FontSelector extends React.Component
  handleChange: ({target}) =>
    @props.onChange? 'family', target.value

  createFontOption: (fontName) ->
    style = fontFamily: fontName
    key = fontName.toLowerCase().replace ' ', '_'

    <option style={style} value={fontName} key={key}>
      {fontName}
    </option>

  render: ->
    <div className="font-selector">
      <span className="label">Font family</span>
      <select value={@props.selected} onChange={@handleChange}>
        {@props.fonts.map @createFontOption}
      </select>
    </div>

module.exports = FontSelector