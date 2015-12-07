React                 = require 'react'
RaisedButton          = require 'material-ui/lib/raised-button'
FlatButton            = require 'material-ui/lib/flat-button'
Dialog                = require 'material-ui/lib/dialog'
TextField             = require 'material-ui/lib/text-field'
List                  = require 'material-ui/lib/lists/list'
ListDivider           = require 'material-ui/lib/lists/list-divider'
ListItem              = require 'material-ui/lib/lists/list-item'
Avatar                = require 'material-ui/lib/avatar'

module.exports = class Users extends React.Component
  render: ->
    <div>
      <h2> Manage users</h2>

      <RaisedButton
        style={margin: 10}
        label="Add user"
        onClick = { =>
          @setState dialog: yes
        }
      />

      <Dialog
        title = "Add user"
        open = {@state.dialog}
        actions = {[
          <FlatButton label="Add user"
            style = {color: "green"}
            onClick = { =>
              @props.onNewUser
                email    : @refs.email.getValue()
                password : @refs.password.getValue()
              email    : @refs.email.clearValue()
              password : @refs.password.clearValue()
              @setState dialog: no }
          />
          <FlatButton label="Cancel"
            onClick = { => @setState dialog: no }
          />
        ]}
      >
        <TextField
          ref="email"
          floatingLabelText="email"
        />
        <TextField
          ref="password"
          floatingLabelText="password"
          type="password"
        />
      </Dialog>

      <List>
        { if @props.users is null
            <h4>
              Add a user to get started.
            </h4>
          else
            for key, user of @props.users
              do =>
                name = key
                <ListItem key={key} primaryText={user.email} leftAvatar={<Avatar src="http://www.material-ui.com/images/uxceo-128.jpg" />}
                />

        }
      </List>

    </div>

  constructor: ->
    @state = dialog: no
