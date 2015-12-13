React         = require 'react'
TextField     = require 'material-ui/lib/text-field'
RaisedButton  = require 'material-ui/lib/raised-button'

module.exports = class Login extends React.Component
  render: ->
    <div>
      <div>
        <TextField
          type="email"
          ref="email"
          floatingLabelText="email"
        />
      </div>
      <div>
        <TextField
          type="password"
          ref="password"
          floatingLabelText="password"
        />
      </div>
      <div>
        <RaisedButton
          secondary={true}
          onClick = { =>
            credentials = {}
            for key in Object.keys @refs
              credentials[key] = @refs[key].getValue()
            @props.onLogin credentials
          }
        >
          Login
        </RaisedButton>
        <span> or </span>
        <RaisedButton
          onClick = { =>
            credentials = {}
            for key in Object.keys @refs
              credentials[key] = @refs[key].getValue()
            @props.onRegister credentials
          }
        >
          Register
        </RaisedButton>
      </div>

    </div>
