React      = require 'react'
RDOM       = require 'react-dom'
Doors      = require './Doors'
History    = require './History'
Open       = require './Open'
Login      = require './Login'

# Material-ui styles
Dialog     = require 'material-ui/lib/dialog'
FlatButton = require 'material-ui/lib/flat-button'
RaisedButton = require 'material-ui/lib/raised-button'

do require 'react-tap-event-plugin'
Tabs       = require 'material-ui/lib/tabs/tabs'
Tab        = require 'material-ui/lib/tabs/tab'

# Database
Firebase   = require 'firebase'
database   = new Firebase 'https://clay-app.firebaseio.com/'
doors      = database.child 'doors'
history    = database.child 'history'


class Main extends React.Component
  render: ->
    <div className="app">

      {
        if not @state.user?
          <div>
            <h1>Welcome to the Open door test application</h1>
            <h4>Please log in or register to get started</h4>
            <Login
              onLogin = { @login }
              onRegister = { (credentials) =>
                database.createUser credentials, (error, userData) =>
                  if error
                    return console.error "Error creating user:", error
                  @login credentials

                  console.log "Successfully created user account with uid:", userData.uid
              }
            />
          </div>
        else

          <div>
            <Tabs>
              <Tab label="Manage doors" >
                <Doors
                  doors = { @state.doors }
                  onNewDoor = { (door) =>
                    # Create new collection of doors with name equal @state.user (uid)
                    # Push door object to this new collection
                    (doors.child @state.user).push door
                  }
                  onClear = { (name) =>
                    doors
                      .child @state.user
                      .child name
                      .remove()
                  }
                />

              </Tab>

              <Tab label="Open doors" >
                <Open
                  doors = { @state.doors }
                  onDoorOpen = { (event) =>
                    history
                      .child @state.user
                      .push event
                  }
                />
              </Tab>

              <Tab label="History" >
                <History
                  history = {@state.history}
                />
              </Tab>
            </Tabs>

            <RaisedButton
              style={margin: 10}
              label="Log out"
              onClick = { =>
                database.unauth()
                @setState user: null
              }
            />
          </div>
      }
    </div>

  constructor: ->
    @state = doors: {}, history: {}, user: null

  componentWillMount: ->

    @setupUser database.getAuth()

  login: (credentials) =>
    database.authWithPassword credentials, (error, authData) =>
      if error
        return console.error "Login error", error
      @setupUser authData

  setupUser: (authData) ->
    if not authData then return
    user = authData.uid
    @setState {user}

    doors
      .child user
      .on 'value', (snapshot) =>
        @setState doors: snapshot.val()

    # Join properties from two arrays: history and doors
    # Request history on every change of its value
    history
      .child user
      .on 'value', (snapshot) =>
        # Take a value from history snapshot
        events = snapshot.val()
        # Request for doors once and wait for the answer
        doors
          .child user
          .on 'value', (snapshot) =>
            # Take value from items snapshot
            items = snapshot.val()
            # For each event, take door description and put it into door property of event
            for uid, event of events
              door = items?[event.door]
              event.doorObject = door
            # Set state of history to the current events, with new door property.
            @setState history: events
            #Each door property in event has the description from doors array.

element = React.createElement Main
RDOM.render element, document.querySelector '.container'
