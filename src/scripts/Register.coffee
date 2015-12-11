React         = require 'react'

module.exports = class Register extends React.Component
  render: ->
    <div>

      Register
      <input type="email" ref="email"/>
      <input type="password" ref="password"/>
      <button
        onClick = { =>
          credentials = {}
          for key in Object.keys @refs
            credentials[key] = @refs[key].value
          @props.onNewUser credentials
        }

      >
        Submit
      </button>

    </div>
