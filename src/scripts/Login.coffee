React         = require 'react'

module.exports = class Login extends React.Component
  render: ->
    <div>
      Login
      <input type="email" ref="email"/>
      <input type="password" ref="password"/>
      <button
        onClick = { =>
          credentials = {}
          for key in Object.keys @refs
            credentials[key] = @refs[key].value
          @props.onLogin credentials
        }
      >
        Submit
      </button>

    </div>
